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


var mapContainer = document.getElementById('map'); // 지도를 표시할 div

// 기본 위치 (임의의 위치 설정)
var mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 4 // 축소된 상태로 설정
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다

// 출발 위치와 도착 위치를 위도와 경도로 변환하여 마커를 찍기
var startPoint = "${order.startPoint}";
var endPoint = "${order.endPoint}";

var markers = []; // 마커를 저장할 배열
var polylines = []; // 폴리라인을 저장할 배열

geocoder.addressSearch(startPoint, function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        var startMarker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        markers.push(startMarker); // 마커를 배열에 추가합니다
        adjustMapBounds(); // 지도 경계 조정
        if (markers.length === 2) { // 두 개의 마커가 추가되면 경로를 찾고 폴리라인을 그립니다
            findRouteAndDrawLine();
        }
    }
});

geocoder.addressSearch(endPoint, function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        var endMarker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        markers.push(endMarker); // 마커를 배열에 추가합니다
        adjustMapBounds(); // 지도 경계 조정
        if (markers.length === 2) { // 두 개의 마커가 추가되면 경로를 찾고 폴리라인을 그립니다
            findRouteAndDrawLine();
        }
    }
});

function adjustMapBounds() {
    if (markers.length === 2) {
        var bounds = new kakao.maps.LatLngBounds();
        bounds.extend(markers[0].getPosition());
        bounds.extend(markers[1].getPosition());
        map.setBounds(bounds);
    }
}

function findRouteAndDrawLine() {
    var start = markers[0].getPosition(); // 첫 번째 마커의 위치를 가져옵니다
    var end = markers[1].getPosition(); // 두 번째 마커의 위치를 가져옵니다
    
    var url = `https://apis-navi.kakaomobility.com/v1/directions?origin=\${start.getLng()},\${start.getLat()}&destination=\${end.getLng()},\${end.getLat()}&waypoints=&priority=RECOMMEND&road_details=false`;
    
    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'KakaoAK d0e8fab65653662fce2c093339eeeb25'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.routes && data.routes.length > 0) { // 경로 데이터가 있는지 확인합니다
            var route = data.routes[0]; // 첫 번째 경로를 가져옵니다

            var linePath = []; // 폴리라인을 그리기 위한 좌표 배열
            route.sections.forEach(section => {
                section.roads.forEach(road => {
                    road.vertexes.forEach((vertex, index) => {
                        if (index % 2 === 0) {
                            linePath.push(new kakao.maps.LatLng(road.vertexes[index+1], road.vertexes[index])); // 경로의 좌표를 추가합니다
                        }
                    });
                });
            });

            // 지도에 표시할 선을 생성합니다
            var polyline = new kakao.maps.Polyline({
                path: linePath, // 선을 구성하는 좌표배열 입니다
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor: '#86C1C6', // 선의 색깔입니다
                strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });

            // 지도에 선을 표시합니다 
            polyline.setMap(map);
            polylines.push(polyline); // 폴리라인을 배열에 추가합니다

            // 경로의 총 거리를 계산합니다
            var distance = polyline.getLength(); // 단위: 미터
            var distanceKm = (distance / 1000).toFixed(2); // 단위: 킬로미터, 소수점 2자리까지 표시

            // 거리 콘솔에 표시
            console.log('두 마커 사이의 거리는 ' + distanceKm + ' km 입니다.');
        } else {
            console.log('경로를 찾을 수 없습니다.');
        }
    })
    .catch(error => console.log('경로 요청 중 오류 발생:', error)); // 오류가 발생하면 콘솔에 출력합니다
}

function accept(){
   alert('수락되었습니다.');
   location.href = "${contextPath}"
}

function expandMapImage() {
    const mapImage = document.querySelector('#map');
    const mainImage = document.querySelector('.main-image');
    const restoreButton = document.querySelector('.restore-button');
    const elementsToHide = document.querySelectorAll('.product-title, .author-nickname, .product-description, .category, .price, .delivery-info');
    
    const mainImageWidth = mainImage.offsetWidth;
    
    mapImage.style.width = mainImageWidth + 'px';
    mapImage.style.height = '500px'; /* main-image와 동일한 높이로 설정 */
    
    restoreButton.style.display = 'block'; /* 복구 버튼 보이도록 설정 */

    elementsToHide.forEach(element => {
        element.classList.add('hidden');
    });
    
    // 맵 갱신을 위한 인터벌 설정
    const intervalId = setInterval(() => {
        map.relayout();
    }, 1);

    // 일정 시간 후 인터벌 정지 (예: 1초 후 정지)
    setTimeout(() => {
        clearInterval(intervalId);
    }, 1000); // 1초 후에 인터벌 정지
}

function restoreMapImage() {
    const mapImage = document.querySelector('#map');
    const restoreButton = document.querySelector('.restore-button');
    const elementsToHide = document.querySelectorAll('.product-title, .author-nickname, .product-description, .category, .price, .delivery-info');
    
    mapImage.style.width = '400px'; /* 원래 크기로 복구 */
    mapImage.style.height = '400px';
    
    restoreButton.style.display = 'none'; /* 복구 버튼 숨기기 */
    
    elementsToHide.forEach(element => {
        element.classList.remove('hidden');
    });
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
