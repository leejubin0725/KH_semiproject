<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 상세 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquiryDetailView.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <c:set var="inquiryImageUploadPath" value="/resources/images/Inquiry/"></c:set>
    <main class="inquiry-page">
        <section class="inquiry-content">
            <div class="description">
                <p class="inquiry-title">${inquiry.title}</p>
                <p class="author-nickname">작성자: ${inquiry.writer}</p>
            </div>
            
            <div class="product-info">
                <%-- <img src="${contextPath}${inquiryImageUploadPath}${inquiry.inquiryImg.changeName}" alt="상품 이미지" class="product-image"> --%>
                <div class="info-details">
                    <p class="content">${inquiry.content}</p>
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
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 답변 목록이 여기에 동적으로 추가됩니다 -->
                </tbody>
            </table>

            <form id="replyForm" class="reply-form">
                <input type="hidden" name="inquiryId" value="${inquiry.inquiryNo}">
                <div class="form-group">
                    <label for="replyContent">댓글 내용</label>
                    <textarea id="replyContent" name="replyContent" required></textarea>
                </div>
                <div class="button-group">
                    <button type="button" onclick="insertAnswer()" class="btn-submit">댓글 달기</button>
                </div>
            </form>
        </section>
        <script>
        $(document).ready(function() {
            selectAnswerList();
        });

        const contextPath = "${pageContext.request.contextPath}";

        function selectAnswerList() {
            $.ajax({
                url: `${contextPath}/InquirAnswer/selectAnswerList`,
                data: { inquiryNo: '${inquiry.inquiryNo}' },
                success: function(result) {
                    console.log("서버 응답:", result);
                    
                    if (!Array.isArray(result)) {
                        console.error("서버 응답이 배열이 아닙니다:", result);
                        return;
                    }
                    
                    let answers = "";
                    for (let InquirAnswer of result) {
                        console.log("각 답변 데이터:", InquirAnswer);
                        answers += "<tr>";
                        answers += `<td>\${InquirAnswer.answerNo}</td>`;
                        answers += `<td>\${InquirAnswer.answerWriter}</td>`;
                        answers += `<td>\${InquirAnswer.answerContent}</td>`;
                        answers += `<td>\${InquirAnswer.createDate}</td>`;
                        answers += `<td>
                                    <button onclick='showAnswerUpdateForm(${InquirAnswer.answerNo}, this)'>수정</button>
                                    <button onclick='deleteAnswer(${InquirAnswer.answerNo})'>삭제</button>
                                    </td>`;
                        answers += "</tr>";
                    }
                    
                    $(".reply-table tbody").html(answers);
                },
                error: function(xhr, status, error) {
                    console.error("댓글 목록 불러오기 실패:", error);
                }
            });
        }

        function showAnswerUpdateForm(answerNo, btn) {
            const $textArea = $("<textarea></textarea>");
            const $button = $("<button></button>").text("수정");
            
            const $tr = $(btn).closest('tr');
            const $contentTd = $tr.find('td').eq(2);
            $textArea.val($contentTd.text());
            
            $contentTd.html("").append($textArea).append($button);
            
            $button.click(function() {
                updateAnswer(answerNo, $textArea);
            });
        }

        function updateAnswer(answerNo, textArea) {
            $.ajax({
                url: `${contextPath}/InquirAnswer/update`,
                data: {
                    answerNo: answerNo,
                    answerContent: textArea.val()
                },
                type: 'POST',
                success: function(result) {
                    if (result > 0) {
                        alert("댓글 수정 성공");
                    } else {
                        alert("댓글 수정 실패");
                    }
                    selectAnswerList();
                }
            });
        }

        function insertAnswer() {
            $.ajax({
                url: `${contextPath}/InquirAnswer/insertAnswer`,
                type: 'POST',
                data: {
                    inquiryNo: '${inquiry.inquiryNo}',
                    answerContent: $("#replyContent").val()
                },
                success: function(result) {
                    if (result == 0) alert('댓글 등록 실패');
                    else alert('댓글 등록 성공');
                    selectAnswerList();
                    $('#replyContent').val("");
                }
            });
        }

        function deleteAnswer(answerNo) {
            $.ajax({
                url: `${contextPath}/InquirAnswer/deleteAnswer`,
                data: { answerNo: answerNo },
                type: 'POST',
                success: function(result) {
                    if (result > 0) {
                        alert("댓글 삭제 성공");
                    } else {
                        alert("댓글 삭제 실패");
                    }
                    selectAnswerList();
                },
                error: function(xhr, status, error) {
                    console.error("댓글 삭제 실패:", error);
                }
            });
        }
    </script>
    </main>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>