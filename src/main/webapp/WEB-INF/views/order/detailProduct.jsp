<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/detailProduct.css">
<style>
.image-box {
	width: 70%; /* 원하는 너비로 조정 */
	max-height: 400px; /* 원하는 높이로 조정 */
	overflow: hidden; /* 넘치는 부분 숨김 */
	margin: 20px auto; /* 수직 가운데 정렬 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 20px; /* 둥근 테두리 */
}

.image-container {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center; /* 가로 방향 가운데 정렬 */
	align-items: center; /* 세로 방향 가운데 정렬 */
}

.image-container img {
	max-width: 100%; /* 이미지가 부모 너비를 넘지 않도록 */
	max-height: 100%; /* 이미지가 부모 높이를 넘지 않도록 */
	display: block; /* 이미지가 inline 속성을 가지지 않도록 */
}

.chat-actions {
	margin-top: 20px;
	margin-bottom: 110px;
	margin-left: 300px;
	display: flex; /* 버튼들을 가로로 배치하기 위해 flex 속성 추가 */
	justify-content: flex-start; /* 버튼들을 왼쪽 정렬 */
	gap: 10px; /* 버튼 사이에 간격 추가 */
}

.chat-actions button {
	padding: 10px 20px; /* 위아래 10px, 좌우 20px 여백 설정 */
	background-color: #28a745; /* 배경색 */
	color: white; /* 글자색 */
	border: none;
	cursor: pointer;
	border-radius: 5px; /* 버튼을 둥글게 만들기 */
	transition: background-color 0.3s; /* 배경색 변경 시 부드럽게 전환 */
}

.chat-actions button:hover {
	background-color: #218838; /* 마우스 호버 시 배경색 변경 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66e04ef438990e6ab1d5d64f99a79f51&libraries=services"></script>
<script>
let mapDisplayed = false; // 지도 보기 상태를 관리하는 변수
let mapInstance = null; // Kakao 지도 인스턴스 변수
let linePath = []; // 선의 경로를 담을 배열
let currentRating = 0;

selectReviewList();
buttonSelction();

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

    function geocodeAddress(address) {
        return new Promise(function(resolve, reject) {
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    resolve(new kakao.maps.LatLng(result[0].y, result[0].x));
                } else {
                    reject(status);
                }
            });
        });
    }

    Promise.all([geocodeAddress(startPoint), geocodeAddress(endPoint)])
        .then(function(coords) {
            var startMarker = new kakao.maps.Marker({
                map: map,
                position: coords[0]
            });
            markers.push(startMarker);

            var endMarker = new kakao.maps.Marker({
                map: map,
                position: coords[1]
            });
            markers.push(endMarker);

            adjustMapBounds();

            if (markers.length === 2) {
                findRouteAndDrawLine();
            }
        })
        .catch(function(error) {
            console.error('Geocode error:', error);
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



/* 채팅기능 */
function enterChatRoom(orderId) {
	    var password = prompt("채팅방 비밀번호를 입력하세요:");
	    if (password) {
	        var form = document.createElement("form");
	        form.method = "POST";
	        form.action = "${pageContext.request.contextPath}/chatRoom/enter";

	        var orderIdInput = document.createElement("input");
	        orderIdInput.type = "hidden";
	        orderIdInput.name = "orderId";
	        orderIdInput.value = orderId;
	        form.appendChild(orderIdInput);

	        var passwordInput = document.createElement("input");
	        passwordInput.type = "hidden";
	        passwordInput.name = "password";
	        passwordInput.value = password;
	        form.appendChild(passwordInput);

	        document.body.appendChild(form);
	        form.submit();
	    } else {
	        alert("비밀번호를 입력해주세요.");
	    }
	}

function accept(orderId){
    alert('수락되었습니다.');
    $.ajax({
        url: '${pageContext.request.contextPath}/chatRoom/password',
        type: 'GET',
        data: { orderId: orderId },
        success: function(response) {
            alert('룸 비밀번호: ' + response);
        },
        error: function(xhr, status, error) {
            alert("비밀번호를 가져오는 중 오류가 발생했습니다: " + error);
        }
    });
    window.location.href = "${contextPath}/order/orderAccept?orderNo=${order.orderNo}"
}

function orderEnd() {
	window.location.href = "${contextPath}/order/orderEnd?orderNo=${order.orderNo}";
}

function buttonSelction() {
	
	var userRole = "${sessionScope.loginUser.role}";
	var orderStatus = "${order.orderStatus}";
	var orderRiderNo = ${order.riderNo};
	
	var buttons="";
	$(".status-button").html(buttons);
	
	if(userRole == "rider"){
		$.ajax({
	        url : "${pageContext.request.contextPath}/order/riderOrderSelectAjax",
	        data : {
	        	orderRiderNo : orderRiderNo
	        },
	        success : function(result){
	        	if(orderRiderNo == 0){
	        		console.log("배달이 없는 상태");
	        		buttons = (orderRiderNo == result) ? "" : "<button type='button' onclick='accept(${order.orderNo})'>주문 수락</button>";
	        		$(".status-button").html(buttons);
	        	}
	        	
	        	else {
	        		if(orderStatus != "배달중"){
	        			console.log("배달 완료 상태");
	        			buttons="";
	        		} else {
	        			console.log("배달이 있는 상태");
	        			buttons = (orderRiderNo == result) ? "<button type='button' onclick='orderEnd()'>배송 완료</button>" : "";
	        		}
	        		
	        		$(".status-button").html(buttons);
	        	}
	        }		        	      
	    });
	}
}

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
}

function insertReview() {
    const reviewContent = document.querySelector('#reviewContent').value;

    if (!reviewContent.trim()) {
        alert('리뷰 내용을 입력해주세요.');
        return;
    }

    const data = {
        orderNo: ${order.orderNo},  // 실제 주문 번호로 대체
        writer: '${sessionScope.loginUser.nickname}',  // 실제 사용자 닉네임으로 대체
        riderNo : ${order.riderNo},
        reviewContent: reviewContent,
        rating: currentRating
    };

    fetch('${pageContext.request.contextPath}/review/insertReview', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.text())
    .then(result => {
        if (result === 'fail') {
            alert('리뷰 등록 실패');
        } else {
            alert('리뷰 등록 성공');
            document.querySelector('#reviewContent').value = "";
            selectReviewList();
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('리뷰 등록 중 오류가 발생했습니다.');
    });
}

function selectReviewList(){
	var orderStatus = "${order.orderStatus}";
    $.ajax({
        url : "${pageContext.request.contextPath}/review/selectReviewList",
        method: 'POST',
        data : {
            orderNo : ${order.orderNo}
        },
        success : function(result){
        	var reviews = "";
        	if(result.length > 0){
        		 for(var review of result){
                     reviews += `<td>\${review.rating}</td>`;
                     reviews += `<td>\${review.writer}</td>`;
                     reviews += `<td>\${review.reviewContent}</td>`;
                     reviews += `<td>\${formatDate(review.createDate)}</td>`;
                 }
        	} else {
        		if(orderStatus == '배달완료'){
        			reviews += "<div style='display: flex; align-items: center'>";
        			reviews += "<div class='rating' style='margin-right: 20px;'>";
        			reviews += "<span class='star' onclick='setRating(1)'>★</span>";
        			reviews += "<span class='star' onclick='setRating(2)'>★</span>";
        			reviews += "<span class='star' onclick='setRating(3)'>★</span>";
        			reviews += "<span class='star' onclick='setRating(4)'>★</span>";
        			reviews += "<span class='star' onclick='setRating(5)'>★</span>";
        			reviews += "</div>";
        			reviews += "<input type='text' id='reviewContent' style='flex-grow: 1; padding: 3px; margin-right: 4px' />";
        			reviews += "<button type='button' onclick='insertReview()'>댓글 달기</button>";
        			reviews += "</div>";
        		
        		}else if(orderStatus == '배달중') {
        			reviews += "<p>배달중입니다.</p>";
        		}else {
        			reviews += "<p>주문이 완료 되었습니다. 배달을 기다리는 중입니다.</p>";
        		}
        	}
            
           
            $("#reviewArea tbody tr").html(reviews);
        }
    });
}

function formatDate(timestamp) {
    const date = new Date(timestamp);
    const year = date.getFullYear().toString().slice(-2); // Get last 2 digits of year
    const month = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero-based
    const day = ('0' + date.getDate()).slice(-2);
    return `\${year}-\${month}-\${day}`;
}


</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<c:if test="${not empty errorMessage}">
		<script>
       alert("${errorMessage}");
    </script>
	</c:if>
	<c:set var="orderImageUploadPath" value="/resources/images/Orders/"></c:set>
	<div class="frame">
		<div class="image-box">
			<div class="image-container">
				<c:choose>
					<c:when test="${not empty order.ordersImg.changeName}">
						<img
							src="${contextPath}${orderImageUploadPath}${order.ordersImg.changeName}"
							alt="Main Image">
					</c:when>
					<c:otherwise>
						<div class="no-image">
							<img
								src="${pageContext.request.contextPath}/resources/images/no-image.png"
								alt="No Image">
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="product-box">
			<h1 class="product-title">${order.orderTitle}</h1>
		</div>
		<div class="author-nickname">${order.writer}</div>
		<p class="product-description">${order.orderContent}</p>
		<div id="map"></div>
		<!-- 지도를 표시할 div -->
		<div class="price">배송비: ${order.price}원</div>

		<div class="alert">
			<c:if test="${order.alertFragile == 'Y'}">
				<p>
					<input type="checkbox" id="fragileCheckbox" checked disabled>
					<span style="color: black;">파손 주의</span>
				</p>
			</c:if>
			<c:if test="${order.alertValuable == 'Y'}">
				<p>
					<input type="checkbox" id="valuableCheckbox" checked disabled>
					<span style="color: black;">귀중품 주의</span>
				</p>
			</c:if>
			<c:if test="${order.alertUrgent == 'Y'}">
				<p>
					<input type="checkbox" id="urgentCheckbox" checked disabled>
					긴급 배송 요청
				</p>
			</c:if>
		</div>

		<div class="delivery-info">
			출발 위치: ${order.startPoint}<br />배송 거리: ${order.distance}km<br /> <br>수령
			위치: ${order.endPoint}
		</div>

		<div
			class="status-info ${order.orderStatus == '대기중' ? 'status-waiting' : (order.orderStatus == '배달중' ? 'status-in-progress' : 'status-completed')}">
			${order.orderStatus == '대기중' ? '대기중' : (order.orderStatus == '배달중' ? '배달중' : '배달완료')}
		</div>

		<div class="map-buttons">
			<button class="map-button" onclick="showMap()">지도 보기</button>
			<button class="map-button" onclick="hideMap()">지도 숨기기</button>
			<button class="status-button"></button>
		</div>

		<div class="end-point">주문일자: ${order.startDate}</div>

		<table id="reviewArea" class="comments-table">
			<thead>
				<tr>
					<th>별점</th>
					<th>글쓴이</th>
					<th>댓글 내용</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
		<c:if test="${sessionScope.loginUser.userNo == order.userNo || sessionScope.loginUser.role == 'rider'}">
		<div class="chat-actions">

			<button onclick="enterChatRoom(${order.orderNo})">채팅방</button>
		</div>
		</c:if>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
