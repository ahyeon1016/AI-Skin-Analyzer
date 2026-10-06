# 화장품 이미지와 사용자 데이터를 기반으로 개인 맞춤 성분 분석

사용자의 피부 설문 정보와 화장품 제품 이미지를 기반으로 개인 맞춤형 화장품 성분 분석 결과를 제공하는 Spring MVC 기반 웹 애플리케이션입니다.

사용자가 피부 유형, 피부 고민, 민감도, 기피 성분을 입력한 뒤 제품 이미지를 업로드하면 Google Cloud Vertex AI의 Gemini 모델을 이용해 제품 적합도와 성분 분석 결과를 생성합니다.

## 주요 기능

- 회원가입 및 로그인
- 사용자별 피부 설문 저장
  - 피부 유형
  - 피부 고민
  - 기피 성분
  - 피부 민감도
- 화장품 제품 이미지 업로드
- 사용자 설문 정보와 제품 이미지를 이용한 AI 분석
- 분석 결과 제공
  - 제품 궁합 점수
  - 최종 결과 요약
  - 주요 성분 분석
  - 알러지 주의 성분
  - 추천 제품
- MySQL을 이용한 회원 및 설문 정보 저장

## 기술 스택

### Backend
- Java 17
- Spring Framework 6.0.0
- Spring MVC
- JSP / JSTL

### AI
- Google Cloud Vertex AI
- Gemini 2.5 Pro

### Database
- MySQL
- JDBC

### Server
- Apache Tomcat 10.0.20

### Build
- Maven
- WAR Packaging

### Frontend
- JSP
- HTML
- CSS
- JavaScript

## 동작 흐름

```text
회원가입 / 로그인
        ↓
피부 설문조사
        ↓
피부 정보 DB 저장
        ↓
화장품 제품 이미지 업로드
        ↓
사용자 피부 정보 + 제품 이미지
        ↓
Vertex AI Gemini 분석
        ↓
개인 맞춤 화장품 분석 결과 출력
```

## 프로젝트 구조

```text
AI-Skin-Analyzer
├── .gitignore
├── DB.sql
├── pom.xml
└── src
    └── main
        ├── java
        │   └── com.spring
        │       ├── controller
        │       ├── domain
        │       ├── repository
        │       └── service
        │
        ├── resources
        │   └── secret-config.txt
        │
        └── webapp
            ├── index.jsp
            └── WEB-INF
                ├── spring
                │   ├── appServlet
                │   │   └── servlet-context.xml
                │   └── root-context.xml
                ├── views
                │   ├── gemini.jsp
                │   ├── gemini_result.jsp
                │   ├── login_member.jsp
                │   ├── register.jsp
                │   └── survey.jsp
                └── web.xml
```

> `secret-config.txt`는 인증정보 보호를 위해 `.gitignore`에 등록되어 있으며 GitHub 저장소에는 포함되지 않습니다.

## 주요 패키지

| 패키지 | 역할 |
|---|---|
| `controller` | 회원, 설문, AI 분석 요청 처리 |
| `domain` | 회원, 설문, 이미지 입력 데이터 객체 |
| `repository` | MySQL 데이터 접근 |
| `service` | 회원 및 설문 비즈니스 로직 처리 |

## 주요 화면

| 화면 | 설명 |
|---|---|
| `index.jsp` | 메인 화면 |
| `register.jsp` | 회원가입 |
| `login_member.jsp` | 로그인 |
| `survey.jsp` | 피부 유형, 고민, 기피 성분, 민감도 설문 |
| `gemini.jsp` | 분석할 화장품 제품 이미지 입력 |
| `gemini_result.jsp` | AI 분석 결과 출력 |
