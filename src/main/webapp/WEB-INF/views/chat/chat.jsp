<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Chat Room</title>
<style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #86C1C6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .chat-container {
            background-color: #fff;
            border-radius: 16px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            height: 80vh;
        }

        .chat-header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #007bff; /* 카카오톡과 비슷한 파란색 */
        }

        #chat {
            flex: 1;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 16px;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #fafafa;
            /* 스크롤이 맨 아래로 자동으로 내려가도록 설정 */
            scroll-behavior: smooth;
        }

        #messages {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        #messages li {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 12px;
            background-color: #f0f0f0; /* 메시지 배경색 */
        }

        .chat-inputs {
            display: flex;
            align-items: center; /* 입력창을 세로 중앙 정렬 */
        }

        .chat-inputs input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 20px; /* 더 둥근 입력창 모서리 */
            font-size: 16px;
            outline: none; /* 포커스시 테두리 제거 */
        }

        .chat-inputs button {
            padding: 12px 24px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
        }

        .chat-inputs button:hover {
            background-color: #0056b3;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">Chat Room</div>
        <div id="chat">
            <ul id="messages">
                <c:forEach var="message" items="${messages}">
                    <li>${message.writer}: ${message.content}</li>
                </c:forEach>
            </ul>
        </div>
        <div class="chat-inputs">
            <input type="hidden" id="from" value="${sessionScope.loginUser.userNo}" /> <!-- 세션에서 사용자 ID -->
            <input type="hidden" id="chatRoomId" value="${chatRoomId}" /> <!-- 채팅방 ID 추가 -->
            <input type="hidden" id="nickName" value="${nickName}" /> <!-- 채팅방 ID 추가 -->
            <input type="text" id="text" placeholder="Your message" onkeypress="handleKeyPress(event)" />
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>

    <script type="text/javascript">
        var stompClient = null;

        function connect() {
            var chatRoomId = document.getElementById('chatRoomId').value; // 채팅방 ID
            var socket = new SockJS('<%= request.getContextPath() %>/chat');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/messages/' + chatRoomId, function (messageOutput) {
                    console.log('Received message:', messageOutput.body);
                    showMessage(JSON.parse(messageOutput.body));
                });
            });
        }

        function sendMessage() {
            var from = document.getElementById('from').value;
            var text = document.getElementById('text').value;
            var chatRoomId = document.getElementById('chatRoomId').value; // 채팅방 ID 추가

            console.log('Sending message:', from, text);
            stompClient.send("/app/sendMessage", {}, JSON.stringify({
                'senderId': from,
                'content': text,
                'chatRoomId': chatRoomId // 채팅방 ID 추가
            }));

            document.getElementById('text').value = ''; // 메시지 전송 후 입력 필드 초기화
            scrollToBottom();
        }

        function showMessage(message) {
            var response = document.getElementById('messages');
            var li = document.createElement('li');
            li.appendChild(document.createTextNode("${nickName}" + ": " + message.content));
     
            response.appendChild(li);
            scrollToBottom();
        }

        function scrollToBottom() {
            var chat = document.getElementById('chat');
            chat.scrollTop = chat.scrollHeight;
        }

        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        connect();
    </script>
</body>
</html>
