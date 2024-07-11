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
        margin-top: 20px;
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                   <div class="comments-actions"></div>   		
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

buttonSelction();
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
    const starRatingText = getStarRatingText(rating);
    const starRatingCell = document.querySelector('.star-rating');
    starRatingCell.textContent = starRatingText;
}

function editStarRating() {
    console.log('Editing star rating...');
}

function getStarRatingText(rating) {
    const ratings = ['별점 없음', '★☆☆☆☆', '★★☆☆☆', '★★★☆☆', '★★★★☆', '★★★★★'];
    return ratings[rating] || ratings[0];
}

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
    location.href = "${contextPath}/order/orderAccept?orderNo=${order.orderNo}"
}

function orderEnd() {
	window.location.href = "${contextPath}/order/orderEnd?orderNo=${order.orderNo}";
}

function buttonSelction() {
	
		var userRole = "${sessionScope.loginUser.role}";
		var orderStatus = "${order.orderStatus}";
		var orderRiderNo = ${order.riderNo};
		
		var buttons="";
		$(".comments-actions").html(buttons);
		
		if(userRole == "rider"){
			$.ajax({
		        url : "${pageContext.request.contextPath}/order/riderOrderSelectAjax",
		        data : {
		        	orderRiderNo : orderRiderNo
		        },
		        success : function(result){
		        	if(orderRiderNo == 0){
		        		buttons = (orderRiderNo == result) ? "" : "<button type='button' onclick='accept()'>주문 수락</button>";
		        		$(".comments-actions").html(buttons);
		        	}
		        	
		        	else {
		        		console.log(result);
		        		buttons = (orderRiderNo == result) ? "<button type='button' onclick='orderEnd()'>배송 완료</button>" : "";
		        		$(".comments-actions").html(buttons);
		        	}
		        }		        	      
		    });
		} 	
}

function formatDate(timestamp) {
    const date = new Date(timestamp);
    const year = date.getFullYear().toString().slice(-2); // Get last 2 digits of year
    const month = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero-based
    const day = ('0' + date.getDate()).slice(-2);
    return `\${year}-\${month}-\${day}`;
}

var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667),
    level: 4
};

var map = new kakao.maps.Map(mapContainer, mapOption);
var geocoder = new kakao.maps.services.Geocoder();

var startPoint = "${order.startPoint}";
var endPoint = "${order.endPoint}";

var markers = [];
var polylines = [];

function geocodeAddress(address, callback) {
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            callback(new kakao.maps.LatLng(result[0].y, result[0].x));
        }
    });
}

geocodeAddress(startPoint, function(coords) {
    var startMarker = new kakao.maps.Marker({
        map: map,
        position: coords
    });
    markers.push(startMarker);
    adjustMapBounds();
});

geocodeAddress(endPoint, function(coords) {
    var endMarker = new kakao.maps.Marker({
        map: map,
        position: coords
    });
    markers.push(endMarker);
    adjustMapBounds();
    if (markers.length === 2) {
        findRouteAndDrawLine();
    }
});

function adjustMapBounds() {
    if (markers.length === 2) {
        var bounds = new kakao.maps.LatLngBounds();
        markers.forEach(marker => bounds.extend(marker.getPosition()));
        map.setBounds(bounds);
    }
}

function findRouteAndDrawLine() {
    var start = markers[0].getPosition();
    var end = markers[1].getPosition();
    
    var url = `https://apis-navi.kakaomobility.com/v1/directions?origin=\${start.getLng()},\${start.getLat()}&destination=\${end.getLng()},\${end.getLat()}&waypoints=&priority=RECOMMEND&road_details=false`;
    
    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'KakaoAK d0e8fab65653662fce2c093339eeeb25'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.routes && data.routes.length > 0) {
            var route = data.routes[0];
            var linePath = [];
            route.sections.forEach(section => {
                section.roads.forEach(road => {
                    for (let i = 0; i < road.vertexes.length; i += 2) {
                        linePath.push(new kakao.maps.LatLng(road.vertexes[i+1], road.vertexes[i]));
                    }
                });
            });

            var polyline = new kakao.maps.Polyline({
                path: linePath,
                strokeWeight: 5,
                strokeColor: '#86C1C6',
                strokeOpacity: 0.7,
                strokeStyle: 'solid'
            });

            polyline.setMap(map);
            polylines.push(polyline);

            var distance = polyline.getLength();
            var distanceKm = (distance / 1000).toFixed(2);
            console.log('두 마커 사이의 거리는 ' + distanceKm + ' km 입니다.');
        } else {
            console.log('경로를 찾을 수 없습니다.');
        }
    })
    .catch(error => console.log('경로 요청 중 오류 발생:', error));
}

function expandMapImage() {
    const mapImage = document.querySelector('#map');
    const mainImage = document.querySelector('.main-image');
    const restoreButton = document.querySelector('.restore-button');
    const elementsToHide = document.querySelectorAll('.product-title, .author-nickname, .product-description, .category, .price, .delivery-info');
    
    mapImage.style.width = mainImage.offsetWidth + 'px';
    mapImage.style.height = '500px';
    
    restoreButton.style.display = 'block';

    elementsToHide.forEach(element => element.classList.add('hidden'));
    
    const intervalId = setInterval(() => map.relayout(), 1);
    setTimeout(() => clearInterval(intervalId), 1000);
}

function restoreMapImage() {
    const mapImage = document.querySelector('#map');
    const restoreButton = document.querySelector('.restore-button');
    const elementsToHide = document.querySelectorAll('.product-title, .author-nickname, .product-description, .category, .price, .delivery-info');
    
    mapImage.style.width = '400px';
    mapImage.style.height = '400px';
    
    restoreButton.style.display = 'none';
    
    elementsToHide.forEach(element => element.classList.remove('hidden'));
}

document.addEventListener('DOMContentLoaded', function() {
    const fragileCheckbox = document.getElementById('fragileCheckbox');
    const valuableCheckbox = document.getElementById('valuableCheckbox');
    const urgentCheckbox = document.getElementById('urgentCheckbox');
});
</script>
</body>
</html>