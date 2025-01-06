<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mypage.css"
	type="text/css">
</head>
<body>
	<header>
		<div class="header-container">
            <h1 class="logo">
                <a href="/semi/index.jsp">
                    <img src="<%=request.getContextPath() %>/resources/img/logo.png" alt="편리하조 로고">
                </a>
            </h1>
            <h2>마이페이지</h2>
        </div>
	</header>

	<main>
		<section class="mypage-container">
			<nav class="mypage-nav">
				<ul>
					<li><a href="#" class="active">회원정보</a></li>
					<li><a href="#">등록한 게시글</a></li>
					<li><a href="#">등록한 댓글</a></li>
					<li><a href="${pageContext.request.contextPath}/views/userPage/member/savelist.jsp">찜 목록</a></li>
				</ul>
			</nav>

			<div class="mypage-content">
				<h3>회원정보</h3>
				<form action="updateProfile.jsp" method="POST">
					<table>
						<tr>
							<th>이메일</th>
							<td>
								<div class="email-group">
									<input type="text" name="email" value="abcd1111"> @ <input
										type="text" name="email_domain" placeholder="직접 입력">
									<button type="button">본인인증</button>
								</div>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="user_id" value="아이디" readonly>
								<button type="button">중복조회</button></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="password"
								placeholder="비밀번호"></td>
						</tr>
						<tr>
							<th>비밀번호 변경</th>
							<td><input type="password" name="new_password"
								placeholder="새 비밀번호"></td>
						</tr>
						<tr>
							<th>비밀번호 재입력</th>
							<td><input type="password" name="confirm_password"
								placeholder="새 비밀번호 확인"></td>
						</tr>
					</table>
					<div class="form-buttons">
						<button type="submit">수정</button>
						<button type="button" onclick="deleteAccount()">계정삭제</button>
					</div>
				</form>
			</div>
		</section>
	</main>


	<script>
		function deleteAccount() {
			if (confirm('정말로 계정을 삭제하시겠습니까?')) {
				window.location.href = 'deleteAccount.jsp';
			}
		}
	</script>
</body>
</html>
