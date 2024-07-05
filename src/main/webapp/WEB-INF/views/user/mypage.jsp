<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${contextPath }/resources/css/mypage.css">
</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class = "mypage-body">
    <div class="mypage-container">
        <h1>마이페이지</h1>
        <div class="mypage-form-group">
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" value="홍길동" readonly>
        </div>
        <div class="mypage-form-group">
            <label for="userid">아이디:</label>
            <input type="text" id="userid" name="userid" value="hong123" readonly>
        </div>
        <div class="mypage-form-group">
            <label for="userphone">연락처:</label>
            <input type="text" id="userphone" name="userphone" value="010-1234-5678" readonly>
        </div>
        <div class="mypage-form-group">
            <label for="useremail">이메일:</label>
            <input type="text" id="useremail" name="useremail" value="hong123@gmail.com" readonly>
        </div>
        <div class="mypage-form-group">
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" value="********" readonly>
        </div>
        <button class="mypage-button" onclick="showMyPosts()">내가 쓴 글</button>
        <button class="mypage-button" onclick="editInfo()">개인정보 수정</button>
        <button class="mypage-button secondary" onclick="confirmDelete()">회원탈퇴</button>
    </div>
    	</div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script src="${contextPath }/resources/js/mypage-script.js"></script>
</body>
</html>