<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@ page import="com.spring.domain.memberDTO"%>
<%@ page import="com.spring.domain.surveyDTO"%>
<!DOCTYPE html>
<%
	memberDTO member = null;
	surveyDTO survey = null;
	
	HttpSession session = request.getSession(false);
	
	if (session != null) {
		member = (memberDTO) session.getAttribute("member");
		if(session.getAttribute("survey")!=null){
			survey = (surveyDTO) session.getAttribute("survey");
		}
	}
%>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>메인 페이지</title>
	<style>
	* {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	}
	
	body {
	    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
	    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	    min-height: 100vh;
	    padding: 20px;
	    color: #333;
	}
	
	.container {
	    max-width: 400px;
	    margin: 0 auto;
	    background: rgba(255, 255, 255, 0.95);
	    border-radius: 20px;
	    padding: 30px 25px;
	    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	    backdrop-filter: blur(10px);
	}
	
	h1 {
	    text-align: center;
	    font-size: 28px;
	    font-weight: 700;
	    color: #4a5568;
	    margin-bottom: 30px;
	    background: linear-gradient(45deg, #667eea, #764ba2);
	    -webkit-background-clip: text;
	    -webkit-text-fill-color: transparent;
	    background-clip: text;
	}
	
	.user-info {
	    background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
	    border-radius: 15px;
	    padding: 20px;
	    margin-bottom: 25px;
	    text-align: center;
	    border: 1px solid rgba(102, 126, 234, 0.2);
	}
	
	.user-info p {
	    font-size: 16px;
	    line-height: 1.6;
	    color: #4a5568;
	    margin-bottom: 20px;
	}
	
	.button-group {
	    display: flex;
	    flex-direction: column;
	    gap: 15px;
	}
	
	.nav-button {
	    display: block;
	    width: 100%;
	    padding: 15px 20px;
	    background: linear-gradient(135deg, #667eea, #764ba2);
	    color: white;
	    text-decoration: none;
	    border-radius: 12px;
	    text-align: center;
	    font-size: 16px;
	    font-weight: 600;
	    border: none;
	    cursor: pointer;
	    transition: all 0.3s ease;
	    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
	}
	
	.nav-button:hover {
	    transform: translateY(-2px);
	    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
	}
	
	.nav-button:active {
	    transform: translateY(0);
	}
	
	.nav-button.secondary {
	    background: linear-gradient(135deg, #ff6b6b, #ffa726);
	    box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
	}
	
	.nav-button.secondary:hover {
	    box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
	}
	
	.nav-button.outline {
	    background: transparent;
	    color: #667eea;
	    border: 2px solid #667eea;
	    box-shadow: none;
	}
	
	.nav-button.outline:hover {
	    background: #667eea;
	    color: white;
	    transform: translateY(-2px);
	    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
	}
	
	.divider {
	    height: 1px;
	    background: linear-gradient(90deg, transparent, #ddd, transparent);
	    margin: 25px 0;
	}
	
	.auth-section {
	    display: flex;
	    flex-direction: column;
	    gap: 12px;
	}
	
	@media (max-width: 480px) {
	    body {
	        padding: 15px;
	    }
	    
	    .container {
	        padding: 25px 20px;
	    }
	    
	    h1 {
	        font-size: 24px;
	        margin-bottom: 25px;
	    }
	    
	    .nav-button {
	        padding: 14px 18px;
	        font-size: 15px;
	    }
	}
	</style>
</head>
<body>
	<div class="container">
	    <h1>안녕하세요!</h1>
	    <%
	    if(member!=null){
	    %>
	    <div class="user-info">
	    	<%
	    	if(survey==null){
	    	%>
	        <div class="button-group">
	            <a href="member/survey" class="nav-button">설문조사 실행</a>
	        </div>
	        <%
	    	}
	        %>
	        
	        <%
	        if(survey!=null){
	        %>
	        <p><%=member.getNickname()%>님의 피부타입은 <%=survey.getSkin_type()%>입니다.</p>
	        <div class="button-group">
	            <a href="api/gemini" class="nav-button">적합도 분석</a>
	            <a href="member/logout" class="nav-button secondary">로그아웃</a>
	        </div>
	        <%
	        }
	        %>
	    </div>
	    <%
	    }
	    if(member==null){
	    %>
	    <div class="auth-section">
	        <a href="member/login" class="nav-button">로그인</a>
	        <a href="member/register" class="nav-button outline">회원가입</a>
	    </div>
	    <%
	    }
	    %>
	</div>
</body>
</html>