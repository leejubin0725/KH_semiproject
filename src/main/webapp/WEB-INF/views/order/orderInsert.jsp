<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/writerStyle.css">
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-section">
            <div class="left-side">
                <label for="title">제목</label>
                <input type="text" id="title" placeholder="제목 입력">
                <label for="content">내용</label>
                <textarea id="content" placeholder="내용 입력"></textarea>
                <label for="category">대분류</label>
                <select id="category">
                    <option>Value</option>
                </select>
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="fragile">
                        <label for="fragile">파손 주의</label>
                    </div>
                    <p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="valuable">
                        <label for="valuable">귀중품 주의</label>
                    </div>
                    <p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="urgent">
                        <label for="urgent">긴급 배송 요청</label>
                    </div>
                    <p class="red">이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
            </div>
            <div class="right-side">
                <label for="file">파일 선택</label>
                <input type="file" id="file">
                <span>선택된 파일 없음</span>
                <div id="map" style="width: 100%; height: 400px;"></div>
                <div style="display: flex; justify-content: center;">
                    <button class="map-button" onclick="expandMapImage()">지도 보기</button>
                    <button class="restore-button" onclick="restoreMapImage()">복구</button>
                </div>
                <div class="input-group">
                    <label for="start-point">출발지</label>
                    <input type="text" id="start-point" placeholder="출발지" readonly required>
                </div>
                <div class="input-group">
                    <label for="end-point">도착지</label>
                    <input type="text" id="end-point" placeholder="도착지" readonly required>
                </div>
                 <div class="input-group">
                    <label for="dis">거리</label>
                    <input type="text" id="dis" placeholder="거리" readonly required>
                </div>
                <div class="input-group">
                    <label for="price" class="red">예상금액</label>
                    <input type="text" id="price" placeholder="예상금액" readonly required>
                </div>
                <div class="buttons">
                    <button type="button" onclick="sendData()">생성</button>
                    <button type="button">취소</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var geocoder = new kakao.maps.services.Geocoder();

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;
                var lon = position.coords.longitude;
                var locPosition = new kakao.maps.LatLng(lat, lon);
                map.setCenter(locPosition);
            }, function(error) {
                console.error(error);
            });
        } else {
            console.error("Geolocation is not supported by this browser.");
        }

        var markers = [];
        var polylines = [];

        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            if (markers.length >= 2) {
                clearMap();
            } else {
                var latlng = mouseEvent.latLng;
                var marker = new kakao.maps.Marker({
                    position: latlng
                });
                marker.setMap(map);
                markers.push(marker);
                getAddressFromCoords(latlng);
                if (markers.length === 2) {
                    findRouteAndDrawLine();
                }
            }
        });

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
                            road.vertexes.forEach((vertex, index) => {
                                if (index % 2 === 0) {
                                    linePath.push(new kakao.maps.LatLng(road.vertexes[index+1], road.vertexes[index]));
                                }
                            });
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
                    
                    var distanceMoney =  Math.floor(distanceKm * 4000);
                    document.getElementById("price").value= distanceMoney + "원";
                    document.getElementById("dis").value= distanceKm + "km";
                    console.log('두 마커 사이의 거리는 ' + distanceKm + ' km 입니다.');
                } else {
                    console.log('경로를 찾을 수 없습니다.');
                }
            })
            .catch(error => console.log('경로 요청 중 오류 발생:', error));
        }

        function clearMap() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
            for (var i = 0; i < polylines.length; i++) {
                polylines[i].setMap(null);
            }
            polylines = [];
            document.getElementById("dis").value='';
            document.getElementById('start-point').value = '';
            document.getElementById('end-point').value = '';
            document.getElementById("price").value = '';
        }

        function getAddressFromCoords(coords) {
            geocoder.coord2Address(coords.getLng(), coords.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var address = result[0].address.address_name;
                    if (markers.length === 1) {
                        document.getElementById('start-point').value = address;
                    } else if (markers.length === 2) {
                        document.getElementById('end-point').value = address;
                    }
                }
            });
        }

        function expandMapImage() {
            const mapContainer = document.getElementById('map');
            const restoreButton = document.querySelector('.restore-button');
            
            mapContainer.style.height = '600px';
            restoreButton.style.display = 'block';
            map.relayout();
        }

        function restoreMapImage() {
            const mapContainer = document.getElementById('map');
            const restoreButton = document.querySelector('.restore-button');
            
            mapContainer.style.height = '400px';
            restoreButton.style.display = 'none';
            map.relayout();
        }

        function sendData() {
            var title = document.getElementById('title').value;
            var content = document.getElementById('content').value;
            var category = document.getElementById('category').value;
            var fragile = document.getElementById('fragile').checked;
            var valuable = document.getElementById('valuable').checked;
            var urgent = document.getElementById('urgent').checked;
            var startPoint = document.getElementById('start-point').value;
            var endPoint = document.getElementById('end-point').value;
            var distance = document.getElementById('dis').value;
            var price = document.getElementById('price').value;

            $.ajax({
                url: '${pageContext.request.contextPath}/board/insert',
                type: 'POST',
                data: JSON.stringify({
                    title: title,
                    content: content,
                    category: category,
                    fragile: fragile,
                    valuable: valuable,
                    urgent: urgent,
                    startPoint: startPoint,
                    endPoint: endPoint,
                    distance: distance,
                    price: price
                }),
                contentType: 'application/json; charset=utf-8',
                success: function(response) {
                    console.log('Data sent successfully');
                    console.log(response);
                },
                error: function(error) {
                    console.error('Error sending data');
                    console.error(error);
                }
            });
        }
    </script>
</body>
</html>
