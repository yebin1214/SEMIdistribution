<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>찜목록</title>
    
    <!-- 외부 CSS 파일 연결 (리뷰 스타일) -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/review.css" />
    
    <!-- 메뉴바 JSP 파일 포함 -->
    <%@ include file="/views/common/menubar.jsp"%>

    <!-- 별점 스타일링 -->
    <style>
        .rating {
            color: gold; /* 별점 색상 설정 */
            font-size: 16px; /* 별점 크기 설정 */
        }
    </style>
</head>
<body>
    <!-- 상품 이미지 및 로딩 상태 표시 -->
    <div id="img-container">
        <p id="loading" class="loading">이미지를 불러오는 중...</p> <!-- 이미지 로딩 중 메시지 -->
        <img id="product-image" alt="상품 이미지" style="display: none;" /> <!-- 이미지 요소, 처음에는 보이지 않음 -->
        <p id="error-message" class="error" style="display: none"></p> <!-- 오류 메시지 -->
    </div>

    <!-- 삭제 버튼 및 뒤로가기 버튼 -->
    <div class="button-container">
        <!-- 찜 목록에서 상품을 삭제하는 폼 -->
        <form action="<%= request.getContextPath() %>/kart/saveDelete" method="post">
            <!-- 상품 번호를 hidden 필드로 전달 -->
            <input type="hidden" name="productNo" id="productNo" value="1" />
            <!-- 찜 목록에서 삭제 버튼 -->
            <button type="submit" style="width: 150px; background: #d0c1e3; color: white;">찜 목록에서 삭제</button>
        </form>

        <!-- 뒤로가기 버튼, 마이페이지로 이동 -->
        <button id="backButton" style="width: 150px; background: #d0c1e3; color: white;">뒤로가기</button>
    </div>

    <script>
        // 1번 상품 API 경로 설정 (상품 이미지 API 호출)
        const apiUrl = "http://localhost:3000/api/images/1";  // 1번 상품 API 경로

        // DOM 요소 가져오기
        const loadingElement = document.getElementById("loading");  // 로딩 메시지 요소
        const productImageElement = document.getElementById("product-image");  // 상품 이미지 요소
        const errorMessageElement = document.getElementById("error-message");  // 오류 메시지 요소

        // API 호출 및 이미지 출력
        let productData = null; // 상품 데이터를 저장할 변수

        // API 호출 (fetch)
        fetch(apiUrl)
            .then((response) => response.json()) // JSON 데이터로 응답 받기
            .then((data) => {
                // 로딩 메시지 숨기기
                loadingElement.style.display = "none";

                // 상품 데이터가 존재하고, 이미지 URL이 있을 경우
                if (data.success && data.image) {
                    productData = data.image; // 상품 데이터 저장

                    // 이미지 표시
                    productImageElement.src = productData.url;  // 이미지 URL 설정
                    productImageElement.style.display = "block";  // 이미지 보이기

                } else {
                    // 데이터가 없을 경우 오류 메시지 표시
                    errorMessageElement.textContent = "이미지를 불러올 수 없습니다.";
                    errorMessageElement.style.display = "block";
                }
            })
            .catch((error) => {
                // 오류 발생 시 처리 (API 호출 실패)
                console.error("API 호출 오류:", error);
                loadingElement.style.display = "none";  // 로딩 메시지 숨기기
                errorMessageElement.textContent = "데이터를 불러오는 중 문제가 발생했습니다.";  // 오류 메시지
                errorMessageElement.style.display = "block";  // 오류 메시지 표시
            });

        // 뒤로가기 버튼 클릭 시 마이페이지로 이동
        document.getElementById("backButton").addEventListener("click", () => {
            window.location.href = "<%= request.getContextPath() %>/views/userPage/member/mypage.jsp";  // 마이페이지로 이동
        });
    </script>
</body>
</html>
