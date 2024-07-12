<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Figma htmlGenerator">
    <meta name="author" content="htmlGenerator">
    <link href="https://fonts.googleapis.com/css?family=Sigmar+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeboard.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <img src="${contextPath}/resources/images/dd.jpg" id="middle-img">
    
    <div class="container">
        <h2>배달 요청</h2>
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>제목</th>
                    <th>작성자 닉네임</th>
                    <th>라이더</th>
                    <th>시작위치</th>
                    <th>도착위치</th>
                    <th>작성시간</th>
                    <th>가격</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="8" class="no-orders">새 주문을 요청하세요!</td>
                    </tr>
                </c:if>
                <c:forEach items="${list}" var="order">
                    <tr class="clickable-row" data-url="${contextPath}/order/detailProduct/${order.orderNo}">
                        <td>${order.orderNo}</td>
                        <td>${order.orderTitle}</td>
                        <td>${order.writer}</td>
                        <td>
                        <span class="status-circle ${order.orderStatus == '대기중' ? 'status-waiting' : (order.orderStatus == '배달중' ? 'status-in-progress' : 'status-completed')}">
                         ${order.orderStatus == '대기중' ? '대기중' : (order.orderStatus == '배달중' ? '배달중' : '배달완료')}
                     </span>
                    </td>
                        <td>${order.startPoint}</td>
                        <td>${order.endPoint}</td>
                        <td>${order.createDate}</td>
                        <td>${order.price}원</td>
                    </tr>
                </c:forEach>      
            </tbody>
        </table>
        <div class="btn-container">
            <c:if test="${sessionScope.loginUser.role == 'regular'}">
                <button class="custom-button" id="customButton">배달 요청하기</button>
            </c:if>
            <c:if test="${sessionScope.loginUser.role == 'regular'}">
                <button onclick="submitReport()" class="red-button" id="reportButton">신고하기</button>
            </c:if>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        function submitReport() {
            location.href = "${contextPath}/report/report/";
        }

        document.querySelectorAll('tbody tr').forEach(row => {
            row.addEventListener('click', function(event) {
                // 클릭된 요소가 라이더 상태 버튼이 아닌 경우에만 페이지 이동
                if (!event.target.closest('.rider-status')) {
                    // 행에 설정된 data-url 속성 값으로 이동
                    const url = this.getAttribute('data-url');
                    if (url) {
                        window.location.href = url;
                    }
                }
            });
        });

        // 라이더 상태 버튼에 대한 별도의 이벤트 리스너
        document.querySelectorAll('.rider-status').forEach(button => {
            button.addEventListener('click', function(event) {
                event.stopPropagation(); // 이벤트 버블링 방지
                console.log('Rider status button clicked');
                // 여기에 라이더 상태 버튼 클릭 시 수행할 동작을 추가하세요
            });
        });

        // 새로운 버튼에 대한 이벤트 리스너
        document.getElementById('customButton').addEventListener('click', function() {
            window.location.href = "${contextPath}/order/orderInsert";
        });
    </script>
</body>
</html>
