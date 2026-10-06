<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>제품 분석 요청</title>
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
	    display: flex;
	    justify-content: center;
	    align-items: flex-start;
	}
	
	.container {
	    width: 100%;
	    max-width: 480px;
	    background: rgba(255, 255, 255, 0.95);
	    backdrop-filter: blur(10px);
	    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
	    border-radius: 20px;
	    padding: 30px 25px;
	    margin-top: 20px;
	}
	
	h1 {
	    font-size: 26px;
	    font-weight: 700;
	    margin-bottom: 30px;
	    text-align: center;
	    background: linear-gradient(45deg, #667eea, #764ba2);
	    -webkit-background-clip: text;
	    -webkit-text-fill-color: transparent;
	    background-clip: text;
	}
	
	.form-group {
	    margin-bottom: 25px;
	}
	
	label {
	    display: block;
	    font-size: 16px;
	    font-weight: 600;
	    color: #4a5568;
	    margin-bottom: 8px;
	    padding-left: 4px;
	}
	
	input[type="text"], 
	textarea, 
	input[type="file"] {
	    width: 100%;
	    padding: 15px 16px;
	    font-size: 16px;
	    border: 2px solid #e2e8f0;
	    border-radius: 12px;
	    background: #fff;
	    transition: all 0.3s ease;
	    font-family: inherit;
	}
	
	input[type="text"]:focus,
	textarea:focus {
	    outline: none;
	    border-color: #667eea;
	    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
	    transform: translateY(-1px);
	}
	
	input[type="text"][readonly] {
	    background: linear-gradient(135deg, #f7fafc, #edf2f7);
	    color: #667eea;
	    font-weight: 600;
	    cursor: not-allowed;
	}
	
	textarea {
	    resize: vertical;
	    min-height: 120px;
	    line-height: 1.5;
	}
	
	textarea::placeholder {
	    color: #a0aec0;
	}
	
	input[type="file"] {
	    padding: 12px 16px;
	    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
	    border: 2px dashed #cbd5e0;
	    cursor: pointer;
	    position: relative;
	}
	
	input[type="file"]:hover {
	    border-color: #667eea;
	    background: linear-gradient(135deg, #f0f4ff, #e6f3ff);
	}
	
	input[type="file"]::-webkit-file-upload-button {
	    background: linear-gradient(135deg, #667eea, #764ba2);
	    color: white;
	    padding: 8px 16px;
	    border: none;
	    border-radius: 8px;
	    font-weight: 600;
	    margin-right: 12px;
	    cursor: pointer;
	}
	
	.submit-button {
	    width: 100%;
	    padding: 18px;
	    font-size: 18px;
	    font-weight: 700;
	    background: linear-gradient(135deg, #667eea, #764ba2);
	    color: white;
	    border: none;
	    border-radius: 12px;
	    cursor: pointer;
	    transition: all 0.3s ease;
	    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
	    margin: 30px 0 25px 0;
	}
	
	.submit-button:hover {
	    transform: translateY(-2px);
	    box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
	}
	
	.submit-button:active {
	    transform: translateY(0);
	}
	
	.divider {
	    height: 1px;
	    background: linear-gradient(90deg, transparent, #e2e8f0, transparent);
	    margin: 25px 0;
	}
	
	.back-link {
	    display: inline-flex;
	    align-items: center;
	    padding: 12px 20px;
	    background: rgba(102, 126, 234, 0.1);
	    color: #667eea;
	    text-decoration: none;
	    border-radius: 10px;
	    font-weight: 600;
	    transition: all 0.3s ease;
	    border: 1px solid rgba(102, 126, 234, 0.2);
	}
	
	.back-link:hover {
	    background: rgba(102, 126, 234, 0.2);
	    transform: translateY(-1px);
	}
	
	.back-link::before {
	    content: "← ";
	    margin-right: 5px;
	}
	
	.camera-icon {
	    position: relative;
	    display: inline-block;
	}
	
	.camera-icon::after {
	    content: "📷";
	    position: absolute;
	    right: 12px;
	    top: 50%;
	    transform: translateY(-50%);
	    font-size: 18px;
	    pointer-events: none;
	}
	
	@media (max-width: 480px) {
	    body {
	        padding: 15px;
	    }
	    
	    .container {
	        padding: 25px 20px;
	        margin-top: 10px;
	    }
	    
	    h1 {
	        font-size: 22px;
	        margin-bottom: 25px;
	    }
	    
	    .form-group {
	        margin-bottom: 20px;
	    }
	    
	    input[type="text"], 
	    textarea, 
	    input[type="file"] {
	        padding: 14px;
	        font-size: 16px;
	    }
	    
	    .submit-button {
	        padding: 16px;
	        font-size: 17px;
	        margin: 25px 0 20px 0;
	    }
	}
	
	@media (max-width: 360px) {
	    .container {
	        padding: 20px 15px;
	    }
	    
	    h1 {
	        font-size: 20px;
	    }
	    
	    input[type="text"], 
	    textarea, 
	    input[type="file"] {
	        padding: 12px;
	        font-size: 15px;
	    }
	    
	    .submit-button {
	        font-size: 16px;
	        padding: 15px;
	    }
	}
	</style>
</head>
<body>
	<div class="container">
	    <h1>제품 분석 요청</h1>
	
	    <form:form action="/skin/api/gemini"
	    method="post"
	    modelAttribute="information"
	    enctype="multipart/form-data">
	
	    <div class="form-group">
	        <label for="skintype">피부 타입</label>
	        <form:input path="skintype" id="skintype" value="<%=survey.getSkin_type()%>" readonly="true"/>
	    </div>
	
	    <div class="form-group" style="display: none;">
	        <label for="question">질문</label>
	        <form:textarea path="question" id="question" rows="4" placeholder="질문이 있다면 입력해 주세요."/>
	    </div>
	
	    <div class="form-group">
	        <label for="photo">제품 사진 촬영</label>
	        <div class="camera-icon">
	            <form:input path="photo" id="photo" type="file" accept="image/*" capture="environment" required="required"/>
	        </div>
	    </div>
	
	    <button type="submit" class="submit-button">분석 요청</button>
	    </form:form>
	
	    <div class="divider"></div>
	    <a href="/skin" class="back-link">메인으로</a>
	</div>
</body>
</html>