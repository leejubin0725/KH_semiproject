 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/pwfind.css">
</head>
<body>
<form id="myForm" action="${pageContext.request.contextPath}/user/changepw" method="post">
    <div class="container">
       <img src="${contextPath}/resources/images/logo.jpg" alt="아이콘" class="icon">
  
        <p class="instruction">비밀번호를 찾고자하는 아이디, 이메일을 입력해주세요.</p>
        <div class="input-group">
           
            <input type="text" name= "birth" placeholder="생년월일 6자리를 입력하시오 ex)000217" class="input-field">
        </div>
        <div class="input-group">
         
            <input type="text" name= "email" placeholder="이메일을 입력하세요.." class="input-field">
        </div>
        <button class="submit-btn">확인</button>
        
  
        <a href="${contextPath}/user/idfind" class="find-id-btn">아이디가 기억나지 않는다면?  아이디 찾기</a>
    </div>
       </form>
    
    
    
</body>

</html>