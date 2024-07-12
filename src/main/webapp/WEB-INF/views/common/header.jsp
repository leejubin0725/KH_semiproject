<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${contextPath}/resources/css/headerStyle.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 라이브러리 추가 -->
    <!-- alertify -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
    <!-- alertify css -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css" />
</head>
<body>

    <c:if test="${not empty alertMsg}">
        <script>
            alertify.alert("서비스 요청 성공", '${alertMsg}');
        </script>
        <c:remove var="alertMsg" />
    </c:if>

    <div class="headerContainer">
        <!-- 이미지를 클릭하면 contextPath로 이동하는 예제 -->
        

        <div class="header-main">
            <div class="headerNav">
            	<img src="${contextPath}/resources/images/mainlogo.jpg" alt="작은 로고" class="headerLogo">
                <span><a href="${contextPath}" >홈</a></span>
                <span><a href="${contextPath}/order/noticeboard" >배달목록</a></span>
                <span><a href="${contextPath}/inquiry/customerservice" >고객문의</a></span>
            </div>
            
            <div class="headerNav2">
                <c:choose>
                    <c:when test="${not empty loginUser}">
                        <span><a href="${contextPath}/user/mypage" >${loginUser.nickname}님 마이페이지</a></span>
                        <span><a href="${contextPath}/user/logout" >로그아웃</a></span>
                    </c:when>
                    <c:otherwise>
                        <span><a href="${contextPath}/user/login" >로그인</a></span>
                        <span><a href="${contextPath}/user/insert">회원가입</a></span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <script>
        $(function() {
            $(".headerLogo").click(function() {
                var contextPath = "${contextPath}";
                window.location.href = contextPath;
            });
        });
    </script>
</body>
</html>
