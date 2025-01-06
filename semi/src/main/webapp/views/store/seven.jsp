<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>SEVEN 상품텝입니다.</title>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/resources/css/common.css" />
<%@ include file="/views/common/menubar.jsp"%>
</head>
<body>

	<div id="app">
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

		<div id="banner-containerdrink" class="banner-category" data-category="drink" style="display: none;">
			<button class="banner-button1" data-subcategory="DrinkDlfqks">음료수</button>
			<button class="banner-button1" data-subcategory="DrinkMilk">유제품</button>
			<button class="banner-button1" data-subcategory="Drinkcoffie">커피</button>
		</div>
		<div id="banner-containernoodle" class="banner-category" data-category="noodle" style="display: none;">
			<button class="banner-button1" data-subcategory="Cupnoodle">컵라면</button>
			<button class="banner-button1" data-subcategory="NoodleDlfqks">일반라면</button>
		</div>
		<div id="banner-containerfast" class="banner-category" data-category="fast" style="display: none;">
			<button class="banner-button1" data-subcategory="LunchBox">도시락</button>
			<button class="banner-button1" data-subcategory="Gimbap">김밥</button>
			<button class="banner-button1" data-subcategory="Salad">샐러드, 기타</button>
			<button class="banner-button1" data-subcategory="Burger">햄버거</button>
			<button class="banner-button1" data-subcategory="Hot">핫도그, 샌드위치</button>
		</div>
		<div id="banner-container" class="banner-category" data-category="plus" style="display: none; text-align: center; margin: 20px">
			<button class="banner-button1" data-subcategory="oneplus">1+1 상품</button>
			<button class="banner-button1" data-subcategory="twoplus">2+1 상품</button>
		</div>

		<div class="container">
			<div class="row" style="justify-content: center; margin-top: 30px; position: relative">
				<form id="searchForm" style="display: flex; align-items: center; gap: 0; width: 50%; height: 15%">
					<input type="text" class="form-control" placeholder="상품을 입력해주세요" id="searchText"
						style="flex: 1; color: green; font-weight: bold; border-radius: 4px 0 0 4px; border: 1px solid #ccc; height: 38px; margin-bottom : 5px " />
					<button type="button" class="btn btn-success" id="searchButton"
						style="border-radius: 0 4px 4px 0; border: 1px solid #28a745; height: 38px; padding: 0 20px;background-color : #D0C1E3;color:white;">
						상품 검색</button>
				</form>
			</div>
		</div>

		<div class="content" id="image-container"></div>
	</div>
	<div class="content" id="image-container"></div>

	<script>
    const API_URL = "http://localhost:5000/api/images";

    async function fetchImages(category, subcategory = "", searchText = "") {
        try {
            const response = await fetch(API_URL);
            const data = await response.json();

            if (data.success) {
                const container = document.getElementById("image-container");
                container.innerHTML = "";

                const filteredImages = data.images.filter((image) => {
                    const matchesCategory = category === "all" || image.category === category;
                    const matchesSubcategory = !subcategory || image.subcategory === subcategory;
                    const matchesSearchText = searchText
                        ? image.name.toLowerCase().includes(searchText.toLowerCase())
                        : true;

                    return matchesCategory && matchesSubcategory && matchesSearchText;
                });

                if (filteredImages.length > 0) {
                    filteredImages.forEach((image) => {
                        const linkElement = document.createElement("a");
                        linkElement.href = image.link || "#";
                        linkElement.target = "_blank";

                        const imgElement = document.createElement("img");
                        imgElement.src = image.url;
                        imgElement.alt = image.name;
                        imgElement.style.width = "200px";
                        imgElement.style.margin = "30px";

                        linkElement.appendChild(imgElement);
                        container.appendChild(linkElement);
                    });
                } else {
                    container.innerHTML = "<p>검색 결과가 없습니다.</p>";
                }
            }
        } catch (error) {
            console.error("API 호출 실패:", error);
        }
    }

    // 탭 클릭 이벤트
    document.querySelectorAll(".tab").forEach((tab) => {
        tab.addEventListener("click", (e) => {
            const category = e.target.dataset.category;

            // 탭 선택 상태 업데이트
            document.querySelectorAll(".tab").forEach((t) => t.classList.remove("clicked"));
            e.target.classList.add("clicked");

            // 모든 배너 숨김 후 선택한 카테고리만 표시
            document.querySelectorAll(".banner-category").forEach((banner) => {
                banner.style.display = banner.dataset.category === category ? "block" : "none";
            });

            // 이미지 가져오기
            if (category !== "all") {
                fetchImages(category); // 선택한 카테고리의 이미지 불러오기
            } else {
                fetchImages("all"); // 전체 항목 로드
            }
        });
    });

    // 배너 버튼 클릭 이벤트
    document.querySelectorAll(".banner-button1").forEach((button) => {
        button.addEventListener("click", () => {
            const subcategory = button.dataset.subcategory;
            const category = button.closest(".banner-category").dataset.category; // 상위 카테고리 가져오기
            fetchImages(category, subcategory); // 선택한 카테고리와 서브카테고리로 필터링
        });
    });

    // 검색 버튼 클릭 이벤트
    document.getElementById("searchButton").addEventListener("click", () => {
        const searchText = document.getElementById("searchText").value.trim();
        fetchImages("all", "", searchText); // 검색어 기준으로 필터링
    });

    // 초기 로드 시 기본 설정
    window.onload = () => {
        // 모든 배너 숨기기
        document.querySelectorAll(".banner-category").forEach((banner) => {
            banner.style.display = "none";
        });

        // 선택된 기본 탭 설정 (예: 전체)
        const defaultCategory = ""; // 기본적으로 아무것도 선택하지 않음
        document.querySelector(`.tab[data-category="all"]`).classList.remove("clicked");
        document.getElementById("image-container").innerHTML = ""; // 초기엔 이미지도 비우기
    };
</script>
</body>
</html>