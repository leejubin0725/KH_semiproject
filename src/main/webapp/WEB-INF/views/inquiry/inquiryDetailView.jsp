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
                <p style="font-size: 30px; font-weight: bold;">고객 문의</p> 
                <div class="description-header">
                    <p class="inquiry-title">제목: ${inquiry.title}</p>
                    <p class="author-nickname">작성자: ${inquiry.writer}</p>
                </div>
            </div>
            
            <p style="font-size: 30px; margin: 0px; font-weight: bold;">&nbsp;문의 내용</p>
            <div class="product-info ${empty inquiry.inquiryImg ? 'only-details' : ''}">
                <c:if test="${not empty inquiry.inquiryImg}">
                    <img src="${contextPath}${inquiryImageUploadPath}${inquiry.inquiryImg.changeName}" alt="상품 이미지" class="product-image">
                </c:if>
                <div class="info-details">
                    <p class="content">${inquiry.content}</p>
                </div>
            </div>
        </section>

        <section class="inquiry-replies">
            <h2>문의 답변</h2>
            <table class="reply-table">
                <thead>
                    <tr>
                        <th>답변자</th>
                        <th>작성일</th>
                        <th>답변 사항</th>
                        <th> </th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody id="replyTableBody">
                    <!-- 답변 목록이 여기에 동적으로 추가됩니다 -->
                </tbody>
            </table>

            <c:if test="${sessionScope.loginUser.role == 'admin'}">
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
            </c:if>
        </section>
    </main>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script>
        $(document).ready(function() {
            selectAnswerList();
        });

        const contextPath = "${pageContext.request.contextPath}";

        function selectAnswerList() {
            $.ajax({
                url: `${contextPath}/InquiryAnswer/selectAnswerList`,
                data: { inquiryNo: '${inquiry.inquiryNo}' },
                success: function(result) {
                    console.log("서버 응답:", result);
                    
                    if (!Array.isArray(result)) {
                        console.error("서버 응답이 배열이 아닙니다:", result);
                        return;
                    }
                    
                    let answers = "";
                    if (result.length === 0) {
                        answers = "<tr><td colspan='5'>현재 문의 확인중입니다.</td></tr>";
                    } else {
                        for (let InquiryAnswer of result) {
                            console.log("각 답변 데이터:", InquiryAnswer);
                            answers += "<tr>";
                            
                            answers += `<td>\${InquiryAnswer.answerWriter}</td>`;
                            answers += `<td>\${formatDate(InquiryAnswer.createDate)}</td>`;
                            answers += `<td>\${InquiryAnswer.answerContent}</td>`;
                            answers += `<td>
                                        <c:if test="${sessionScope.loginUser.role == 'admin'}">
                                            <button onclick='showAnswerUpdateForm(\${InquiryAnswer.answerNo}, this)'>수정</button>
                                            <button onclick='deleteAnswer(\${InquiryAnswer.answerNo})'>삭제</button>
                                        </c:if>
                                       </td>`;
                            answers += "</tr>";
                        }
                    }
                    
                    $("#replyTableBody").html(answers);
                },
                error: function(xhr, status, error) {
                    console.error("댓글 목록 불러오기 실패:", error);
                }
            });
        }

        function insertAnswer() {
            $.ajax({
                url: `${contextPath}/InquiryAnswer/insertAnswer`,
                type: 'POST',
                data: JSON.stringify({
                    inquiryNo: '${inquiry.inquiryNo}',
                    answerContent: $("#replyContent").val()
                }),
                contentType: 'application/json',
                success: function(result) {
                    if (result == 0) alert('댓글 등록 실패');
                    else alert('댓글 등록 성공');
                    selectAnswerList();
                    $('#replyContent').val("");
                }
            });
        }
        
        function showAnswerUpdateForm(answerNo, btn){
            var $textArea = $("<textarea></textarea>");
            var $button = $("<button></button>").text("수정");
            
            var $td = $(btn).parent().parent().children().eq(2);
            
            $textArea.text($td.text());
            
            $td.html("");
            $td.append($textArea).append($button);
            
            $button.click(function(){
                updateAnswer(answerNo, $textArea);
            });
        }
        
        function deleteAnswer(answerNo){
            $.ajax({
                url : "${contextPath}/InquiryAnswer/deleteAnswer",
                data : {
                     answerNo: answerNo
                },
                type : 'POST',
                success : function(result){
                    if(result > 0){
                        alert("댓글 삭제 성공");
                    }else{
                        alert("댓글 삭제 실패");
                    }
                    selectAnswerList();
                }
            })
        }
        
        function updateAnswer(answerNo , $textArea){
            $.ajax({
                url : "${contextPath}/InquiryAnswer/updateAnswer",
                data : JSON.stringify({
                     answerNo: answerNo,
                     answerContent : $textArea.val()
                }),
                type : 'POST',
                contentType: 'application/json',
                success : function(result){
                    if(result > 0){
                        alert("댓글 수정 성공");
                    }else{
                        alert("댓글 수정 실패");
                    }
                    selectAnswerList();
                },
                error: function(xhr, status, error) {
                    console.error("댓글 수정 실패:", error);
                }
            })
        }
        
        function formatDate(timestamp) {
            const date = new Date(timestamp);
            const year = date.getFullYear().toString().slice(-2); // Get last 2 digits of year
            const month = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero-based
            const day = ('0' + date.getDate()).slice(-2);
            return `${year}-${month}-${day}`;
        }
    </script>
</body>
</html>
