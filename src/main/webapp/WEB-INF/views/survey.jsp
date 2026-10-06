<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%
	HttpSession session = request.getSession(false);
%>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Survey</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 20px;
    }
    .container {
      max-width: 650px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 30px 25px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    }
    h2 {
      text-align: center;
      font-size: 26px;
      margin-bottom: 30px;
      background: linear-gradient(45deg, #667eea, #764ba2);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .question {margin-bottom: 30px;}
    .question-title {font-weight: 600; margin-bottom: 12px;}
    .form-group {margin-bottom: 20px;}

    /* 기본 라디오 숨기기 */
    .circle-group input[type="radio"] { display: none; }

    /* 원형 버튼 기본 상태 */
    .circle-group label {
      display: inline-flex;
      justify-content: center;
      align-items: center;
      margin: 6px;
      cursor: pointer;
      width: 55px;
      height: 55px;
      border-radius: 50%;
      border: 2px solid #cbd5e0;
      font-size: 18px;
      font-weight: 600;
      color: #4a5568;
      background: white;
      transition: all 0.25s ease;
      user-select: none;
    }
    .circle-group label:hover { border-color: #3182ce; }

    /* 선택 시 스타일 */
    .circle-group input[type="radio"]:checked + span {
      background: #3182ce;
      color: white;
      border-radius: 50%;
      border: 2px solid #3182ce;
      box-shadow: 0 4px 12px rgba(49,130,206,0.35);
      transform: scale(1.08);
      display: inline-flex;
      justify-content: center;
      align-items: center;
      width: 55px;
      height: 55px;
    }

    .submit-button {
      width: 100%;
      padding: 15px;
      font-size: 17px;
      font-weight: 700;
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: white;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      margin-top: 20px;
      transition: all 0.25s ease;
    }
    .submit-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102,126,234,0.4);
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>피부 설문조사</h2>
    <form id="surveyForm" action="/skin/member/surveyResult" method="post">

      <!-- 설문 1 -->
      <div class="question">
        <div class="question-title">1. 가장 기본적인 피부 유형은 무엇인가요?</div>
        <div class="circle-group">
          <label><input type="radio" name="skin_type" value="건성"><span>건성</span></label>
          <label><input type="radio" name="skin_type" value="정상"><span>정상</span></label>
          <label><input type="radio" name="skin_type" value="지성"><span>지성</span></label>
          <label><input type="radio" name="skin_type" value="복합성"><span>복합성</span></label>
        </div>
      </div>

      <!-- 설문 2 -->
      <div class="question">
        <div class="question-title">2. 현재 가장 고민되는 피부 문제를 모두 선택해주세요.</div>
        <div>
          <label><input type="checkbox" name="skin_concern" value="none" class="concern-none"> 특별히 없음</label><br>
          <label><input type="checkbox" name="skin_concern" value="hydration"> 수분 부족</label><br>
          <label><input type="checkbox" name="skin_concern" value="sensitive"> 예민/민감성</label><br>
          <label><input type="checkbox" name="skin_concern" value="pimple"> 여드름</label><br>
          <label><input type="checkbox" name="skin_concern" value="pigmentation"> 과색소침착</label><br>
          <label><input type="checkbox" name="skin_concern" value="aging"> 노화/탄력 저하</label><br>
          <label>기타: <input type="text" name="skin_concern_other" class="concern-other" placeholder="직접 입력"></label>
        </div>
      </div>

      <!-- 설문 3 -->
      <div class="question">
        <div class="question-title">3. 알러지 등으로 인해 특별히 기피하는 화장품 성분이 있나요?</div>
        <div>
          <label><input type="checkbox" name="avoid_ingredient" value="none" class="avoid-none"> 특별히 없음</label><br>
          <label><input type="checkbox" name="avoid_ingredient" value="paraben"> 파라벤</label><br>
          <label><input type="checkbox" name="avoid_ingredient" value="perfume"> 인공 향료</label><br>
          <label><input type="checkbox" name="avoid_ingredient" value="ethanol"> 에탄올</label><br>
          <label>기타: <input type="text" name="avoid_ingredient_other" class="avoid-other" placeholder="직접 입력"></label>
        </div>
      </div>

      <!-- 설문 4 -->
      <div class="question">
        <div class="question-title">4. 당신의 피부 민감도는 어느 정도인가요?</div>
        <p>(1점: 전혀 그렇지 않다 / 3점: 보통이다 / 5점: 매우 그렇다)</p>
        <div class="form-group">
          <label>A. 화장품 사용 후 자극 경험</label>
          <div class="circle-group">
            <label><input type="radio" name="sensitivity_a" value="1"><span>1</span></label>
            <label><input type="radio" name="sensitivity_a" value="2"><span>2</span></label>
            <label><input type="radio" name="sensitivity_a" value="3"><span>3</span></label>
            <label><input type="radio" name="sensitivity_a" value="4"><span>4</span></label>
            <label><input type="radio" name="sensitivity_a" value="5"><span>5</span></label>
          </div>
        </div>
        <div class="form-group">
          <label>B. 새로운 화장품 사용 시 조심스러움</label>
          <div class="circle-group">
            <label><input type="radio" name="sensitivity_b" value="1"><span>1</span></label>
            <label><input type="radio" name="sensitivity_b" value="2"><span>2</span></label>
            <label><input type="radio" name="sensitivity_b" value="3"><span>3</span></label>
            <label><input type="radio" name="sensitivity_b" value="4"><span>4</span></label>
            <label><input type="radio" name="sensitivity_b" value="5"><span>5</span></label>
          </div>
        </div>
        <div class="form-group">
          <label>C. 외부 환경 변화에 민감</label>
          <div class="circle-group">
            <label><input type="radio" name="sensitivity_c" value="1"><span>1</span></label>
            <label><input type="radio" name="sensitivity_c" value="2"><span>2</span></label>
            <label><input type="radio" name="sensitivity_c" value="3"><span>3</span></label>
            <label><input type="radio" name="sensitivity_c" value="4"><span>4</span></label>
            <label><input type="radio" name="sensitivity_c" value="5"><span>5</span></label>
          </div>
        </div>
      </div>

      <button type="submit" class="submit-button">제출하기</button>
    </form>
  </div>

	<script>
	  document.addEventListener("DOMContentLoaded", function() {
	    const form = document.getElementById("surveyForm");
	
	    function setupExclusiveGroup(groupSelector, noneSelector, otherInputSelector) {
	      const group = document.querySelector(groupSelector);
	      const none = group.querySelector(noneSelector);
	      const allChecks = Array.from(group.querySelectorAll("input[type='checkbox']"))
	                             .filter(el => el !== none);
	      const otherInput = group.querySelector(otherInputSelector);
	
	      none.addEventListener("change", () => {
	        if (none.checked) {
	          allChecks.forEach(chk => {
	            chk.checked = false;
	            chk.disabled = true;
	          });
	          if (otherInput) {
	            otherInput.value = "";        // 빈 문자열
	            otherInput.readOnly = true;   // disable → readonly (전송되도록)
	          }
	        } else {
	          allChecks.forEach(chk => chk.disabled = false);
	          if (otherInput) {
	            otherInput.readOnly = false;  // 다시 입력 가능
	          }
	        }
	      });
	    }
	
	    // 그룹별 설정
	    setupExclusiveGroup(".question:nth-of-type(2)", ".concern-none", ".concern-other");
	    setupExclusiveGroup(".question:nth-of-type(3)", ".avoid-none", ".avoid-other");
	
	    // 제출 검증
	    form.addEventListener("submit", function(e) {
	      // 1. 피부 유형
	      if (!form.querySelector("input[name='skin_type']:checked")) {
	        alert("피부 유형을 선택해주세요.");
	        e.preventDefault();
	        return;
	      }
	
	      // 2. 피부 고민
	      const concernGroup = document.querySelector(".question:nth-of-type(2)");
	      const concerns = concernGroup.querySelectorAll("input[name='skin_concern']:checked");
	      const concernOther = concernGroup.querySelector(".concern-other");
	      if (concerns.length === 0 && (!concernOther.value || concernOther.readOnly)) {
	        alert("피부 고민을 최소 하나 선택하거나 기타 항목을 입력해주세요.");
	        e.preventDefault();
	        return;
	      }
	
	      // 3. 기피 성분
	      const avoidGroup = document.querySelector(".question:nth-of-type(3)");
	      const avoids = avoidGroup.querySelectorAll("input[name='avoid_ingredient']:checked");
	      const avoidOther = avoidGroup.querySelector(".avoid-other");
	      if (avoids.length === 0 && (!avoidOther.value || avoidOther.readOnly)) {
	        alert("기피 성분을 최소 하나 선택하거나 기타 항목을 입력해주세요.");
	        e.preventDefault();
	        return;
	      }
	
	      // 4. 민감도 A/B/C (명시적 검사)
	      const a = form.querySelector("input[name='sensitivity_a']:checked");
	      const b = form.querySelector("input[name='sensitivity_b']:checked");
	      const c = form.querySelector("input[name='sensitivity_c']:checked");
	
	      if (!a || !b || !c) {
	        alert("민감도 항목 A, B, C를 모두 선택해주세요.");
	        e.preventDefault();
	        return;
	      }
	    });
	  });
	</script>

</body>
</html>
