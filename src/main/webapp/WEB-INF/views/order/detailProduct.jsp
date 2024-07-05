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
</style>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>

</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="frame">
    <div class="main-image"></div>
    <h1 class="product-title">상품 제목!</h1>
    <div class="author-nickname">작성자 닉네임</div>
    <p class="product-description">본문 및 설명 자리 (가변적으로 늘어남)</p>
    <div id="map"></div> <!-- 지도를 표시할 div -->
    <div class="category">대분류/소분류</div>
    <div class="price">가격</div>
    <div class="delivery-info">배송정보 ex)주소</div>
    <button class="map-button" onclick="expandMapImage()">지도 보기</button>
    <button class="restore-button" onclick="restoreMapImage()">복구</button>
    <button id="resetButton" onclick="clearMap()">초기화</button> <!-- 추가된 초기화 버튼 -->
    <div id="address"></div>
    
    <table class="comments-table">
        <thead>
            <tr>
                <th>별점</th>
                <th>글쓴이</th>
                <th>댓글 내용</th>
                <th>작성시간</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="rating">
                        <span class="star" onclick="setRating(1)">★</span>
                        <span class="star" onclick="setRating(2)">★</span>
                        <span class="star" onclick="setRating(3)">★</span>
                        <span class="star" onclick="setRating(4)">★</span>
                        <span class="star" onclick="setRating(5)">★</span>
                    </div>
                </td>
                <td>배달해줘</td>
                <td>이름숨김</td>
                <td>2023-12-17</td>
                <td>3</td>
            </tr>
            <!-- 더 많은 댓글 행을 여기에 추가할 수 있습니다 -->
        </tbody>
    </table>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
let currentRating = 3; // 초기 별점 설정

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
    level: 3 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다

// 현재 위치를 가져와서 지도의 중심으로 설정
if (navigator.geolocation) { // 브라우저가 Geolocation을 지원하는지 확인합니다
    navigator.geolocation.getCurrentPosition(function(position) { // 현재 위치를 가져옵니다
        var lat = position.coords.latitude; // 위도를 가져옵니다
        var lon = position.coords.longitude; // 경도를 가져옵니다
        
        var locPosition = new kakao.maps.LatLng(lat, lon); // 위도와 경도를 기반으로 새로운 LatLng 객체를 생성합니다

        map.setCenter(locPosition); // 현재 위치로 지도의 중심을 이동시킵니다
        getAddressFromCoords(locPosition); // 현재 위치의 주소를 가져옵니다
    }, function(error) { // 위치를 가져오는 데 실패한 경우 오류를 콘솔에 출력합니다
        console.error(error);
    });
} else {
    console.error("Geolocation is not supported by this browser."); // 브라우저가 Geolocation을 지원하지 않는 경우 메시지를 출력합니다
}

var markers = []; // 마커를 저장할 배열
var polylines = []; // 폴리라인을 저장할 배열

// 지도 클릭 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    if (markers.length >= 2) { // 마커가 2개 이상일 때 클릭하면 모든 마커와 폴리라인을 제거합니다
        clearMap();
    } else {
        // 클릭한 위치의 좌표를 가져옵니다 
        var latlng = mouseEvent.latLng;
        
        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: latlng // 마커의 위치를 클릭한 좌표로 설정합니다
        });

        // 지도에 마커를 표시합니다
        marker.setMap(map);
        
        // 마커를 배열에 추가합니다
        markers.push(marker);

        // 클릭한 위치의 주소를 가져옵니다
        getAddressFromCoords(latlng);

        // 두 개의 마커가 있는 경우 경로를 요청하고 폴리라인을 그립니다
        if (markers.length === 2) {
            findRouteAndDrawLine();
        }
    }
});

function findRouteAndDrawLine() {
    var start = markers[0].getPosition(); // 첫 번째 마커의 위치를 가져옵니다
    var end = markers[1].getPosition(); // 두 번째 마커의 위치를 가져옵니다
    
    console.log("Start:", start);
    console.log("End:", end);
    
    var url = `https://apis-navi.kakaomobility.com/v1/directions?origin=\${start.getLng()},\${start.getLat()}&destination=\${end.getLng()},\${end.getLat()}&waypoints=&priority=RECOMMEND&road_details=false`;
    
    console.log("URL:", url);
    
    fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': 'KakaoAK d0e8fab65653662fce2c093339eeeb25'
        }
    })
    .then(response => {
        console.log("Response Status:", response.status); // 응답 상태 코드 출력
        return response.json();
    }) // 응답을 JSON 형식으로 변환합니다
    .then(data => {
        console.log("Data:", data); // 받아온 데이터 출력
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

function clearMap() {
    // 모든 마커 제거
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null); // 지도에서 마커를 제거합니다
    }
    markers = []; // 마커 배열을 초기화합니다

    // 모든 폴리라인 제거
    for (var i = 0; i < polylines.length; i++) {
        polylines[i].setMap(null); // 지도에서 폴리라인을 제거합니다
    }
    polylines = []; // 폴리라인 배열을 초기화합니다
}

function getAddressFromCoords(coords) {
    // 좌표를 주소로 변환합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), function(result, status) {
        if (status === kakao.maps.services.Status.OK) { // 주소 변환이 성공한 경우
            var address = result[0].address.address_name; // 변환된 주소를 가져옵니다
            document.getElementById('address').innerText = '좌표의 주소는 ' + address + ' 입니다.'; // 주소를 화면에 표시합니다
        }
    });
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
    }, 1); // 

    // 일정 시간 후 인터벌 정지 (예: 1초 후 정지)
    setTimeout(() => {
        clearInterval(intervalId);
    }, 300); // 1초 후에 인터벌 정지
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

</script>
</body>
</html>
