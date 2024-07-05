<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>Login Page</title>
  <meta name="description" content="Login Page">
  <meta name="author" content="htmlGenerator">
  <link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet">
 
 
 
</head>
<body>
  <div class="container">
    <div class="login-box">
      <div class="title">로그인</div>
      <div class="input-group">
        <div class="input-label">아이디</div>
        <input type="text" class="input-field" placeholder="Enter your email">
      </div>
      <div class="input-group">
        <div class="input-label">비밀번호</div>
        <input type="password" class="input-field" placeholder="Enter your password">
      </div>
   
      
      <button class="login-button">로그인</buttondiv>
      <button class="find-ID">아이디찾기</button>
      <button class="find-PW">비밀번호찾기</button  >

      
    </div>
    <div class="divider"></div>
    <div class="image"></div>
  </div>
</body>
</html>
