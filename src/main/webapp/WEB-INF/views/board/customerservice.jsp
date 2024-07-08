<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="description" content="Figma htmlGenerator">
    <meta name="author" content="htmlGenerator">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Sigmar+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
   <style>
    .custom-button {
        display: block;
        width: 150px;
        padding: 10px 20px;
        margin: 5px 5px 20px auto; /* 위쪽 5px, 오른쪽 5px, 아래쪽 20px */
        font-size: 16px;
        font-weight: bold; /* 텍스트 굵기 추가 */
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 5px;
        text-align: center; /* 텍스트 가운데 정렬 */
        cursor: pointer;
    }

    .custom-button:hover {
        background-color: #0056b3;
    }

    .no-inquiry {
        text-align: center; /* 텍스트를 가운데 정렬 */
        font-size: 18px; /* 글자 크기 설정 */
        color: #888; /* 글자 색상 설정 */
        margin-top: 20px; /* 위쪽 여백 추가 */
    }

    /* 각 섹션 사이의 간격 조정 */
    .hero {
        margin-bottom: 20px; /* hero 섹션의 아래 여백 */
    }

    .inquiry {
        margin-top: 20px; /* inquiry 섹션의 위 여백 */
    }
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main>
        <section class="hero">
            <h1>빠른 퀵 서비스로 소비자를 사로잡다</h1>
            <br><br>
        </section>

        <section class="inquiry">
            <h2>1:1 문의</h2>
          
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>진행상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty inquiryList}">
                            <tr>
                                <td colspan="5" class="no-inquiry">현재 문의 내용이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${inquiryList}" var="inquiry">
                                <tr class="clickable-row" data-id="${inquiry.inquiryNo}">
                                    <td>${inquiry.inquiryNo}</td>
                                    <td>${inquiry.title}</td>
                                    <td>${inquiry.userNo}</td>
                                    <td><fmt:formatDate value="${inquiry.createDate}" pattern="yy-MM-dd" /></td>
                                    <td><span class="status completed">답변대기</span></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <div class="pagination">
                <span>1</span>
            </div>
            
            <div class="breadcrumb">
                <button class="custom-button" id="customButton">문의 작성하기</button>
            </div>
            
        </section>
    </main>
    <script>
        // 새로운 버튼에 대한 이벤트 리스너
        document.getElementById('customButton').addEventListener('click', function() {
            const url = 'inquiryInsert'; // URL을 설정하세요
            window.location.href = url;
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            var rows = document.querySelectorAll('.clickable-row');
            rows.forEach(function(row) {
                row.addEventListener('click', function() {
                    const id = this.getAttribute('data-id');
                    const url = `/semi/board/inquiryDetailView?id=${id}`;
                    window.location.href = url;
                });
            });
        });
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
