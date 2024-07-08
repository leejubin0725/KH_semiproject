<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>배달 서비스</title>
<link
	href="https://fonts.googleapis.com/css?family=Inter|Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<style>
/* 내부 스타일로 추가한 CSS */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background: linear-gradient(0deg, #F5F5F5, #F5F5F5), #FFFFFF;
}

.main {
	position: relative;
	width: 100%;
	max-width: 2410px;
	margin: 0 auto;
	padding-top: 56px;
}

.header {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	height: 56px;
	background: #FFFFFF;
	z-index: 1000;
}

.nav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 20px;
	height: 100%;
}

.nav-links {
	display: flex;
	gap: 20px;
}

.nav-link {
	font-family: 'Roboto', sans-serif;
	font-weight: 700;
	font-size: 20px;
	color: #3A3A3A;
	text-decoration: none;
}

.user-links {
	display: flex;
	gap: 20px;
}

.user-link {
	font-size: 12px;
	color: #000000;
	text-decoration: none;
}

.section-title {
	text-align: center;
	font-size: 32px;
	font-weight: 700;
	margin-top: 40px;
}

.delivery-list {
	background: #FFFFFF;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	margin: 20px;
	padding: 20px;
}

.table {
	width: 100%;
	border-collapse: collapse;
}

.table th, .table td {
	border-bottom: 1px solid #DDDDDD;
	padding: 10px;
	text-align: left;
}

.table th {
	background: #F2F2F2;
	font-weight: 700;
}

.status {
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 12px;
	color: #FFFFFF;
}

.status-ongoing {
	background: #FFC107;
}

.status-completed {
	background: #4CAF50;
}

.footer {
	background: #333333;
	color: #FFFFFF;
	text-align: center;
	padding: 20px 0;
	font-size: 13px;
}

.delete-btn {
	position: relative;
	width: 92px;
	height: 30px;
	background: #2196F3;
	border-radius: 8px;
	border: none;
	color: #FFFFFF;
	font-family: 'Inter', sans-serif;
	font-size: 12px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.delete-btn::before {
	content: "";
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	width: 12px;
	height: 12px;
	background: #FFFFFF;
	mask-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>');
	mask-size: cover;
}

.delete-btn:hover {
	background: #1976D2;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
}

.delete-all-btn {
	width: 120px;
	height: 36px;
	background: #F44336;
	border-radius: 8px;
	border: none;
	color: #FFFFFF;
	font-family: 'Inter', sans-serif;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.delete-all-btn::before {
	content: "";
	display: inline-block;
	width: 16px;
	height: 16px;
	margin-right: 8px;
	background: #FFFFFF;
	mask-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>');
	mask-size: cover;
}

.delete-all-btn:hover {
	background: #D32F2F;
}
</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="main">
		<h1 class="section-title">빠른 퀵 서비스로 소비자를 사로잡다</h1>

		<section class="delivery-list">
			<h2>내가 쓴 글</h2>
			<div class="button-container">
				<button class="delete-all-btn" onclick="deleteAll()">전체 삭제</button>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>진행상태</th>
						<th>조회수</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="order">
						<tr class="clickable-row" data-id="${order.orderNo}">
							<td>${order.orderNo}</td>
							<td>${order.orderTitle}</td>
							<td>${order.userNo}</td>
							<td>${order.createDate}</td>
							<td><span class="rider-status">${order.orderStatus}</span></td>
							<td>3</td>
							<td><button class="delete-btn" onclick="deleteRow(this)">Delete</button></td>
						</tr>
					</c:forEach>
					<!-- 추가 행들... -->
				</tbody>
			</table>
		</section>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script>
		function deleteRow(button) {
			// 삭제할 행(tr) 요소를 찾아서 삭제합니다.
			var row = button.parentNode.parentNode;
			row.parentNode.removeChild(row);
		}

		function deleteAll() {
			// 모든 행(tr) 요소를 삭제합니다.
			var tableBody = document.querySelector('.table tbody');
			tableBody.innerHTML = ''; // tbody 내용을 비웁니다.
		}
		
		document.querySelectorAll('tbody tr').forEach(row => {
            row.addEventListener('click', function(event) {
                    const url = "/semi/order/detailProduct/";
                    if (url) {
                        window.location.href = url;
                    }
                
            });
        });
	</script>
</body>

</html>
