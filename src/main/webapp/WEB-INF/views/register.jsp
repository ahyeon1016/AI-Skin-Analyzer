<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입</title>
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
	    max-width: 450px;
	    margin: 0 auto;
	    background: rgba(255, 255, 255, 0.95);
	    border-radius: 20px;
	    padding: 30px 25px;
	    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	    backdrop-filter: blur(10px);
	}
	
	h2 {
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
	
	.form-group {
	    margin-bottom: 20px;
	}
	
	.form-group label {
	    display: block;
	    font-weight: 600;
	    color: #4a5568;
	    margin-bottom: 8px;
	    font-size: 16px;
	}
	
	.form-group input[type="text"],
	.form-group input[type="password"] {
	    width: 100%;
	    padding: 15px 16px;
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
	    margin-top: 30px;
	}
	
	.submit-button:hover {
	    transform: translateY(-2px);
	    box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
	}
	
	.submit-button:active {
	    transform: translateY(0);
	}
	
	@media (max-width: 480px) {
	    body {
	        padding: 15px;
	    }
	    
	    .container {
	        padding: 25px 20px;
	    }
	    
	    h2 {
	        font-size: 24px;
	        margin-bottom: 25px;
	    }
	    
	    .submit-button {
	        padding: 16px;
	        font-size: 17px;
	        margin-top: 25px;
	    }
	}
	
	@media (max-width: 360px) {
	    .container {
	        padding: 20px 15px;
	    }
	    
	    .form-group input[type="text"],
	    .form-group input[type="password"] {
	        padding: 12px 14px;
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
	    <h2>회원가입</h2>
	    <form action="/skin/member/register" method="post">
	        <div class="form-group">
	            <label for="login_id">아이디</label>
	            <input type="text" id="login_id" name="login_id" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="password">비밀번호</label>
	            <input type="password" id="password" name="password" required>
	        </div>
	        
	        <div class="form-group">
	            <label for="nickname">닉네임</label>
	            <input type="text" id="nickname" name="nickname" required>
	        </div>
	
	        <button type="submit" class="submit-button">가입하기</button>
	    </form>
	</div>
</body>
</html>
