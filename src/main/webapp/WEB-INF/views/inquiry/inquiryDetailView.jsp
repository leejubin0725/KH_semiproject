<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 상세 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquiryDetailView.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 댓글 제출 폼을 AJAX로 처리
            $('#replyForm').submit(function(event) {
                event.preventDefault(); // 기본 동작 방지

                var formData = $(this).serialize(); // 폼 데이터를 가져오기

                // AJAX 요청 설정
                $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath}/submitReply',
                    data: formData,
                    success: function(response) {
                        // 댓글 추가 성공 시, 테이블에 새로운 행 추가
                        var newRow = '<tr>' +
                                        '<td>' + response.replyNumber + '</td>' +
                                        '<td>' + response.author + '</td>' +
                                        '<td>' + response.content + '</td>' +
                                        '<td>' + response.date + '</td>' +
                                        '<td>' + response.views + '</td>' +
                                     '</tr>';
                        $('.reply-table tbody').prepend(newRow); // 맨 위에 새로운 행 추가
                        $('#replyContent').val(''); // 입력창 초기화
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX 오류: ' + status, error);
                        // 오류 처리 로직 추가
                    }
                });
            });
        });
    </script>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <c:set var="inquiryImageUploadPath" value="/resources/images/Inquiry/"></c:set>
    <main class="inquiry-page">
        <header>

        </header>
        
        <section class="inquiry-content">
            <div class="description">
                <p class="inquiry-title">${inquiry.title }</p>
                <p class="author-nickname">작성자: ${inquiry.writer}</p>
            </div>
            
            <div class="product-info">
                <img src="${contextPath}${inquiryImageUploadPath}${inquiry.inquiryImg.changeName}" alt="상품 이미지" class="product-image">
                <div class="info-details">
                    <p class="content">${inquiry.content }</p>
                </div>
            </div>
        </section>

        <section class="inquiry-replies">
            <h2>문의 답변 목록</h2>
            <table class="reply-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>글쓴이</th>
                        <th>댓글 내용</th>
                        <th>작성 시간</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>관리자</td>
                        <td>상품은 현재 발송 준비 중이며, 곧 배송될 예정입니다.</td>
                        <td>2024-07-03</td>
                        <td>5</td>
                    </tr>
                    <!-- 추가 답변 행 -->
                    <tr>
                        <td>2</td>
                        <td>관리자</td>
                        <td>오늘 중으로 송장번호를 보내드리겠습니다.</td>
                        <td>2024-07-04</td>
                        <td>3</td>
                    </tr>
                </tbody>
            </table>

            <form id="replyForm" action="${pageContext.request.contextPath}/submitReply" method="post" class="reply-form">
                <input type="hidden" name="inquiryId" value="1234">
                <div class="form-group">
                    <label for="replyContent">댓글 내용</label>
                    <textarea id="replyContent" name="replyContent" required></textarea>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn-submit">댓글 달기</button>
                </div>
            </form>
        </section>
    </main>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
