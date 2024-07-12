<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detailProduct.css">
<style>


</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>
<script>
let mapDisplayed = false; // 지도 보기 상태를 관리하는 변수
let mapInstance = null; // Kakao 지도 인스턴스 변수
let linePath = []; // 선의 경로를 담을 배열

function showMap() {
    if (!mapDisplayed) {
        // 지도가 보이지 않는 경우에만 보이도록 처리
        document.getElementById('map').style.display = 'block';
        initializeMap();
        mapDisplayed = true;
    }
}

function hideMap() {
    if (mapDisplayed) {
        // 지도가 보이는 경우에만 숨기도록 처리
        document.getElementById('map').style.display = 'none';
        mapDisplayed = false;
    }
}

function initializeMap() {
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
}


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<c:set var="orderImageUploadPath" value="/resources/images/Orders/"></c:set>
<div class="frame">
    <div class="main-image">
        <c:choose>
            <c:when test="${not empty order.ordersImg.changeName}">
                <img src="${contextPath}${orderImageUploadPath}${order.ordersImg.changeName}" alt="Main Image">
            </c:when>
            <c:otherwise>
                <div class="no-image">
                    <img src="${pageContext.request.contextPath}/resources/images/no-image.png" alt="No Image">
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="product-box">
        <h1 class="product-title">${order.orderTitle}</h1>
    </div>
    <div class="author-nickname">${order.writer}</div>
    <p class="product-description">${order.orderContent}</p>
    <div id="map"></div> <!-- 지도를 표시할 div -->
    <div class="price">배송비: ${order.price}원</div>

    <div class="alert">
        <c:if test="${order.alertFragile == 'Y'}">
            <p><input type="checkbox" id="fragileCheckbox" checked disabled> <span style="color: black;">파손 주의</span></p>
        </c:if>
        <c:if test="${order.alertValuable == 'Y'}">
            <p><input type="checkbox" id="valuableCheckbox" checked disabled> <span style="color: black;">귀중품 주의</span></p>
        </c:if>
        <c:if test="${order.alertUrgent == 'Y'}">
            <p><input type="checkbox" id="urgentCheckbox" checked disabled> 긴급 배송 요청</p>
        </c:if>
    </div>

    <div class="delivery-info">출발 위치: ${order.startPoint}<br/>배송 거리: ${order.distance}km<br/><br>수령 위치: ${order.endPoint}</div>

    <div class="status-info ${order.orderStatus == '대기중' ? 'status-waiting' : (order.orderStatus == '배달중' ? 'status-in-progress' : 'status-completed')}">
        ${order.orderStatus == '대기중' ? '대기중' : (order.orderStatus == '배달중' ? '배달중' : '배달완료')}
    </div>

    <div class="map-buttons">
        <button class="map-button" onclick="showMap()">지도 보기</button>
        <button class="map-button" onclick="hideMap()">지도 숨기기</button>
    </div>

    <div class="end-point">주문일자: ${order.startDate}</div>

    <table id="reviewArea" class="comments-table">
        <thead>
            <tr>
                <td colspan="4">댓글(<span id="rcount">${empty board.reviewList ? '0' : board.reviewList.size()}</span>)</td>
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
                <td colspan="4">
                    <div style="display: flex; align-items: center;">
                        <div class="rating" style="margin-right: 20px;">
                            <span class="star" onclick="setRating(1)">★</span>
                            <span class="star" onclick="setRating(2)">★</span>
                            <span class="star" onclick="setRating(3)">★</span>
                            <span class="star" onclick="setRating(4)">★</span>
                            <span class="star" onclick="setRating(5)">★</span>
                        </div>
                        <input type="text" id="reviewContent" style="flex-grow: 1; padding: 3px; margin-right: 4px" />
                        <button type="button" onclick="insertReview()">댓글 달기</button>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <!-- <c:if test="${(sessionScope.loginUser.role == 'rider' || sessionScope.loginUser.role == 'admin') && order.orderStatus == '대기중' && order.riderNo != null}"> -->
                    <div class="comments-actions">
                        <button onclick="accept()">수락하기</button>
                    </div>
                    <!-- </c:if> -->
                </td>
            </tr>
            
            <c:forEach var="review" items="${board.reviewList}">
                <tr id="review-${review.reviewNo}">
                    <td>${review.rating}</td>
                    <td>${review.writer}</td>
                    <td>${review.reviewContent}</td>
                    <td>${review.createDate}</td>
                    <td>
                        <c:if test="${sessionScope.loginUser.userId == review.writerId || sessionScope.loginUser.role == 'admin'}">
                            <button onclick="updateReview(${review.reviewNo})">수정</button>
                            <button onclick="deleteReview(${review.reviewNo})">삭제</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
