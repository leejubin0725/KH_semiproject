<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 입력</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/idfind.css">
    <style>
     .login-link {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #4CAF50; /* Green background */
            color: white; /* White text */
            text-align: center;
            text-decoration: none; /* Remove underline */
            font-size: 16px; /* Increase font size */
            border: none; /* Remove borders */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer/hand icon on hover */
        }
        .login-link:hover {
            background-color: #45a049; /* Darker green on hover */
        }
        /* 버튼 스타일 추가 */
        .custom-button {
            background-color: #007BFF; /* 파란색 배경 */
            color: white; /* 흰색 글자 */
            border: none; /* 테두리 제거 */
            padding: 10px 20px; /* 패딩 */
            text-align: center; /* 가운데 정렬 */
            text-decoration: none; /* 밑줄 제거 */
            display: inline-block; /* 인라인 블록 */
            font-size: 16px; /* 글자 크기 */
            margin: 10px 2px; /* 마진 */
            cursor: pointer; /* 커서 포인터 */
            border-radius: 12px; /* 둥근 모서리 */
            transition-duration: 0.4s; /* 전환 효과 */
        }

        /* 버튼에 호버 효과 추가 */
        .custom-button:hover {
            background-color: white; /* 흰색 배경 */
            color: #007BFF; /* 파란색 글자 */
            border: 2px solid #007BFF; /* 파란색 테두리 */
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="${contextPath}/resources/images/logo.jpg" alt="아이콘" class="icon">
        <form id="idFindForm">
            <p class="instruction">아이디를 찾고자하는 휴대폰 번호를 입력해주세요.</p>
            <input type="text" name="phone" placeholder="휴대폰 번호" class="email-input">
            <button type="button" id="findIdButton" class="custom-button">확인</button>
        </form>
        <p>아이디: <span id="foundId"></span></p>
        <a href="${contextPath}/user/login" class="login-link" >로그인 페이지로 이동하기</a>
    </div>

    <script>
    $(document).ready(function() {
        $('#findIdButton').click(function() {
            var phone = $('input[name="phone"]').val();
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/user/idfind',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: { phone: encodeURIComponent(콜) },
                success: function(response) {
                    $('#foundId').text(response);
                },
                error: function() {
                    $('#foundId').text('아이디를 찾을 수 없습니다.');
                }
            });
        });
    });
    </script>
</body>
</html>
