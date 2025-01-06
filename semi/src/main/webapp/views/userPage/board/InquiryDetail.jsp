<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의상세내용</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/service.css"
	type="text/css">

<style>
/* 📦 전체 컨테이너 스타일 */
.detailed-inquiry {
    max-width: 700px;
    margin: 40px auto;
    padding: 30px;
    border-radius: 10px;
    background: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
}

/* 🧠 헤더 스타일 */
.detailed-header {
    text-align: center;
    margin-bottom: 20px;
}

.detailed-header h2 {
    font-size: 24px;
    font-weight: bold;
    color: #4A4E69;
}

/* 📑 정보 영역 */
.detailed-info {
    margin-bottom: 20px;
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 10px;
}

.info-row {
    display: flex;
    justify-content: space-between;
    margin: 8px 0;
}

.info-row .label {
    font-weight: bold;
    color: #6C757D;
}

.info-row span {
    font-size: 14px;
}

/* 📝 내용 영역 */
.detailed-content {
    margin: 20px 0;
    padding: 15px;
    background-color: #F8FAFC;
    border-radius: 8px;
}

.detailed-content h3 {
    font-size: 18px;
    margin-bottom: 10px;
    color: #4A4E69;
}

.detailed-content p {
    line-height: 1.6;
    color: #495057;
}

/* 💬 관리자 답변 */
.detailed-comment {
    margin: 20px 0;
    padding: 15px;
    background-color: #F1F0FF;
    border-radius: 8px;
    border-left: 4px solid #A78BFA;
}

.detailed-comment h3 {
    font-size: 18px;
    margin-bottom: 8px;
    color: #6D28D9;
}

.detailed-comment p {
    line-height: 1.6;
    color: #4B5563;
}

.comment-timestamp {
    font-size: 12px;
    color: #9CA3AF;
    margin-top: 5px;
    text-align: right;
}

/* 🎛️ 버튼 영역 */
.detailed-buttons {
    margin-top: 30px;
    text-align: center;
}

.detailed-buttons button {
    margin: 5px;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #E8DFF2;
    color: #4A4E69;
    transition: background-color 0.2s ease-in-out;
}

.detailed-buttons button:hover {
    background-color: #D0C4E0;
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
				<div class="inquiry detailed-inquiry">
					<!-- 문의 상세보기 내용이 들어갈 영역 -->
					<div class="detailed-header">
						<h2>📄 문의 상세보기</h2>
					</div>

					<div class="detailed-info">
						<div class="info-row">
							<span class="label">📝 제목:</span> <span id="title">이마트 24는
								상품정보 안나오나요?</span>
						</div>
						<div class="info-row">
							<span class="label">👤 작성자:</span> <span id="author">abc1234</span>
						</div>
						<div class="info-row">
							<span class="label">⏰ 작성시간:</span> <span id="time">2024-12-11
								22:35</span>
						</div>
					</div>

					<div class="detailed-content">
						<h3>📌 내용</h3>
						<p id="content">이마트 24는 상품정보가 아직 등록되지 않은 것 같습니다. 언제 등록될까요?</p>
					</div>

					<div class="detailed-comment">
						<h3>💬 관리자 답변</h3>
						<p id="comment">이마트 24도 등록예정이니 조금만 기다려주시면 감사하겠습니다.</p>
						<p class="comment-timestamp" id="comment-time">2024-12-11
							22:40</p>
					</div>

					<div class="detailed-buttons">
						<button onclick="editContent()">✏️ 수정</button>
						<button onclick="deleteContent()">🗑️ 삭제</button>
						<button onclick="goToList()">📋 목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 🚀 더미 데이터 (실제로는 서버에서 가져올 데이터)
		const inquiryData = {
			title : "이마트 24는 상품정보 안나오나요?",
			author : "abc1234",
			time : "2024-12-11 22:35",
			content : "이마트 24는 상품정보가 아직 등록되지 않은 것 같습니다. 언제 등록될까요?",
			comment : "이마트 24도 등록예정이니 조금만 기다려주시면 감사하겠습니다.",
			commentTime : "2024-12-11 22:40"
		};

		// 📦 데이터 렌더링
		function renderData() {
			document.getElementById('title').textContent = inquiryData.title;
			document.getElementById('author').textContent = inquiryData.author;
			document.getElementById('time').textContent = inquiryData.time;
			document.getElementById('content').textContent = inquiryData.content;
			document.getElementById('comment').textContent = inquiryData.comment;
			document.getElementById('comment-time').textContent = inquiryData.commentTime;
		}

		// 🛠️ 버튼 기능
		function editContent() {
			window.location.href = 'edit.html';
		}

		function deleteContent() {
			if (confirm('정말 삭제하시겠습니까?')) {
				alert('삭제되었습니다.');
				window.location.href = 'list.html';
			}
		}

		function goToList() {
			window.location.href = 'serviceInquiry.jsp';
		}

		// 페이지 로드 시 데이터 렌더링
		window.onload = renderData;
	</script>



</body>
</html>