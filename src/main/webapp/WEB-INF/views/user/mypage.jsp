<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/mypage.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/styles.css">
</head>
<body>
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
   <div class="mypage-body">
      <div class="mypage-container">
         <h1>마이페이지</h1>
         <form id="updateForm" action="${contextPath}/user/update" method="post">
            <div class="mypage-form-group">
               <label for="name">이메일:</label> <input type="text" id="email"
                  name="email" value="${loginUser.email}" readonly>
            </div>
            <div class="mypage-form-group">
               <label for="password">비밀번호:</label> <input type="password"
                  id="password" name="password">
            </div>
            <div class="mypage-form-group">
               <label for="userid">닉네임:</label> <input type="text" id="nickname"
                  name="nickname" value="${loginUser.nickname}">
            </div>
            <div class="mypage-form-group">
               <label for="userphone">연락처:</label> <input type="text" id="phone"
                  name="phone" value="${loginUser.phone}">
            </div>
            <div class="mypage-form-group">
               <label for="useremail">주소:</label> <input type="text" id="address"
                  name="address" value="${loginUser.address}">
            </div>

            <button type="button" class="mypage-button" onclick="confirmUpdate()">개인정보 수정</button>
         </form>
         <c:if test="${sessionScope.loginUser.role == 'regular'}">
         <button class="mypage-button" onclick="redirectToMyPost();">내가 쓴 글</button>
         </c:if>
      
          <c:if test="${sessionScope.loginUser.role == 'rider'}">
         <button class="mypage-button" onclick="acceptorder();">현재 배달 정보</button>
         </c:if>
         <c:if test="${sessionScope.loginUser.role == 'admin'}">
         <button class="mypage-button" onclick="redirectToReports();">신고 목록</button>
         </c:if>
         <button class="mypage-button secondary" onclick="confirmDelete()">회원탈퇴</button>
        
      </div>
   </div>

   <%@ include file="/WEB-INF/views/common/footer.jsp"%>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
        function redirectToMyPost() {
            var contextPath = "${pageContext.request.contextPath}";
            window.location.href = contextPath + "/user/mypost";
        }

        function redirectToReports() {
            var contextPath = "${pageContext.request.contextPath}";
            window.location.href = contextPath + "/user/reportList";
        }

        function confirmDelete() {
            if (confirm("정말로 탈퇴하시겠습니까?")) {
                var contextPath = "${pageContext.request.contextPath}";
                window.location.href = contextPath + "/user/delete";
            }
        }

        function confirmUpdate() {
            if (confirm("개인정보를 수정하시겠습니까?")) {
                document.getElementById("updateForm").submit();
            }
        }
        
        function acceptorder(){
        	var contextPath = "${pageContext.request.contextPath}";
        	window.location.href = contextPath + "/order/riderOrderSelect";
        }
    </script>
</body>
</html>
