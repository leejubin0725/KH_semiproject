<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${contextPath }/resources/css/headerStyle.css">
</head>
<body>
    <div class="headerContainer">
        <div class="header-main">
            <div class="headerNav">
                <span><a href="${contextPath}" style="text-decoration: none; color: inherit;">홈</a></span>
                <span><a href="${contextPath}/order/noticeboard" style="text-decoration: none; color: inherit;">배달목록</a></span>
                <span><a href="${contextPath}/inquiry/customerservice" style="text-decoration: none; color: inherit;">고객문의</a></span>
            </div>
            <div class="headerNav2">


                <c:choose>
                    <c:when test="${not empty loginUser}">
                        <span><a href="${contextPath}/user/mypage" style="text-decoration: none; color: inherit;">마이페이지</a></span>
                        <span><a href="${contextPath}/user/logout" style="text-decoration: none; color: inherit;">로그아웃</a></span>
                    </c:when>
                    <c:otherwise>
                        <span><a href="${contextPath}/user/login" style="text-decoration: none; color: inherit;">로그인</a></span>
                        <span><a href="${contextPath}/user/insert" style="text-decoration: none; color: inherit;">회원가입</a></span>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</body>
</html>
