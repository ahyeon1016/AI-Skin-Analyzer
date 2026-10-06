<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>로그인</title>
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
	    align-items: center;
	    color: #333;
	}
	
	.container {
	    width: 100%;
	    max-width: 400px;
	    background: rgba(255, 255, 255, 0.95);
	    backdrop-filter: blur(10px);
	    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
	    border-radius: 20px;
	    padding: 40px 30px;
	}
	
	h1 {
	    text-align: center;
	    font-size: 28px;
	    font-weight: 700;
	    margin-bottom: 35px;
	    background: linear-gradient(45deg, #667eea, #764ba2);
	    -webkit-background-clip: text;
	    -webkit-text-fill-color: transparent;
	    background-clip: text;
	}
	
	.form-group {
	    margin-bottom: 25px;
	}
	
	.form-group label {
	    display: block;
	    font-size: 16px;
	    font-weight: 600;
	    color: #4a5568;
	    margin-bottom: 8px;
	    padding-left: 4px;
	}
	
	.form-group input[type="text"],
	.form-group input[type="password"] {
	    width: 100%;
	    padding: 16px 18px;
	    font-size: 16px;
	    border: 2px solid #e2e8f0;
	    border-radius: 12px;
	    background: #fff;
	    transition: all 0.3s ease;
	    font-family: inherit;
	}
	
	.form-group input[type="text"]:focus,
	.form-group input[type="password"]:focus {
	    outline: none;
	    border-color: #667eea;
	    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
	    transform: translateY(-1px);
	}
	
	.login-button {
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
	
	.login-button:hover {
	    transform: translateY(-2px);
	    box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
	}
	
	.login-button:active {
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
	    justify-content: center;
	    width: 100%;
	    padding: 14px 20px;
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
	    margin-right: 8px;
	    font-size: 16px;
	}
	
	@media (max-width: 480px) {
	    body {
	        padding: 15px;
	        align-items: flex-start;
	        padding-top: 60px;
	    }
	    
	    .container {
	        padding: 30px 25px;
	    }
	    
	    h1 {
	        font-size: 24px;
	        margin-bottom: 30px;
	    }
	    
	    .form-group {
	        margin-bottom: 20px;
	    }
	    
	    .form-group input[type="text"],
	    .form-group input[type="password"] {
	        padding: 14px 16px;
	        font-size: 16px;
	    }
	    
	    .input-icon input {
	        padding-left: 45px;
	    }
	    
	    .login-button {
	        padding: 16px;
	        font-size: 17px;
	        margin: 25px 0 20px 0;
	    }
	}
	
	@media (max-width: 360px) {
	    .container {
	        padding: 25px 20px;
	    }
	    
	    h1 {
	        font-size: 22px;
	    }
	    
	    .form-group input[type="text"],
	    .form-group input[type="password"] {
	        padding: 12px 14px;
	        font-size: 15px;
	    }
	    
	    .input-icon input {
	        padding-left: 40px;
	    }
	    
	    .login-button {
	        font-size: 16px;
	        padding: 15px;
	    }
	}
	</style>
</head>
<body>
	<div class="container">
	    <h1>로그인</h1>
	
	    <form action="/skin/member/login" method="post">
	        <div class="form-group">
	            <label for="login_id">아이디</label>
	            <div class="input-icon">
	                <input type="text" id="login_id" name="login_id" required="required" placeholder=" 아이디를 입력하세요"/>
	            </div>
	        </div>
	
	        <div class="form-group">
	            <label for="password">비밀번호</label>
	            <div class="input-icon password">
	                <input type="password" id="password" name="password" required="required" placeholder=" 비밀번호를 입력하세요"/>
	            </div>
	        </div>
	
	        <button type="submit" class="login-button">로그인</button>
	    </form>
	
	    <div class="divider"></div>
	    <a href="/skin" class="back-link">메인으로</a>
	</div>
</body>
</html>