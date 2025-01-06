<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>1번 상품 이미지</title>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/resources/css/review.css" " />
<%@ include file="/views/common/menubar.jsp"%>
<style>
.rating {
	color: gold;
	font-size: 16px;
}
</style>
</head>
<body>
	<div id="img-container">
		<p id="loading" class="loading">이미지를 불러오는 중...</p>
		<img id="product-image" alt="상품 이미지">
		<p id="error-message" class="error" style="display: none"></p>
	</div>

	<div class="button-container">
		<form action="<%= request.getContextPath() %>/kart/insert"
			method="post">
			<input type="hidden" name="productNo" id="productNo" value="1" /> <input
				type="hidden" name="productName" id="productName" value="샘플 상품" />
			<button type="submit" id="addToWishlist"
				style="width: 100px; background: #d0c1e3; color: white;">찜
				등록</button>
		</form>
		<button id="backButton"
			style="width: 150px; background: #d0c1e3; color: white;">뒤로가기</button>
	</div>

	<%-- 로그인 여부 확인 --%>
	<% 
        String user = (String) session.getAttribute("user"); // 세션에서 로그인 정보 가져오기
    %>

	<div class="review-container">
		<% if (user != null) { %>
		<!-- 로그인된 사용자만 리뷰 작성 가능 -->
		<form action="/review/submit" method="post">
			<textarea id="reviewInput" name="reviewContent"
				placeholder="리뷰를 작성해주세요"></textarea>
			<label for="reviewRating">별점:</label>
			<div class="rating-container">
				<input type="hidden" name="reviewRating" id="reviewRating" value="0" />
				<span class="star" data-value="1">&#9733;</span> <span class="star"
					data-value="2">&#9733;</span> <span class="star" data-value="3">&#9733;</span>
				<span class="star" data-value="4">&#9733;</span> <span class="star"
					data-value="5">&#9733;</span>
			</div>
			<input type="hidden" name="productNo" id="reviewProductNo" />
			<button type="submit" id="submitReview">리뷰 등록</button>
		</form>
		<% } else { %>
		<!-- 로그인하지 않은 경우 -->
		<p>
			리뷰를 작성하려면 <a href="/login.jsp">로그인</a> 해주세요.
		</p>
		<% } %>
	</div>

	<ul id="reviewList" class="review-list"></ul>

	<script>
        // 1번 상품 API 경로 설정
        const apiUrl = "http://localhost:3000/api/images/1";

        // DOM 요소 가져오기
        const loadingElement = document.getElementById("loading");
        const productImageElement = document.getElementById("product-image");
        const errorMessageElement = document.getElementById("error-message");
        const productNoInput = document.getElementById("productNo");
        const productNameInput = document.getElementById("productName");
        const reviewProductNoInput = document.getElementById("reviewProductNo");

        // API 호출 및 이미지 출력
        let productData = null; // 상품 데이터를 저장할 변수

        fetch(apiUrl)
            .then((response) => response.json())
            .then((data) => {
                // 로딩 메시지 숨기기
                loadingElement.style.display = "none";

                if (data.success && data.image) {
                    productData = data.image; // 상품 데이터 저장

                    // 이미지 표시
                    productImageElement.src = productData.url;
                    productImageElement.style.display = "block";

                    // 숨겨진 입력 필드에 값 설정
                    productNoInput.value = productData.id;
                    productNameInput.value = productData.name;
                    reviewProductNoInput.value = productData.id;
                } else {
                    // 데이터 없음 메시지 표시
                    errorMessageElement.textContent = "이미지를 불러올 수 없습니다.";
                    errorMessageElement.style.display = "block";
                }
            })
            .catch((error) => {
                // 오류 메시지 표시
                console.error("API 호출 오류:", error);
                loadingElement.style.display = "none";
                errorMessageElement.textContent = "데이터를 불러오는 중 문제가 발생했습니다.";
                errorMessageElement.style.display = "block";
            });

        // 뒤로가기 버튼 기능
        document.getElementById("backButton").addEventListener("click", () => {
            window.location.href = "http://localhost:8083/semi/views/store/cu.jsp";
        });

        // 리뷰 리스트 데이터 예제
        const reviews = [
            { user: "사용자1", content: "좋아요!", rating: 5 },
            { user: "사용자2", content: "괜찮은 상품이에요.", rating: 4 },
            { user: "사용자3", content: "그저 그래요.", rating: 3 }
        ];
        
        // 별점 선택 기능
        const stars = document.querySelectorAll(".star");
        const reviewRatingInput = document.getElementById("reviewRating");

        stars.forEach(star => {
            star.addEventListener("click", () => {
                // 모든 별 초기화
                stars.forEach(s => s.classList.remove("selected"));
                // 클릭한 별 이하 모두 선택
                const rating = star.getAttribute("data-value");
                reviewRatingInput.value = rating; // 선택한 별점 저장
                for (let i = 0; i < rating; i++) {
                    stars[i].classList.add("selected");
                }
            });
        });

        // 리뷰 출력 함수
        function renderReviews() {
            const reviewListElement = document.getElementById("reviewList");
            reviewListElement.innerHTML = ""; // 기존 리뷰 초기화

            reviews.forEach((review) => {
                const li = document.createElement("li");
                li.innerHTML = `
                    <strong>${review.user}</strong>: ${review.content} 
                    <span class="rating">${"★".repeat(review.rating)}${"☆".repeat(5 - review.rating)}</span>
                `;
                reviewListElement.appendChild(li);
            });
        }

        // 리뷰 렌더링 실행
        renderReviews();
    </script>
</body>
</html>