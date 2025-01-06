<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>CU 상품탭</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/common.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/review.css">
<%@ include file="/views/common/menubar.jsp"%>
</head>
<body>
	<div id="app">
		<!-- 카테고리 탭 -->
		<div class="tab-bar">
			<div class="tab" data-category="all">전체</div>
			<div class="tab" data-category="snack">과자</div>
			<div class="tab" data-category="food">식품</div>
			<div class="tab" data-category="drink">음료수</div>
			<div class="tab" data-category="ice">아이스크림</div>
			<div class="tab" data-category="always">차별화 제품</div>
			<div class="tab" data-category="fast">즉석 식품</div>
			<div class="tab" data-category="plus">행사 식품</div>
		</div>

		<!-- 검색창 -->
		<div class="container">
			<div class="row" style="justify-content: center; margin-top: 30px;">
				<form id="searchForm" style="display: flex; width: 50%;">
					<input type="text" class="form-control" placeholder="상품을 입력해주세요"
						id="searchText"
						style="flex: 1; color: green; font-weight: bold; border-radius: 4px 0 0 4px; border: 1px solid #ccc; height: 38px;">
					<button type="button" class="btn btn-success" id="searchButton"
						style="border-radius: 0 4px 4px 0; border: 1px solid #28a745; height: 38px; padding: 0 20px; background-color: #D0C1E3; color: white;">
						상품 검색</button>
				</form>
			</div>
		</div>
		<div id="banner-container"
			style="display: none; text-align: center; margin: 20px">
			<button class="banner-button" data-subcategory="oneplus"
				style="margin: 10px; padding: 10px 20px">1+1 상품</button>
			<button class="banner-button" data-subcategory="twoplus"
				style="margin: 10px; padding: 10px 20px">2+1 상품</button>
		</div>

		<!-- 이미지 리스트 컨테이너 -->
		<div class="content" id="image-container"></div>
	</div>

	<script>
	async function fetchImages(category, searchText = "") {
	    try {
	        const response = await fetch("http://localhost:3000/api/images");
	        const data = await response.json();
	        console.log("API 응답 데이터:", data);

	        if (!data.success) {
	            console.error("API 호출 실패: 성공 플래그가 false입니다.");
	            return;
	        }

	        const container = document.getElementById("image-container");
	        container.innerHTML = ""; // 컨테이너 초기화

	        const filteredImages = data.images.filter((image) => {
	            const hasProductNo = image.PRODUCT_NO !== undefined && image.PRODUCT_NO !== null;
	            const matchesCategory =
	                category === "all" ||
	                (image.PRODUCT_NAME &&
	                 image.PRODUCT_NAME.some((name) => name.replace(/'/g, "").toLowerCase().includes(category.toLowerCase())));
	            const matchesSearchText = searchText
	                ? image.PRODUCT_NAME.some((name) => name.replace(/'/g, "").toLowerCase().includes(searchText.toLowerCase()))
	                : true;

	            return hasProductNo && matchesCategory && matchesSearchText;
	        });

	        console.log("Filtered Images:", filteredImages);

	        if (filteredImages.length === 0) {
	            container.innerHTML = "<p>검색 결과가 없습니다.</p>";
	            return;
	        }

	        filteredImages.forEach((image) => {
	            // 개별 상품 컨테이너 생성
	            const productContainer = document.createElement("div");
	            productContainer.style.display = "inline-block";
	            productContainer.style.textAlign = "center";
	            productContainer.style.margin = "20px";

	            // 링크 생성
	            const linkElement = document.createElement("a");
	            linkElement.href = image.LINKED || "#";
	            linkElement.target = "_self";

	            // 이미지 생성
	            const imgElement = document.createElement("img");
	            imgElement.src = image.IMAGE_URL || "default-image.jpg";
	            imgElement.alt = "상품 이미지";
	            imgElement.style.width = "200px";
	            imgElement.style.margin = "10px 0";

	            // 상품 이름 표시
	            const nameElement = document.createElement("p");
	            nameElement.textContent = image.PRODUCT_NAME.join(", ");
	            nameElement.style.fontWeight = "bold";

	            // 상품 가격 표시
	            const priceElement = document.createElement("p");
	            priceElement.textContent = `\${image.PRODUCT_PRICE.toLocaleString()}원`;
	            priceElement.style.color = "green";

	            // 구조 조합: 이미지 -> 이름 -> 가격
    
	            linkElement.appendChild(imgElement);
	            productContainer.appendChild(linkElement);
	            productContainer.appendChild(nameElement);
	            productContainer.appendChild(priceElement);

	            container.appendChild(productContainer);

	            console.log("생성된 링크:", linkElement.href); // 디버깅
	        });
	    } catch (error) {
	        console.error("API 호출 실패:", error);
	    }
	}

document.querySelectorAll(".tab").forEach((tab) => {
    tab.addEventListener("click", (e) => {
        const category = e.target.dataset.category;

        // 탭 선택 상태 업데이트
        document.querySelectorAll(".tab").forEach((t) => t.classList.remove("clicked"));
        e.target.classList.add("clicked");

        // 이미지 가져오기
        fetchImages(category);

        // 행사식품(plus)일 경우 배너 표시
        const bannerContainer = document.getElementById("banner-container");
        if (category === "plus") {
            bannerContainer.style.display = "block"; // 배너 표시
        } else {
            bannerContainer.style.display = "none"; // 배너 숨기기
        }
    });
});

document.querySelector('.banner-button[data-subcategory="oneplus"]').addEventListener("click", () => {
    fetchImages("plus", "oneplus"); // 1+1 상품 필터링
});

document.querySelector('.banner-button[data-subcategory="twoplus"]').addEventListener("click", () => {
    fetchImages("plus", "twoplus"); // 2+1 상품 필터링
});

document.getElementById("searchButton").addEventListener("click", () => {
    const searchText = document.getElementById("searchText").value.trim();
    fetchImages("all", searchText);
});

window.onload = () => {
    fetchImages("all");
};
</script>
</body>
</html>