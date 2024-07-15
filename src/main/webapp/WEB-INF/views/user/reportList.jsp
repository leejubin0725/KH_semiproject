<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고 목록</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .header {
            background-color: rgba(212, 3, 3, 0.767);
            color: #fff;
            padding: 20px;
            text-align: center;
            border-bottom: 2px solidrgba(212, 3, 3, 0.767);
            border-radius: 8px 8px 0 0;
        }
        h2 {
            margin: 0;
            font-size: 24px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background-color:rgba(212, 3, 3, 0.767);
            color: #fff;
            border-top: 2px solid rgba(212, 3, 3, 0.767);
            border-radius: 0 0 8px 8px;
        }
        
        .main-btn {
            background-color: #dc3545; /* Red color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .btn-submit:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>신고 목록</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>신고 내용</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${reports}" var="report">
                    <tr>
                        <td>${report.nickName}</td>
                        <td>${report.content}</td>
                    </tr>
                </c:forEach>
            </tbody>
            
        </table>
        <button class="main-btn" onclick="window.location.href= `${contextPath}`">메인 화면</button>
        <div class="footer">
            &copy; 2024 신고 목록 서비스. All rights reserved.
        </div>
    </div>
</body>
</html>
