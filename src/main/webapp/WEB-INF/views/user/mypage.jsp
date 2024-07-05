<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<<<<<<< HEAD
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${contextPath }/resources/css/mypage.css">
=======
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="${contextPath }/resources/css/styles.css">
>>>>>>> jis
</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="mypage-body">
		<div class="mypage-container">
			<h1>마이페이지</h1>
			<form action="${contextPath }/user/update" method="post">
				<div class="mypage-form-group">
					<label for="name">이메일:</label> <input type="text" id="email"
						name="email" value="${loginUser.email}" readonly>
				</div>
				<div class="mypage-form-group">
					<label for="password">비밀번호:</label> <input type="password"
						id="password" name="password">
				</div>
				<div class="mypage-form-group">
					<label for="userid">닉네임:</label> <input type="text" id="nickname"
						name="nickname" value="${loginUser.nickname}">
				</div>
				<div class="mypage-form-group">
					<label for="userphone">연락처:</label> <input type="text" id="phone"
						name="phone" value="${loginUser.phone}">
				</div>
				<div class="mypage-form-group">
					<label for="useremail">주소:</label> <input type="text" id="address"
						name="address" value="${loginUser.address}">
				</div>

				<button type="submit" class="mypage-button" onclick="editInfo()">개인정보 수정</button>
			</form>
			<button class="mypage-button" onclick="showMyPosts()">내가 쓴 글</button>
			<button class="mypage-button secondary" onclick="confirmDelete()">회원탈퇴</button>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script src="${contextPath }/resources/js/mypage-script.js"></script>
</body>
</html>