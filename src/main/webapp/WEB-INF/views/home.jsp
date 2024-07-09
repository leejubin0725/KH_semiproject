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
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

    <div class="main-content">
        <div class="image-container">
            <img src="${contextPath }/resources/images/rider.png">
            <div class="title">delivery</div>
            <div class="title2">service</div>
        </div>
        <div class="card-title">최근 게시글</div>
        <div class="content">
            <div class="card">
            	<c:choose>
				    <c:when test="${urgentlist[0] ne null}">
				    	<c:if test="${urgentlist[0].ordersImg.imgNo ne null}">
				    		<img src="${contextPath }/resources/images/Orders/${urgentlist[0].ordersImg.changeName}">
				    	</c:if>
				    	${urgentlist[0].orderNo}
				    </c:when>
				    <c:otherwise>주문을 기다립니다.</c:otherwise>
				 </c:choose>
            </div>
            <div class="card">
            	<c:choose>
				    <c:when test="${urgentlist[1] ne null}">
				    	<c:if test="${urgentlist[1].ordersImg.imgNo ne null}">
				    		<img src="${contextPath }/resources/images/Orders/${urgentlist[1].ordersImg.changeName}">
				    	</c:if>
				    	${urgentlist[1].orderNo}
				    </c:when>
				    <c:otherwise>주문을 기다립니다.</c:otherwise>
				</c:choose>
            </div>
            <div class="card">
            	<c:choose>
				    <c:when test="${urgentlist[2] ne null}">
				    	<c:if test="${urgentlist[2].ordersImg.imgNo ne null}">
				    		<img src="${contextPath }/resources/images/Orders/${urgentlist[2].ordersImg.changeName}">
				    	</c:if>
				    	${urgentlist[2].orderNo}
				    </c:when>
				    <c:otherwise>주문을 기다립니다.</c:otherwise>
				</c:choose>
            </div>
        </div>
        <button onclick="noticeboard()" class="button-plus">더보기</button>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script>
    	function noticeboard(){
    		 location.href = '${contextPath}/order/noticeboard';
    	}
    	
    	var cards = document.querySelectorAll('.card');
    	
    	cards.forEach(div => {
    		div.addEventListener("click" , function (e){	
    			window.location.href = `${contextPath}/order/detailProduct/` + e.target.innerText;
        	})
    	});
    	
    	
    	
    </script>
</body>

</html>

