<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detailProduct.css">
<style>
    #map {
        width: 400px;
        height: 400px;
    }
    #resetButton {
        margin-top: 10px;
    }
    .comments-actions {
        margin-top: 20px; /* 수락하기 버튼 위 여백 추가 */
    }
    .comments-actions button {
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
    .comments-actions button:hover {
        background-color: #0056b3;
    }
</style>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<c:set var="orderImageUploadPath" value="/resources/images/Orders/"></c:set>
<div class="frame">
    <div class="main-image">
         <img src="${contextPath}${orderImageUploadPath}${order.ordersImg.changeName}" alt="Main Image">
    </div>
    <h1 class="product-title">${order.orderTitle}</h1>
    <div class="author-nickname">${order.writer}</div>
    <p class="product-description">${order.orderContent}</p>
    <div id="map"></div>
    <div class="price">배송비: ${order.price}원</div>
   
   <div class="alert">
    <c:if test="${order.alertFragile == 'Y'}">
        <p><input type="checkbox" id="fragileCheckbox" checked disabled> 파손 주의</p>
    </c:if>
    <c:if test="${order.alertValuable == 'Y'}">
        <p><input type="checkbox" id="valuableCheckbox" checked disabled> 귀중품 주의</p>
    </c:if>
    <c:if test="${order.alertUrgent == 'Y'}">
        <p><input type="checkbox" id="urgentCheckbox" checked disabled> 긴급 배송 요청</p>
    </c:if>
   </div>
   
    <div class="delivery-info">출발 위치: ${order.startPoint}<br/>배송 거리: ${order.distance}km<br/><br>주문일자: ${order.startDate}</div>
    <button class="map-button" onclick="expandMapImage()">지도 보기</button>
    <button class="restore-button" onclick="restoreMapImage()">복구</button>
    
    <div class="end-point">수령 위치: ${order.endPoint}</div>

    <table id="reniewArea" class="comments-table">
       <thead>
           <tr>
               <td colspan="3">댓글(<span id="rcount">${empty board.reniewList ? '0' : board.reniewList.size()}</span>)</td>
           </tr>
           <tr>
               <th>별점</th>
               <th>글쓴이</th>
               <th>댓글 내용</th>
               <th>작성일</th>
           </tr>
       </thead>
       <tbody>
           <tr>
               <td colspan="5">
                   <div style="display: flex; align-items: center;">
                       <div class="rating" style="margin-right: 20px;">
                           <span class="star" onclick="setRating(1)">★</span>
                           <span class="star" onclick="setRating(2)">★</span>
                           <span class="star" onclick="setRating(3)">★</span>
                           <span class="star" onclick="setRating(4)">★</span>
                           <span class="star" onclick="setRating(5)">★</span>
                       </div>
                       <input type="text" id="commentContent" style="flex-grow: 1; padding: 3px; margin-right: 4px" />
                       <button type="button" onclick="submitComment()">댓글 달기</button>
                   </div>
               </td>
           </tr>
           <tr>
               <td colspan="5">
               <c:if test="${sessionScope.loginUser.role == 'rider' || 'admin'}">
                   <div class="comments-actions">
                       <button onclick="accept()">수락하기</button>
                   </div>
                   </c:if>
               </td>
           </tr>
           <c:forEach var="reniew" items="${board.reniewList}">
               <tr>
                   <td>${reniew.score}</td>
                   <td>${reniew.writer}</td>
                   <td>${reniew.content}</td>
                   <td>${reniew.createDate}</td>
                   <td>${reniew.riderNo}</td>
               </tr>
           </c:forEach>
       </tbody>
    </table>
    
    <!-- 채팅방 생성 및 참가 버튼 추가 -->
    <div class="chat-actions">
        <button onclick="createChatRoom(${order.orderNo})">채팅방 생성</button>
        <button onclick="joinChatRoom(${order.orderNo})">채팅방 참가</button>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
let currentRating = 0; // 초기 별점 설정

function setRating(rating) {
    currentRating = rating;

    const stars = document.querySelectorAll('.star');
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('checked');
        } else {
            star.classList.remove('checked');
        }
    });

    // 별점을 텍스트로 업데이트
    const starRatingText = getStarRatingText(rating);
    const starRatingCell = document.querySelector('.star-rating');
    starRatingCell.textContent = starRatingText;
}

function editStarRating() {
    // 편집 모드로 전환하기 위한 로직 추가 가능
    console.log('Editing star rating...');
}

function getStarRatingText(rating) {
    switch (rating) {
        case 1:
            return '★☆☆☆☆';
        case 2:
            return '★★☆☆☆';
        case 3:
            return '★★★☆☆';
        case 4:
            return '★★★★☆';
        case 5:
            return '★★★★★';
        default:
            return '별점 없음';
    }
}

// 채팅방 생성 함수
function createChatRoom(orderId) {
    var password = prompt("채팅방 비밀번호를 입력하세요:");
    if (password != null && password != "") {
        $.ajax({
            url: '${pageContext.request.contextPath}/chatRoom/create',
            type: 'POST',
            data: { orderId: orderId, password: password },
            success: function(response) {
                alert(response);
            },
            error: function(xhr, status, error) {
                alert("채팅방 생성 중 오류가 발생했습니다: " + error);
            }
        });
    } else {
        alert("비밀번호를 입력해주세요.");
    }
}

// 채팅방 참가 함수
function joinChatRoom(orderId) {
    var password = prompt("채팅방 비밀번호를 입력하세요:");
    if (password != null && password != "") {
        window.location.href = '${pageContext.request.contextPath}/chatRoom/join?orderId=' + orderId + '&password=' + password;
    } else {
        alert("비밀번호를 입력해주세요.");
    }
}

function accept(){
	alert('수락되었습니다.');
	location.href = "${contextPath}"
}

document.addEventListener('DOMContentLoaded', function() {
    const fragileCheckbox = document.getElementById('fragileCheckbox');
    const valuableCheckbox = document.getElementById('valuableCheckbox');
    const urgentCheckbox = document.getElementById('urgentCheckbox');

    // JavaScript에서 이벤트 처리 또는 초기 설정이 필요한 경우에 추가 작업 수행
    // 예: 체크박스에 대한 추가적인 동작이나 스타일링 등
});

</script>
</body>
</html>
