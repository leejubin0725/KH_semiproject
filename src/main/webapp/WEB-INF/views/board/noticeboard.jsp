<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="description" content="Figma htmlGenerator">
    <meta name="author" content="htmlGenerator">
    <link href="https://fonts.googleapis.com/css?family=Sigmar+One&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath }/resources/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main>
        <section class="hero2">
  
            <br><br><br><br><br><br>
       
        </section>


        <section class="board">
            <h1>자유게시판</h1>
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>작성시간</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>배달해줘</td>
                        <td>이름숨김</td>
                        <td>2023-12-17</td>
                        <td>3</td>
                    </tr>
                    <!-- 나머지 행들도 비슷한 구조로 추가 -->
                </tbody>
            </table>
            <button class="write-btn">글쓰기</button>
        </section>
    </main>
    	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>