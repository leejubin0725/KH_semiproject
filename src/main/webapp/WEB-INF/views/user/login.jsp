<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Login Page</title>
<link rel="stylesheet" href="${contextPath }/resources/css/login.css">
</head>
<body>
	<div class="container">
		<form action="${contextPath }/user/login" method="POST">
			<div class="login-box">
				<div class="title">로그인</div>
				<div class="input-group">
					<div class="input-label">이메일</div>
					<input type="text" name="email" class="input-field"
						placeholder="Enter your email">
				</div>
				<div class="input-group">
					<div class="input-label">비밀번호</div>
					<input type="password" name="password" class="input-field"
						placeholder="Enter your password">
				</div>
				<c:if test="${not empty loginError}">
					<div class="error-message" style="color: red;">${loginError}
					</div>
				</c:if>
				<button type="submit" class="login-button">로그인</button>
				<a class="find-ID" onclick="findid()"> 아이디 찾기</a> <a class="find-ID"
					onclick="findpw()"> 비밀번호 찾기</a>
			</div>
		</form>
	</div>
	<div class="divider"></div>
	<div>
		<img class="image" src="${contextPath }/resources/images/cut_2.png">
	</div>
</body>
<script>
	//아이디 찾기
	function findid() {
		location.href = '${contextPath}/user/idfind';
	}
	//비밀번호 찾기
	function findpw() {
		location.href = '${contextPath}/user/pwfind';
	}
</script>
</html>
