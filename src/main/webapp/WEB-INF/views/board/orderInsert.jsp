<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="writerStyle.css">
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
                
                <div class="image-box">
                    <img src="image-icon.png" alt="Image Icon">
                </div>
                
                <div class="map-box">
                    <img src="map-icon.png" alt="Map Icon">
                </div>
                
                
                <div class="input-group">
                    <label for="start-point">출발지</label>
                    <input type="text" id="start-point" placeholder="출발지" readonly>
                </div>
                
                <div class="input-group">
                    <label for="end-point">도착지</label>
                    <input type="text" id="end-point" placeholder="도착지" readonly>
                </div>
                
                <div class="input-group">
                    <label for="price" class="red">예상금액</label>
                    <input type="text" id="price" placeholder="예상금액" readonly>
                </div>
                
                <div class="buttons">
                    <button type="button">생성</button>
                    <button type="button">취소</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>