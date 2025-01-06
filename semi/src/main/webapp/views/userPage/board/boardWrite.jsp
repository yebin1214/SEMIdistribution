<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/board2.css"
	type="text/css">
</head>
<body>

	<%@ include file="/views/common/menubar.jsp"%>

	<div class="wrapper">
		<div class="container">
			<h2>글을 작성하는 공간</h2>
			<div class="form-group">
				<label for="title">제목 입력란</label> <input type="text" id="title"
					placeholder="제목을 입력하세요">
			</div>
			<div class="form-group">
				<label for="content">내용 입력란</label>
				<textarea id="content" placeholder="내용을 입력하세요"></textarea>
			</div>
			<button class="btn">글작성</button>
			<div class="file-upload">
				<label for="file"></label> <input type="file" id="file">
			</div>
		</div>
	</div>

</body>
</html>