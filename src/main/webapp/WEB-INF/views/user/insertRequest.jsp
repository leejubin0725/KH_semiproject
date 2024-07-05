<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인정보 수집 동의</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/insertRequest.css">
   
</head>
<body>
    <div class="container">
        <h1>개인정보 수집 동의</h1>
        <p>개인정보 수집에 대한 안내를 이곳에 추가합니다.</p>
        <button id=" ">개인정보 수집에 동의합니다</button>
    </div>

   
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>개인정보 수집 및 이용 동의</h2>
            <p>안녕하세요! 저희 서비스를 이용해 주셔서 감사합니다.<br><br>

                1. 수집하는 개인정보 항목 및 수집 목적<br><br>
                   가. 수집항목: 성명, 이메일 주소, 연락처<br><br>
                   나. 수집목적: 서비스 제공, 문의 응대 및 상담, 서비스 개선 및 통계 분석<br><br>
                
                2. 개인정보의 보유 및 이용 기간<br><br>
                   가. 보유기간: 서비스 제공 목적 달성 시까지 (단, 법령에 따라 보존이 필요한 경우 해당 기간)<br><br>
                
                3. 동의 거부 권리 및 동의 철회<br><br>
                   가. 동의 거부: 개인정보 수집 및 이용에 대한 동의를 거부할 수 있습니다.<br><br> 다만, 서비스 제공에 필요한 최소한의 정보는 수집할 수 있습니다.<br><br>
                   나. 동의 철회: 동의한 개인정보 수집 및 이용에 대해 언제든지 철회할 수 있습니다.<br><br> 다만, 철회 시 서비스 이용에 제한을 받을 수 있습니다.<br><br>
                
                4. 기타 사항<br><br>
                   가. 개인정보의 취급위탁: 특정 업체에 서비스 제공을 위탁하는 경우가 있으며,<br><br> 이 경우 사전에 알려드리고 필요한 동의를 받습니다.<br><br>
                   나. 개인정보의 파기: 수집한 개인정보는 목적 달성 후 즉시 파기하거나,<br><br>법령에 따라 보관할 수 있습니다.<br><br>
                
                위와 같은 내용에 대해 동의하시면, 아래의 동의 버튼을 클릭해 주세요.<br><br> 동의하지 않을 경우 서비스 이용에 제한을 받을 수 있습니다.</p>
            <p>동의하시면 아래 버튼을 클릭해 주세요.</p>
            <button id="agreeBtn">동의합니다</button>
        </div>
    </div>

    <script src="./javascript.js"></script>
</body>
</html>
