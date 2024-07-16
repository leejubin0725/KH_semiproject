<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>폼 예제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>
    <div class="container">
        <form action="${contextPath }/inquiry/inquiryInsert" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">1:1 문의 사항</label>
                <input type="text" id="title" name="title" placeholder="제목 입력">
            </div>

            <div class="form-group">
                <label for="content">상세 내용</label>
                <textarea id="content" name="content" placeholder="내용 입력" style="resize: none;"></textarea>
            </div>

            <div class="form-group">
                <label for="file">파일 선택</label>
                <input type="file" id="file" name="file">
            </div>

            <div class="form-group">
                <label for="category">대분류</label>
                <select id="category" name="category">
                    <c:forEach items="${inquiryCategoryList}" var="categoryList">
                       <option>${categoryList.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">등록</button>
                <button type="button" class="btn-cancel">취소</button>
            </div>
        </form>
    </div>
    <script>
        document.getElementById('file').addEventListener('change', function() {
            document.getElementById('file-name').textContent = this.files[0] ? this.files[0].name : '선택된 파일 없음';
        });
    </script>
</body>
</html>