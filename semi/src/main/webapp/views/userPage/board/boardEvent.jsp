<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사게시판</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/board.css"
	type="text/css">
	
</head>
<body>


	<%@ include file="/views/common/menubar.jsp"%>

	<main>
		<section class="notice-section">
			<h2>행사게시판</h2>

			<!-- 검색 및 정렬 -->
			<div class="search-bar">
				<div class="sort-dropdown">
					<button class="sort-icon-btn">정렬 ▼</button>
					<ul class="sort-options">
						<li onclick="sortNotices('추천')">추천순</li>
						<li onclick="sortNotices('조회')">조회순</li>
						<li onclick="sortNotices('최신')">최신순</li>
					</ul>
				</div>
				<input type="text" id="searchInput" placeholder="검색어를 입력하세요" />
				<button onclick="filterTable()">🔍 검색</button>
			</div>

			<!-- 공지사항 테이블 -->
			<table class="notice-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody id="noticeTableBody">
					<!-- JSP로 공지사항 데이터를 렌더링 -->
					<%
					// 예제 데이터
					class Notice {
						int 번호, 조회수, 추천;
						String 제목, 작성자, 날짜;

						Notice(int 번호, String 제목, String 작성자, String 날짜, int 조회수, int 추천) {
							this.번호 = 번호;
							this.제목 = 제목;
							this.작성자 = 작성자;
							this.날짜 = 날짜;
							this.조회수 = 조회수;
							this.추천 = 추천;
						}
					}

					Notice[] notices = {new Notice(1, "공지사항 1", "관리자", "2024-12-01", 123, 15),
							new Notice(2, "공지사항 2", "관리자", "2024-12-02", 456, 25),
							new Notice(3, "긴 제목의 공지사항", "사용자", "2024-12-03", 789, 8)};

					for (Notice notice : notices) {
					%>
					<tr>
						<td><%=notice.번호%></td>
						<td><%=notice.제목%></td>
						<td><%=notice.작성자%></td>
						<td><%=notice.날짜%></td>
						<td><%=notice.조회수%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<button class="page-btn">&lt;</button>
				<button class="page-btn active">1</button>
				<button class="page-btn">2</button>
				<button class="page-btn">3</button>
				<button class="page-btn">4</button>
				<button class="page-btn">5</button>
				<button class="page-btn">&gt;</button>
			</div>


		</section>
	</main>

	<script>
        // 정렬 기능
        function sortNotices(criteria) {
            const rows = Array.from(document.querySelectorAll("#noticeTableBody tr"));
            const sortedRows = rows.sort((rowA, rowB) => {
                const getValue = (row, index) => row.children[index].innerText;

                if (criteria === "추천") {
                    return parseInt(getValue(rowB, 4)) - parseInt(getValue(rowA, 4)); // 추천순
                } else if (criteria === "조회") {
                    return parseInt(getValue(rowB, 4)) - parseInt(getValue(rowA, 4)); // 조회순
                } else if (criteria === "최신") {
                    return new Date(getValue(rowB, 3)) - new Date(getValue(rowA, 3)); // 최신순
                }
            });

            const tableBody = document.getElementById("noticeTableBody");
            tableBody.innerHTML = "";
            sortedRows.forEach(row => tableBody.appendChild(row));
        }

        // 검색 기능
        function filterTable() {
            const searchInput = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#noticeTableBody tr");
            
            rows.forEach(row => {
                const title = row.children[1].innerText.toLowerCase();
                const author = row.children[2].innerText.toLowerCase();
                if (title.includes(searchInput) || author.includes(searchInput)) {
                    row.style.display = ""; // 표시
                } else {
                    row.style.display = "none"; // 숨김
                }
            });
        }
    </script>

</body>
</html>