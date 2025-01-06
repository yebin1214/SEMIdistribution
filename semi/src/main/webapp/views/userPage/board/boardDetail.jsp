<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/board2.css"
	type="text/css">    
</head>
<body>
	
	<%@ include file="/views/common/menubar.jsp"%>
	
    <div class="container">
        <!-- 게시판 헤더 -->
        <div class="header">
            <div class="title" id="post-title">제목을 여기에 표시</div>
            <div class="meta">
                작성자: <span id="post-author">관리자</span> | 
                날짜: <span id="post-date">2024-12-23</span>
            </div>
        </div>

        <!-- 본문 내용 -->
        <div class="content">
            <div class="notice" id="post-content">공지사항 간단한 설명, 내용, 사진</div>
            <div class="image-placeholder" id="post-image">이미지 영역</div>
        </div>

        <!-- 댓글 섹션 -->
        <div class="comments" id="comments-section">
            <!-- 나중에 JS로 동적으로 추가 가능 -->
            <div class="comment">
                <div class="author">아무개</div>
                <div class="date">2024-09-18</div>
                <p>전 셰프 메밀국수 장국과 이마트 생메밀면 올 여름 자주 해먹었어요.</p>
            </div>
            <div class="comment">
                <div class="author">마당개</div>
                <p>저두요...</p>
            </div>
        </div>

        <!-- 댓글 입력 -->
        <div class="comment-input">
            <input type="text" placeholder="댓글 작성란" id="comment-input">
            <button id="add-comment-btn">댓글 등록</button>
        </div>

        <!-- 추천 버튼 -->
        <div class="recommend">
            <button id="recommend-btn">👍 추천</button>
            <button type="button" class="list-btn" onclick="location.href='<%=request.getContextPath()%>/views/userPage/board//boardFree.jsp'">목록으로</button>
        </div>
    </div>
</body>
</html>