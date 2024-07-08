<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/changepw.css">
</head>
<body>
<form id="myForm" action="${pageContext.request.contextPath}/user/updatepw" method="post">
    <div class="container">
        <img src="${contextPath}/resources/images/logo.jpg" alt="아이콘" class="icon">
        <p class="instruction">비밀번호를 변경해주세요</p>
        <div class="input-group">
           
            <input type="text" name="pw1"placeholder="새로운 비밀번호를 입력해주세요" class="input-field">
        </div>
        <div class="input-group">
         
            <input type="text" name="pw2" placeholder="다시 입력해주세요" class="input-field">
        </div>
        <button class="submit-btn">확인</button>
    </div>
    </form>
</body>
</html>