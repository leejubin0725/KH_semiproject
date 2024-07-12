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
    <style>
        /* 여기에 CSS 코드 추가 */
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <img src="${contextPath}/resources/images/dd.jpg" id="middle-img">
    
    <div class="container">
        <h2>배달 요청</h2>
        <div class="container">
            <div class="dropdown-container">
                <div class="dropdown">
                    <button class="dropbtn">대분류 지역 선택</button>
                    <div class="dropdown-content">
                        <a href="#" data-location="전체">전체</a>
                        <a href="#" data-location="서울">서울</a>
                        <a href="#" data-location="경기">경기</a>
                        <a href="#" data-location="인천">인천</a>
                        <a href="#" data-location="부산">부산</a>
                        <a href="#" data-location="충청">충청</a>
                        <a href="#" data-location="경상">경상</a>
                        <a href="#" data-location="전라">경상</a>
                        <a href="#" data-location="대구">대구</a>

                        <!-- 필요한 대분류 지역 항목들을 추가 -->
                    </div>
                </div>
            </div>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="시작위치 검색">
                <button id="searchButton">검색</button>
            </div>
        </div>
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
    
    <c:set var="url" value="${noticeboard }?currentPage=" />
	   <div id="pagingArea">
	       <ul class="pagination">
	           <!-- 이전 페이지 링크 -->
	           <c:if test="${pi.currentPage eq 1}">
	               <li class="page-item disabled">
	                   <span class='page-link'>이전</span>
	               </li>
	           </c:if>
	           <c:if test="${pi.currentPage ne 1}">
	               <li class="page-item">
	                   <a class='page-link' href="${url}${pi.currentPage - 1}${sParam}">이전</a>
	               </li>
	           </c:if>
	   
	           <!-- 페이지 번호 링크 -->
	           <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
	               <li class="page-item ${i eq pi.currentPage ? 'active' : ''}">
	                   <a class="page-link" href="${url}${i}${sParam}">${i}</a>
	               </li>
	           </c:forEach>
	   
	           <!-- 다음 페이지 링크 -->
	           <c:if test="${pi.currentPage eq pi.maxPage}">
	               <li class="page-item disabled">
	                   <span class='page-link'>다음</span>
	               </li>
	           </c:if>
	           <c:if test="${pi.currentPage ne pi.maxPage}">
	               <li class="page-item">
	                   <a class='page-link' href="${url}${pi.currentPage + 1}${sParam}">다음</a>
	               </li>
	           </c:if>
	       </ul>
	   </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownLinks = document.querySelectorAll('.dropdown-content a');
            const searchInput = document.getElementById('searchInput');
            const searchButton = document.getElementById('searchButton');

            dropdownLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const selectedLocation = this.getAttribute('data-location'); // 선택된 지역 이름

                    // 모든 행을 가져와서 처리
                    const tableRows = document.querySelectorAll('tbody tr');

                    // "전체" 선택 시 모든 행 보이기
                    if (selectedLocation === '전체') {
                        tableRows.forEach(row => {
                            row.style.display = '';
                        });
                    } else {
                        // 선택된 지역에 해당하는 행만 표시
                        tableRows.forEach(row => {
                            const startPointCell = row.querySelector('td:nth-child(5)');
                            if (startPointCell.textContent.includes(selectedLocation)) {
                                row.style.display = ''; // 행 보이기
                            } else {
                                row.style.display = 'none'; // 행 숨기기
                            }
                        });
                    }
                });
            });

            searchButton.addEventListener('click', function() {
                const searchText = searchInput.value.trim().toLowerCase(); // 입력된 검색어

                // 모든 행을 가져와서 처리
                const tableRows = document.querySelectorAll('tbody tr');

                tableRows.forEach(row => {
                    const startPointCell = row.querySelector('td:nth-child(5)');
                    const orderTitleCell = row.querySelector('td:nth-child(2)');
                    const startPointText = startPointCell.textContent.trim().toLowerCase();
                    const orderTitleText = orderTitleCell.textContent.trim().toLowerCase();

                    if (startPointText.includes(searchText) || orderTitleText.includes(searchText)) {
                        row.style.display = ''; // 행 보이기
                    } else {
                        row.style.display = 'none'; // 행 숨기기
                    }
                });
            });
        });

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

        // 새로운 버튼에 대한 이벤트 리스너
        document.getElementById('customButton').addEventListener('click', function() {
            window.location.href = "${contextPath}/order/orderInsert";
        });
    </script>
</body>
</html>
