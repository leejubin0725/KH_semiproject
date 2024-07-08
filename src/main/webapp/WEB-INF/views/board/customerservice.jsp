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
            <div class="breadcrumb">
            	<button class="custom-button" id="customButton">새로운 페이지로 이동</button>
                <span>홈</span> > <span>고객지원</span> > <span>1:1 문의</span>
            </div>
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

                   <c:forEach items="${inquiryList}" var="inquiry">
				        <tr class="clickable-row" data-id="${inquiry.inquiryNo}">
				            <td>${inquiry.inquiryNo}</td>
				            <td>${inquiry.title}</td>
				            <td>${inquiry.userNo}</td>
				            <td><fmt:formatDate value="${inquiry.createDate}" pattern="yy-MM-dd" /></td>
				            <td><span class="status completed">답변대기</span></td>
				        </tr>
			    	</c:forEach>
                    
                </tbody>
            </table>
            <div class="pagination">
                <span>1</span>
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