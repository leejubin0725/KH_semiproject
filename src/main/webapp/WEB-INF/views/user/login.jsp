<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Login Page</title>
<link rel="stylesheet" href="${contextPath}/resources/css/login.css">
</head>
<body>
   <div class="container">
      <form action="${contextPath}/user/login" method="POST">
         <div class="login-box">
            <div class="title">로그인</div>
            <div class="input-group">
               <div class="input-label">이메일</div>
               <input type="text" name="email" class="input-field" placeholder="Enter your email">
            </div>
            <div class="input-group">
               <div class="input-label">비밀번호</div>
               <input type="password" name="password" class="input-field" placeholder="Enter your password">
            </div>
            <button type="submit" class="login-button">로그인</button>
         </div>
      </form>

      <button class="find-ID" onclick="findid()">아이디찾기</button>
      <button class="find-PW">비밀번호찾기</button>
       <a href="${contextPath}/user/kakao/login">
            <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" alt="카카오 로그인">
        </a>

   </div>
   <div class="divider"></div>
   <div><img class="image" src="${contextPath}/resources/images/cut_2.png"></div>
   
   <script>
      function findid() {
         location.href = '${contextPath}/user/idfind';
      }
   </script>
</body>
</html>
