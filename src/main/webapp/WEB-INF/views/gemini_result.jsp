<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    String productName         = (String) request.getAttribute("productName");
    String finalScore          = (String) request.getAttribute("finalScore");
    String summarySection      = (String) request.getAttribute("summarySection");
    String ingredientSection   = (String) request.getAttribute("ingredientSection");
    String allergySection      = (String) request.getAttribute("allergySection");
    String recommendationSection = (String) request.getAttribute("recommendationSection");
    long time                  = (long) request.getAttribute("time");
%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gemini 분석 결과</title>
<style>
/* 페이지 공통 */
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh; padding: 20px; color: #333;
}
.container {
  max-width: 760px; margin: 0 auto;
  background: rgba(255,255,255,0.95);
  border-radius: 18px; overflow: hidden;
  box-shadow: 0 18px 40px rgba(0,0,0,0.1);
}

/* 헤더 */
.header {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: #fff; padding: 24px; text-align: center; position: relative;
}
.header h1 { font-size: 22px; font-weight: 800; letter-spacing: .3px; }
.time-info {
  display: inline-block; margin-top: 12px; padding: 8px 14px;
  background: rgba(255,255,255,.18); border-radius: 999px; font-size: 13px;
}

/* result 내부만 스타일링 */
.result { padding: 22px; }

.result .score-card {
  display: flex; align-items: center; justify-content: space-between;
  background: #fff; border: 1px solid #e7eaf3; border-radius: 14px;
  padding: 16px 18px; margin-bottom: 18px;
  box-shadow: 0 3px 10px rgba(20,40,120,0.06);
}
.result .score-card .title {
  font-weight: 700; color: #374151; font-size: 16px;
}
.result .score-card .score {
  font-size: 22px; font-weight: 900;
  padding: 8px 14px; border-radius: 10px;
  background: #eef2ff; color: #4f46e5; min-width: 84px; text-align: center;
}

/* 공통 카드 */
.result .card {
  background: linear-gradient(180deg, #f8fafc 0%, #fff 60%);
  border: 1px solid #e6e9f1; border-radius: 16px;
  box-shadow: 0 6px 18px rgba(20,40,120,0.06);
  padding: 20px; margin-bottom: 18px;
}
.result .card h2 {
  font-size: 18px; font-weight: 800; color: #334155; margin-bottom: 12px;
}

/* summary 문단 정돈 */
.result #summary p {
  margin: 8px 0; line-height: 1.7; letter-spacing: .1px;
}
.result #summary strong { color: #1f3a8a; }

/* ingredient 리스트 가독성 */
.result #ingredient ul { list-style: none; margin-top: 8px; }
.result #ingredient li {
  padding: 10px 12px; border-bottom: 1px dashed #e7eaf3;
}
.result #ingredient li strong { color: #1f2937; }

/* allergy */
.result #allergy ul { list-style: disc; padding-left: 20px; }
.result #allergy li { margin: 6px 0; }

/* recommendation */
.result #recommendation ul { list-style: none; }
.result #recommendation li {
  padding: 10px 12px; border: 1px solid #eef2ff;
  border-radius: 10px; margin: 8px 0;
  background: #fafbff;
}

/* footer */
.footer {
  padding: 20px; text-align: center; border-top: 1px solid #eef2ff;
}
.footer a {
  display: inline-block; background: linear-gradient(135deg, #667eea, #764ba2);
  color: #fff; text-decoration: none; padding: 12px 20px; border-radius: 12px;
  font-weight: 700; box-shadow: 0 8px 22px rgba(102,126,234,.35);
}
.footer a:hover { transform: translateY(-1px); }

/* 자세히 보기 버튼 (홈으로 이동 버튼과 동일 디자인, 밝은 톤) */
#toggle-details {
  background: linear-gradient(135deg, #a5b4fc, #c4b5fd);
  color: #fff;
  border: none;
  padding: 12px 20px;
  border-radius: 12px;
  font-weight: 700;
  font-size: 15px;
  cursor: pointer;
  box-shadow: 0 8px 22px rgba(162,162,234,.35);
  transition: transform 0.2s ease;
}
#toggle-details:hover {
  transform: translateY(-1px);
}
</style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>분석 결과</h1>
      <div class="time-info">
        소요시간: <%=(time/1000)/60 %>분 <%=(time/1000)%60 %>초
      </div>
    </div>

    <div class="result">
      <!-- 제품/점수 요약 카드 -->
      <div class="score-card">
        <div class="title">'<%= (productName==null?"":productName) %>' 최종 궁합 점수</div>
        <div class="score"><%= (finalScore==null?"0":finalScore) %> / 100</div>
      </div>

      <!-- 최종 결과 요약 -->
      <div class="card">
        <section id="summary">
          <%= (summarySection==null?"":summarySection) %>
        </section>
      </div>

      <!-- 자세히 보기 버튼 -->
      <div style="text-align:center; margin: 20px 0;">
        <button type="button" id="toggle-details" aria-controls="details-wrapper" aria-expanded="false">
          자세히 보기
        </button>
      </div>

      <!-- 성분 분석 ~ 추천 제품 래퍼 -->
      <div id="details-wrapper" style="display:none;" aria-hidden="true">
        <!-- 성분 분석 -->
        <div class="card">
          <section id="ingredient">
            <%= (ingredientSection==null?"":ingredientSection) %>
          </section>
        </div>

        <!-- 알러지 주의 성분 -->
        <div class="card">
          <section id="allergy">
            <%= (allergySection==null?"":allergySection) %>
          </section>
        </div>

        <!-- 추천 제품 -->
        <div class="card">
          <section id="recommendation">
            <%= (recommendationSection==null?"":recommendationSection) %>
          </section>
        </div>
      </div>
    </div>

    <div class="footer">
      <a href="/skin">홈으로 이동</a>
    </div>
  </div>

  <script>
    (function() {
      var btn = document.getElementById('toggle-details');
      var wrap = document.getElementById('details-wrapper');

      if (btn && wrap) {
        btn.addEventListener('click', function () {
          var hidden = wrap.getAttribute('aria-hidden') === 'true';
          wrap.style.display = hidden ? '' : 'none';
          wrap.setAttribute('aria-hidden', hidden ? 'false' : 'true');
          btn.textContent = hidden ? '접기' : '자세히 보기';
          btn.setAttribute('aria-expanded', hidden ? 'true' : 'false');
          btn.style.transform = hidden ? 'translateY(-1px)' : 'translateY(0)';
        });
      }
    })();
  </script>
</body>
</html>
