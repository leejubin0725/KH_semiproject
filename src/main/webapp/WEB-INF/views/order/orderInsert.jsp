<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/writerStyle.css">
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="form-section">
			<div class="left-side">
				<label for="title">제목</label> <input type="text" id="title"
					placeholder="제목 입력"> <label for="content">내용</label>
				<textarea id="content" placeholder="내용 입력"></textarea>
				<label for="category">대분류</label> <select id="category">
					<option>Value</option>
				</select>
				<div class="checkbox-group">
					<div class="checkbox-label">
						<input type="checkbox" id="fragile" value="0.1"> <label for="fragile">파손
							주의</label>
					</div>
					<p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
				</div>
				<div class="checkbox-group">
					<div class="checkbox-label">
						<input type="checkbox" id="valuable" value="0"> <label
							for="valuable">귀중품 주의</label>
					</div>
					<p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
				</div>
				<div class="checkbox-group">
					<div class="checkbox-label">
						<input type="checkbox" id="urgent" value="0.5"> <label for="urgent">긴급
							배송 요청</label>
					</div>
					<p class="red">이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이
						붙습니다.</p>
				</div>
			</div>
			<div class="right-side">
				<label for="file">파일 선택</label> <input type="file" id="file"
					name="file">
				<div id="map" style="width: 100%; height: 400px;"></div>
				<div style="display: flex; justify-content: center;">
					<button class="map-button" onclick="expandMapImage()">지도
						보기</button>
					<button class="restore-button" onclick="restoreMapImage()">복구</button>
				</div>
				<div class="input-group">
					<label for="start-point">출발지</label> <input type="text"
						id="start-point" placeholder="출발지" readonly required>
				</div>
				<div class="input-group">
					<label for="end-point">도착지</label> <input type="text"
						id="end-point" placeholder="도착지" readonly required>
				</div>
				<div class="input-group">
					<label for="dis">거리</label> <input type="text" id="dis"
						placeholder="거리" readonly required>
				</div>
				<div class="input-group">
					<label for="price" class="red">예상금액</label> <input type="text"
						id="price" placeholder="예상금액" readonly required>
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
                    
                    var distanceMoney = 5000 + Math.floor(distanceKm * 4000);
                    document.getElementById("price").value= distanceMoney + "원";
                    document.getElementById("dis").value= distanceKm + "km";
                    console.log('두 마커 사이의 거리는 ' + distanceKm + ' km 입니다.');
                } else {
                    console.log('경로를 찾을 수 없습니다.');
                }
            })
            .catch(error => console.log('경로 요청 중 오류 발생:', error));
        }
	
        function updateDistanceMoney(baseDistanceMoney) {
            var extraMoney = 0;
            var checkboxes = document.querySelectorAll('input[type="checkbox"]');

            checkboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    extraMoney += parseFloat(checkbox.value);
                }
            });

            var distanceMoney = Math.floor(baseDistanceMoney * (1 + extraMoney));
            document.getElementById("price").value = distanceMoney + "원";
        }

        // 체크박스 변경 시 요금 업데이트
        var checkboxes = document.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(function(checkbox) {
            checkbox.addEventListener('change', function() {
                var distanceKm = parseFloat(document.getElementById("dis").value.replace('km', '')) || 0;
                var baseDistanceMoney = 5000 + Math.floor(distanceKm * 4000);
                updateDistanceMoney(baseDistanceMoney);
            });
        });
        
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

       /*  function sendData() {
        	 var contextPath = "${pageContext.request.contextPath}";

            var order = {
                userNo: 1, // 예시 값, 실제로는 로그인한 사용자의 ID를 사용해야 합니다.
                orderTitle: document.getElementById('title').value,
                orderContent: document.getElementById('content').value,
                categoryMain: document.getElementById('category').value,
                alertFragile: document.getElementById('fragile').checked ? 'Y' : 'N',
                alertValuable: document.getElementById('valuable').checked ? 'Y' : 'N',
                alertUrgent: document.getElementById('urgent').checked ? 'Y' : 'N',
                startPoint: document.getElementById('start-point').value,
                endPoint: document.getElementById('end-point').value,
                orderStatus: '대기중', // 초기 상태
                distance: parseFloat(document.getElementById('dis').value),
                price: parseInt(document.getElementById('price').value.replace('원', '')),
                startDate: new Date().toISOString().split('T')[0], // 현재 날짜를 기본값으로 설정
                endDate: new Date().toISOString().split('T')[0]    // 현재 날짜를 기본값으로 설정
                
           		
            };

            // 콘솔에 데이터 출력 (디버깅용)
            console.log('Sending order data:', order);

            $.ajax({
            	url: `${contextPath}/order/orderInsert`,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(order),
                success: function(response) {
                    console.log('Order sent successfully');
                    console.log(response);
                    // 성공 시 알림 창 띄우기
                    alert('주문이 성공적으로 전송되었습니다!');
                    window.location.href = `${contextPath}/order/noticeboard`;
                },
                error: function(error) {
                    console.error('Error sending order');
                    console.error(error);
                    // 오류 시 사용자에게 알림
                    alert('주문 전송 중 오류가 발생했습니다. 다시 시도해 주세요.');
                }
            });
        } */
        
        function sendData() {
       	 var contextPath = "${pageContext.request.contextPath}";

           var order = {
               orderTitle: document.getElementById('title').value,
               orderContent: document.getElementById('content').value,
               categoryMain: document.getElementById('category').value,
               alertFragile: document.getElementById('fragile').checked ? 'Y' : 'N',
               alertValuable: document.getElementById('valuable').checked ? 'Y' : 'N',
               alertUrgent: document.getElementById('urgent').checked ? 'Y' : 'N',
               startPoint: document.getElementById('start-point').value,
               endPoint: document.getElementById('end-point').value,
               orderStatus: '대기중', // 초기 상태
               distance: parseFloat(document.getElementById('dis').value),
               price: parseInt(document.getElementById('price').value.replace('원', '')),
           };
           
           var formData = new FormData();

           // order 객체의 데이터 추가
           for (var key in order) {
               if (order.hasOwnProperty(key)) {
                   formData.append(key, order[key]);
               }
           }
           
        	// 파일 추가
           var fileInput = document.getElementById('file');
           if (fileInput.files.length > 0) {
               formData.append('file', fileInput.files[0]);
           }

           // 콘솔에 데이터 출력 (디버깅용)
           console.log('Sending order data:', order);

           $.ajax({
           	url: `${contextPath}/order/orderInsert`,
	           	type: 'POST',
	            processData: false, // 데이터를 일반적인 쿼리 문자열로 처리하지 않음
	            contentType: false, // jQuery가 요청에 적절한 Content-Type 헤더를 설정하지 않도록 함
	            data: formData,
               success: function(response) {
                   console.log('Order sent successfully');
                   console.log(response);
                   // 성공 시 알림 창 띄우기
                   alert('주문이 성공적으로 전송되었습니다!');
                   window.location.href = `${contextPath}/order/noticeboard`;
               },
               error: function(error) {
                   console.error('Error sending order');
                   console.error(error);
                   // 오류 시 사용자에게 알림
                   alert('주문 전송 중 오류가 발생했습니다. 다시 시도해 주세요.');
               }
           });
       }

        	
       
    </script>
</body>
</html>
