<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="description" content="Figma htmlGenerator">
    <meta name="author" content="htmlGenerator">
    <link href="https://fonts.googleapis.com/css?family=Sigmar+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath }/resources/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp" %>
    <div class="main-content">
        <div class="image-container">
            <img src="${contextPath }/resources/images/cut.png">
            <div class="title">delivery</div>
            <div class="title2">service</div>
        </div>
        <div class="card-title">배달 목록</div>
        <div class="content">
            <div class="card">배달 게시글 1</div>
            <div class="card">배달 게시글 2</div>
            <div class="card">배달 게시글 3</div>
            <div class="card">배달 게시글 4</div>
        </div>
        <button class="button-plus">더보기...</button>
    </div>
    <div class="footer"></div>

    <script>
        $(document).ready(function(){
            $(".footer").load("footer.jsp");
        });
    </script>
    <%@ include file="footer.jsp" %>
</body>
</html>

