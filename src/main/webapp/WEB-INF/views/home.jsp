<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="description" content="Figma htmlGenerator">
<meta name="author" content="htmlGenerator">
<link
	href="https://fonts.googleapis.com/css?family=Sigmar+One&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${contextPath }/resources/css/styles.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
            alertify.alert("알림", '${alertMsg}');
        </script>
		<c:remove var="alertMsg" scope="request" />
	</c:if>

	<div class="main-content">
		<div class="image-container">
			<img src="${contextPath }/resources/images/rider.png">
			<div class="title">delivery</div>
			<div class="title2">service</div>
		</div>
		<div class="card-title">최근 게시글</div>
		<div class="content">
			<c:forEach items="${urgentlist}" var="urgentlist">
				<div class="card"
					data-url="${contextPath}/order/detailProduct/${urgentlist.orderNo}">
					<c:if test="${urgentlist.ordersImg.imgNo ne null}">
						<img
							src="${contextPath }/resources/images/Orders/${urgentlist.ordersImg.changeName}">
					</c:if>
				</div>
			</c:forEach>
		</div>
		<button onclick="noticeboard()" class="button-plus">더보기</button>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
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

