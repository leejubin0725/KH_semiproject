<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/writerStyle.css">
</head>
<body>
    <div class="container">
        <form class="form-section" action="${pageContext.request.contextPath}/order/orderInsert" method="post">
            <div class="left-side">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목 입력">
                
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용 입력"></textarea>
                
                <label for="category">대분류</label>
                <select id="category" name="category">
                    <option value="">선택하세요</option>
                    <!-- 추가 옵션들 -->
                </select>
                
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="fragile" name="fragile" value="1">
                        <label for="fragile">파손 주의</label>
                    </div>
                    <p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
                
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="valuable" name="valuable" value="1">
                        <label for="valuable">귀중품 주의</label>
                    </div>
                    <p>이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
                
                <div class="checkbox-group">
                    <div class="checkbox-label">
                        <input type="checkbox" id="urgent" name="urgent" value="1">
                        <label for="urgent">긴급 배송 요청</label>
                    </div>
                    <p class="red">이 항목을 체크 하시면 라이더에게 추가 적인 정보가 표시 되며, 추가 제약 조건이 붙습니다.</p>
                </div>
            </div>
            <div class="right-side">
                <label for="file">파일 선택</label>
                <input type="file" id="file" name="file">
                <span>선택된 파일 없음</span>
                
                <div class="image-box">
                   <!--  <img src="${pageContext.request.contextPath}/resources/images/cut.png" alt="Image Icon"> -->
                </div>
                
                <div class="map-box">
                   <!--  <img src="${pageContext.request.contextPath}/resources/images/cut.png" alt="Map Icon"> -->
                </div>
                
                <div class="input-group">
                    <label for="start-point">출발지</label>
                    <input type="text" id="start-point" name="startPoint" placeholder="출발지" readonly>
                </div>
                
                <div class="input-group">
                    <label for="end-point">도착지</label>
                    <input type="text" id="end-point" name="endPoint" placeholder="도착지" readonly>
                </div>
                
                <div class="input-group">
                    <label for="price" class="red">예상금액</label>
                    <input type="text" id="price" name="price" placeholder="예상금액" readonly>
                </div>
                
                <div class="buttons">
                    <button type="submit" class="btn btn-primary">생성</button>
                    <button type="reset" class="btn btn-danger">취소</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

