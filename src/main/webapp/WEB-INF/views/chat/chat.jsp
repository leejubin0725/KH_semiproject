<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .chat-container {
            background-color: #fff;
            border-radius: 8px;
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
        }
        #chat {
            flex: 1;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #fafafa;
        }
        #messages {
            list-style-type: none;
            padding: 0;
        }
        #messages li {
            padding: 8px;
            margin-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .chat-inputs {
            display: flex;
            gap: 10px;
        }
        .chat-inputs input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .chat-inputs button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
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
            <ul id="messages"></ul>
        </div>
        <div class="chat-inputs">
            <input type="text" id="from" placeholder="Your name" />
            <input type="text" id="text" placeholder="Your message" />
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>

    <script type="text/javascript">
        var stompClient = null;

        function connect() {
            var socket = new SockJS('${pageContext.request.contextPath}/chat');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/messages', function (messageOutput) {
                    console.log('Received message:', messageOutput.body);
                    showMessage(JSON.parse(messageOutput.body));
                });
            });
        }

        function sendMessage() {
            var from = document.getElementById('from').value;
            var text = document.getElementById('text').value;
            console.log('Sending message:', from, text);
            stompClient.send("/app/sendMessage", {}, JSON.stringify({'from': from, 'text': text}));
        }

        function showMessage(message) {
            var response = document.getElementById('messages');
            var li = document.createElement('li');
            li.appendChild(document.createTextNode(message.from + ": " + message.text));
            response.appendChild(li);
        }

        connect();
    </script>
</body>
</html>
