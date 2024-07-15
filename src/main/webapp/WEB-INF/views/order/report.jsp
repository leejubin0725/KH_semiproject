<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고하기</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color:  #dc3545;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        header h1 {
            margin: 0;
        }

        main {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        form .form-group {
            margin-bottom: 20px;
        }

        form .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        form .form-group input[type="text"],
        form .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }

        form .button-group {
            text-align: center;
        }

        form .btn-submit {
            background-color: #dc3545; /* Red color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        
         form .btn-mainpage {
            background-color: #dc3545; /* Red color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        form .btn-submit:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <header>
        <h1>신고하기</h1>
    </header>
    <main>
        <form action="${contextPath }/report/save" method="POST" id="reportForm" class="report-form">
           
            <div class="form-group">
                <label for="reportContent">신고 내용</label>
                <textarea id="reportContent" name="content" rows="5" required></textarea>
            </div>
            <div class="button-group">
                <button type="submit" class="btn-submit">신고 제출</button>
                <button type="button" class="btn-mainpage" onclick="window.location.href= `${contextPath}/order/noticeboard`;">뒤로 가기</button>
            </div>
        </form>
    </main>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="scripts.js"></script>
</body>
</html>
