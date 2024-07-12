<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Chat Room</title>
    <link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/chat.css">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
            Chat Room
            <button class="exit-button" onclick="exitChat()">X</button>
        </div>
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
            <button onclick="sendMessage()">보내기</button>
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

        function exitChat() {
            window.history.back();
        }

        connect();
    </script>
</body>
</html>
