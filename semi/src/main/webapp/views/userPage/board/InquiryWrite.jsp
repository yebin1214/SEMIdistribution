<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/service.css"
	type="text/css">
	
<style>
/* 전체 컨테이너 스타일 */
.inquiry {
    max-width: 600px;
    margin: 50px auto;
    padding: 30px;
    background: linear-gradient(135deg, #f9fafc, #eef1f7);
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    font-family: 'Arial', sans-serif;
}

/* 제목 스타일 */
.inquiry-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #333;
}

/* 폼 그룹 스타일 */
.form-group {
    margin-bottom: 20px;
    text-align: left;
}

.form-label {
    font-weight: bold;
    margin-bottom: 8px;
    display: block;
    color: #555;
}

/* 입력 필드 스타일 */
.form-control {
    width: 100%;
    padding: 12px;
    margin-top: 5px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s;
}

.form-control:focus {
    border-color: #4a90e2;
    outline: none;
}

/* 텍스트 영역 스타일 */
textarea.form-control {
    resize: none;
}

/* 버튼 스타일 */
.btn-submit {
    width: 100%;
    padding: 12px;
    margin-top: 20px;
    background-color: #D0C1E3;
    color: white;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-submit:hover {
    background-color: #4A47A3;
}
</style>	
	

</head>
<body>

	<div class="container">
		<!-- Sidebar Include -->
		<div><%@ include file="/views/common/serviceSidebar.jsp"%></div>

		<div class="content">
			<!-- Header Include -->
			<div><%@ include file="/views/common/serviceHeader.jsp"%></div>

			<div class="inquiry">

				<h2 class="inquiry-title">1:1 문의</h2>
				<form action="/inquiry/submit" method="post" class="inquiry-form">
					<div class="form-group">
						<label for="title" class="form-label">📌 제목</label> <input
							type="text" id="title" name="title" class="form-control"
							placeholder="제목을 입력해 주세요." required>
					</div>
					<div class="form-group">
						<label for="content" class="form-label">📝 내용</label>
						<textarea id="content" name="content" class="form-control"
							rows="6" placeholder="문의 내용을 입력해 주세요." required></textarea>
					</div>
					<button type="submit" class="btn-submit">🚀 문의등록하기</button>
				</form>

			</div>


		</div>
	</div>

</body>
</html>