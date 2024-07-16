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
    <link rel="stylesheet" href="${contextPath}/resources/css/home.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

    <div class="slideshow-container">
    <div class="image-slide">
        <img id="slideshow-img" src="${contextPath}/resources/images/last.png">
    </div>
</div>
        
        
        <div class="card-title">긴급 배송</div>
        <div class="content">
            <c:choose>
                <c:when test="${empty urgentlist}">
                    <div class="large-text">현재 긴급 배송 게시글이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${urgentlist}" var="urgent">
                        <div class="card"
                             data-url="${contextPath}/order/detailProduct/${urgent.orderNo}">
                            <c:choose>
                                <c:when test="${urgent.ordersImg.imgNo ne null}">
                                    <img src="${contextPath}/resources/images/Orders/${urgent.ordersImg.changeName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${contextPath}/resources/images/no-image.png" alt="No Image Available">
                                </c:otherwise>
                            </c:choose>
                            <div class="orderTitle">${urgent.orderTitle}</div> <!-- 주문명 추가 -->
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script>
    var images = [
        "${contextPath}/resources/images/last.png",
        "${contextPath}/resources/images/real.png",
        "${contextPath}/resources/images/reallast.png"
        // 필요한 만큼 이미지 경로를 추가할 수 있습니다
    ];

    var currentIndex = 0;
    var slideshowImg = document.getElementById('slideshow-img');

    // 5초마다 이미지 변경 함수
    function changeSlide() {
        slideshowImg.src = images[currentIndex];
        currentIndex = (currentIndex + 1) % images.length; // 다음 이미지 인덱스 계산
    }

    // 페이지 로드 후 처음 한 번 실행
    changeSlide();

    // 5초마다 changeSlide 함수 호출
    setInterval(changeSlide,2000);
        function noticeboard(){
            location.href = '${contextPath}/order/noticeboard';
        }
        
        var cards = document.querySelectorAll('.card');
        
        cards.forEach(div => {
            div.addEventListener("click" , function (e){    
                window.location.href = div.getAttribute('data-url');
            })
        });
    </script>
</body>
</html>
