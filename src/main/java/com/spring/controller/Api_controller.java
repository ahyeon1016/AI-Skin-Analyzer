package com.spring.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.regex.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.vertexai.VertexAI;
import com.google.cloud.vertexai.api.GenerateContentResponse;
import com.google.cloud.vertexai.api.GenerationConfig;
import com.google.cloud.vertexai.generativeai.*;
import com.spring.domain.Information;
import com.spring.domain.memberDTO;
import com.spring.domain.surveyDTO;
import com.spring.service.SurveyServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/api")
public class Api_controller {

    @Autowired
    SurveyServiceImpl surveyService;

    // 입력 페이지
    @GetMapping("/gemini")
    public String gemini_form(@ModelAttribute Information information) {
        System.out.println("gemini로 이동");
        return "gemini";
    }

    @PostMapping("/gemini")
    public String geminiResult(
            @ModelAttribute Information information,
            HttpServletRequest request,
            Model model
    ) throws IOException {

        System.out.println("gemini에서 요청 발생");
        long startTime = System.currentTimeMillis();

        // 사용자 세션에서 설문 결과 가져오기
        HttpSession session = request.getSession();
        memberDTO member = (memberDTO) session.getAttribute("member");
        surveyDTO survey = surveyService.surveyRecive(member.getUser_id());

        String skinType = survey.getSkin_type();
        String sensScore = String.valueOf(survey.getSensitivity());
        String sensitivityLevel = "15점 만점 중 " + sensScore + "점";

        List<String> concernsList = new ArrayList<>();
        if (survey.getHydration()) concernsList.add("수분 부족");
        if (survey.getSensitive()) concernsList.add("예민/민감성");
        if (survey.getPimple()) concernsList.add("여드름");
        if (survey.getPigmentation()) concernsList.add("색소침착");
        if (survey.getAging()) concernsList.add("노화/탄력 저하");
        if (survey.getSkin_concern_other() != null && !survey.getSkin_concern_other().trim().isEmpty()) {
            concernsList.add("기타: " + survey.getSkin_concern_other());
        }
        String skinConcerns = concernsList.isEmpty() ? "특별한 고민 없음" : String.join(", ", concernsList);

        List<String> avoidsList = new ArrayList<>();
        if (survey.getParaben()) avoidsList.add("파라벤");
        if (survey.getPerfume()) avoidsList.add("인공 향료");
        if (survey.getEthanol()) avoidsList.add("에탄올");
        if (survey.getAvoid_ingredient_other() != null && !survey.getAvoid_ingredient_other().trim().isEmpty()) {
            avoidsList.add("기타: " + survey.getAvoid_ingredient_other());
        }
        String avoidedIngredients = avoidsList.isEmpty() ? "특별히 없음" : String.join(", ", avoidsList);

        // Information DTO
        //String question = information.getQuestion();
        MultipartFile photo = information.getPhoto();
        byte[] imageBytes = photo.getBytes();

        // Vertex 설정
        // 실제 Project ID는 src/main/resources/secret-config.txt의 PROJECT_ID에서 불러옴 (Git 제외)
        Properties secretConfig = new Properties();
        try (InputStream input = Api_controller.class.getClassLoader().getResourceAsStream("secret-config.txt")) {
            if (input == null) {
                throw new IOException("secret-config.txt 파일을 찾을 수 없습니다.");
            }
            secretConfig.load(input);
        }
        String projectId = secretConfig.getProperty("PROJECT_ID");
        String location = "us-central1";
        String modelName = "gemini-2.5-pro";

        // prompt 생성
        String prompt = generateAnalysisPrompt(skinType, skinConcerns, sensitivityLevel, avoidedIngredients);

        String text;
        try (VertexAI vertexAI = new VertexAI(projectId, location)) {

            // ✅ 1️ 세부 설정은 GenerationConfig로 지정
            GenerationConfig config = GenerationConfig.newBuilder()
                .setTemperature((float) 0.0)       // 무작위성 제거
                .setTopP((float) 1.0)              // 확률 누적 제한 해제
                .setTopK(1)                // 상위 1개만 선택
                .setCandidateCount(1)      // 응답 후보 1개
                .setMaxOutputTokens(8192)  // 최대 출력 길이 제한
                .build();

            // ✅ 2️ 모델에 설정 적용
            GenerativeModel modelAI = new GenerativeModel(modelName, vertexAI)
                .withGenerationConfig(config);

            // ✅ 3️ 이미지 + 텍스트 입력
            GenerateContentResponse response = modelAI.generateContent(
                ContentMaker.fromMultiModalData(new Object[] {
                    prompt,
                    PartMaker.fromMimeTypeAndData(photo.getContentType(), imageBytes)
                })
            );

            // ✅ 4️ 결과 텍스트 추출
            text = ResponseHandler.getText(response);
        }

        long executionTime = System.currentTimeMillis() - startTime;
        System.out.println("=== AI 응답 ===\n" + text);

        // ---------- 텍스트 파싱 ----------
        String productName = "", finalScore = "0";
        String summarySection = "", ingredientSection = "", allergySection = "", recommendationSection = "";

        // 제품명
        Pattern namePattern = Pattern.compile("'(.*?)'의 최종 분석 리포트");
        Matcher nameMatcher = namePattern.matcher(text);
        if (nameMatcher.find()) productName = nameMatcher.group(1);

        // 궁합점수 (숫자)/100점 인식 (태그 내 포함까지 대응)
        Pattern scorePattern = Pattern.compile(
        	    "(?i)궁합점수[^0-9\\(]*\\(?(\\d{1,3})\\)?\\s*/\\s*100점"
        );
        Matcher scoreMatcher = scorePattern.matcher(text);
        if (scoreMatcher.find()) {
            finalScore = scoreMatcher.group(1).trim();
            System.out.println("✅ 점수 인식 성공: " + finalScore);
        } else {
            System.out.println("❗점수 인식 실패 - 기본값 0");
        }


        // 각 섹션 추출
        summarySection = extractSection(text, "<section id=\"summary\">", "</section>");
        ingredientSection = extractSection(text, "<section id=\"ingredient\">", "</section>");
        allergySection = extractSection(text, "<section id=\"allergy\">", "</section>");
        recommendationSection = extractSection(text, "<section id=\"recommendation\">", "</section>");

        // 모델에 전달
        model.addAttribute("productName", productName);
        model.addAttribute("finalScore", finalScore);
        model.addAttribute("summarySection", summarySection);
        model.addAttribute("ingredientSection", ingredientSection);
        model.addAttribute("allergySection", allergySection);
        model.addAttribute("recommendationSection", recommendationSection);
        model.addAttribute("time", executionTime);

        System.out.println("완료 gemini_result로 이동");
        return "gemini_result";
    }

    // 공통: 섹션 추출 헬퍼
    private String extractSection(String text, String startTag, String endTag) {
        int start = text.indexOf(startTag);
        int end = text.indexOf(endTag, start);
        if (start != -1 && end != -1) {
            return text.substring(start + startTag.length(), end).trim();
        }
        return "";
    }

    // ✅ 수정된 출력 형식 포함 프롬프트
    private String generateAnalysisPrompt(
            String skinType,
            String skinConcerns,
            String sensitivityLevel,
            String avoidedIngredients
    ) {
        String promptTemplate =
            "### **[프롬프트] 이미지 기반 화장품 개인 맞춤 성분 분석**\n" +
            "\n" +
            "#### **# 페르소나 (Persona)**\n" +
            "당신은 화장품 이미지와 사용자 데이터를 기반으로 개인 맞춤 성분 분석을 수행하는 고도로 숙련된 화장품 성분 분석 전문가입니다. 당신은 제품을 식별하고, 제품에 확실하게 포함된 전성분을 파악하며, 명시된 두 가지 분석 규칙에 따라 정교한 리포트를 생성할 수 있습니다.\n" +
            "\n" +
            "----\n" +
            "#### **# 작업 목표 (Task Goal)**\n" +
            "주어진 [사용자 정보]와 [분석 대상 제품 이미지]를 바탕으로, 제품을 식별하고 온라인에서 해당 제품의 최신 전성분 목록을 찾아내세요. 그 후, 아래 [분석 규칙]에 따라 정확하게 분석을 수행하여 점수를 계산하고, 최종 결과를 [출력 양식]에 맞춰 생성하세요.\n" +
            "\n" +
            "----\n" +
            "#### **# 분석 규칙 (Analysis Rules)**\n" +
            "\n" +
            "**## 1. 제품 전체 적합도 분석 (내부 평가용 - 모델 4)**\n" +
            "리포트의 '추천 제품' 및 '최종 결과 요약'을 도출하기 위한 핵심 근거로, 제품 전체의 적합도를 '모델 4: 피부 타입 궁합 중시 모델'로 내부적으로 계산합니다.\n" +
            "\n" +
            "* 모델 4 배점: 궁합점수 = 피부 유형(50점)+피부 고민(20점)+피부 민감도(15점)+기피 성분(15점)\n" +
            "* 세부 산출 규칙:\n" +
            "    * 피부 유형 점수: 만점에서 시작하여 성분 불일치(-35%/개), 제형 불일치(-30%), 설계 불일치(-35%) 감점이 누적 적용됩니다.\n" +
            "    * 피부 고민 점수: 해결되지 않는 고민 1개당 -(100/피부 고민 개수)%가 감점됩니다.\n" +
            "    * 피부 민감도 점수: ((고위험 성분 개수 × 0.2) + (중위험 성분 개수 × 0.1)) × 민감도 가중치 만큼의 비율이 감점됩니다.\n" +
            "    * 기피 성분 점수: 발견되는 기피 성분 1개당 -(100/기피 성분 개수)%가 감점됩니다.\n" +
            "\n" +
            "**## 2. 개별 성분 평가 (직접 출력용)**\n" +
            "출력 양식의 '성분 분석' 목록에 있는 각 성분의 점수와 평가는 아래 규칙으로 계산합니다.\n" +
            "\n" +
            "* 산술식:\n" +
            "    점수 = (피부타입 적합도 × 0.5) + (민감도 점수 반영 × 0.15) + (기피 성분 여부 × -0.1) + (기본 효능 점수 × 0.25)\n" +
            "* 변수 정의:\n" +
            "    * 피부타입 적합도: 사용자 타입에 '긍정적'이면 100, '부정적'이면 0, '무관'이면 50으로 계산.\n" +
            "    * 민감도 점수 반영: 사용자 민감도가 '높음'이고 성분이 '자극 가능'이면 0, '낮음'이고 '순함'이면 100, 그 외는 50으로 계산.\n" +
            "    * 기피 성분 여부: 기피 성분에 해당하면 100, 아니면 0으로 계산.\n" +
            "    * 기본 효능 점수: 성분의 주 기능이 사용자의 '피부 고민'과 일치하면 100, 무관하면 50으로 계산.\n" +
            "* 평가 구간:\n" +
            "    * 80~100 → \"적합 👍\"\n" +
            "    * 60~79 → \"보통 😐\"\n" +
            "    * 0~59 → \"주의 ⚠️\"\n" +
            "\n" +
            "----\n" +
            "#### **# 입력 데이터 (Input Data)**\n" +
            "\n" +
            "[사용자 정보]\n" +
            "* 피부타입: {skinType}\n" +
            "* 피부고민: {skinConcerns}\n" +
            "* 민감도: {sensitivityLevel}\n" +
            "* 기피성분: {avoidedIngredients}\n" +
            "\n" +
            "[분석 대상 제품]\n" +
            "* 제품 이미지: (이미지로 제공됨)\n" +
            "\n" +
            "----\n" +
            "#### **# 출력 형식 (Output Format)**\n" +
            "다음은 반드시 HTML 형식으로 출력하라. 마크다운(**, ##, `)은 절대 사용하지 말고, 아래 구조를 정확히 따르라. 또한 '궁합점수'는 반드시 숫자를 소괄호로 감싸 표기하라. 예: (98)/100점\n" +
            "\n" +
            "<section id=\\\"productReport\\\">\\n" +
            "  <h1>'화장품이름'의 최종 분석 리포트</h1>\\n" +
            "  <p><strong>궁합점수:</strong> (숫자)/100점</p>\\n" +
            "</section>\\n\\n" +
            "\n" +
            "<section id=\\\"summary\\\">\\n" +
            "  <h2>📌 최종 결과 요약</h2>\\n" +
            "  <p><strong>{skinType}</strong> 피부에는 주요 성분 중 <strong>{skinConcerns 해결에 도움이 되는 성분 상위 1~2개}</strong>이(가) <strong>{skinConcerns}</strong> 개선에 도움이 됩니다.</p>\\n" +
            "  <p>특별히 주의해야 할 성분은 <strong>{주의 성분 상위 1~2개}</strong>이며, 자극 가능성은 낮으나 사용자의 민감도에 따라 주의가 필요합니다.</p>\\n" +
            "  <p>전반적으로 본 제품은 <strong>{skinType}</strong> 피부와 <strong>{skinConcerns}</strong> 고민을 고려했을 때 <strong>{적합/보통/주의}</strong> 수준으로 평가됩니다.</p>\\n" +
            "</section>\\n\\n" +
            "\n" +
            "<section id=\\\"ingredient\\\">\\n" +
            "  <h2>✅ 성분 분석</h2>\\n" +
            "  <ul>\\n" +
            "    <li><strong>장점 성분 (상위 2개)</strong></li>\\n" +
            "    <li><strong>{성분1}</strong> : 점수 <strong>{NN}</strong>점 → {요약 평가}. {설명}</li>\\n" +
            "    <li><strong>{성분2}</strong> : 점수 <strong>{NN}</strong>점 → {요약 평가}. {설명}</li>\\n" +
            "  </ul>\\n" +
            "  <ul>\\n" +
            "    <li><strong>단점 성분 (하위 2개)</strong></li>\\n" +
            "    <li><strong>{성분3}</strong> : 점수 <strong>{NN}</strong>점 → {요약 평가}. {설명}</li>\\n" +
            "    <li><strong>{성분4}</strong> : 점수 <strong>{NN}</strong>점 → {요약 평가}. {설명}</li>\\n" +
            "  </ul>\\n" +
            "</section>\\n\\n" +
            "\n" +
            "<section id=\\\"allergy\\\">\\n" +
            "  <h2>⚠️ 알러지 주의 성분 (SCCS/NACDG 기준)</h2>\\n" +
            "  <ul>\\n" +
            "    <li><strong>{성분A}</strong> : {설명}</li>\\n" +
            "    <li><strong>{성분B}</strong> : {설명}</li>\\n" +
            "    <li><strong>{성분C}</strong> : {설명}</li>\\n" +
            "    <li><strong>{성분D}</strong> : {설명}</li>\\n" +
            "  </ul>\\n" +
            "</section>\\n\\n" +
            "\n" +
            "<section id=\\\"recommendation\\\">\\n" +
            "  <h2>💡 추천 제품</h2>\\n" +
            "  <p>아래 제품들은 <strong>{skinType}</strong> 피부 및 <strong>{skinConcerns}</strong> 개선에 도움이 되는 실제 시중 제품입니다.</p>\\n" +
            "  <ul>\\n" +
            "    <li><strong>(토너) {제품명}</strong> : {설명}</li>\\n" +
            "    <li><strong>(세럼) {제품명}</strong> : {설명}</li>\\n" +
            "    <li><strong>(수분크림) {제품명}</strong> : {설명}</li>\\n" +
            "  </ul>\\n" +
            "</section>\\n";

        return promptTemplate
                .replace("{skinType}", skinType == null ? "" : skinType)
                .replace("{skinConcerns}", skinConcerns == null ? "" : skinConcerns)
                .replace("{sensitivityLevel}", sensitivityLevel == null ? "" : sensitivityLevel)
                .replace("{avoidedIngredients}", avoidedIngredients == null ? "" : avoidedIngredients);
    }

}
