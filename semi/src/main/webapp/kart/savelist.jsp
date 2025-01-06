<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kh.user.model.vo.Save"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>찜 목록</title>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/resources/css/review.css" />
  <style>
        /* 화면 전체 흰색 배경 설정 */
        html, body {
            background-color: white; /* 전체 배경을 흰색으로 설정 */
            margin: 0;
            padding: 0;
            height: 100%; /* 화면 전체를 채우도록 설정 */
            font-family: Arial, sans-serif;
        }

        /* 콘텐츠 중앙 정렬 */
        .container {
            max-width: 800px;
            margin: auto;
            padding: 30px;
        }

        /* 찜 목록 제목 */
        .title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        /* 상품 리스트 */
        .product-list {
            list-style-type: none;
            padding: 0;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .product-item img {
            width: 120px;
            height: 120px;
            border-radius: 8px;
            margin-right: 20px;
            object-fit: cover;
        }

        .product-item .details {
            flex-grow: 1;
        }

        .product-item .details p {
            margin: 0 0 5px;
        }

        .product-item .details .product-name {
            font-weight: bold;
            font-size: 18px;
        }

        .product-item .details .product-price {
            color: gray;
            font-size: 16px;
        }

        .button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .button:hover {
            background-color: #e60000;
        }

        .actions {
            text-align: center;
            margin-top: 20px;
        }

        .actions .action-button {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }

        .actions .action-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.kh.user.model.vo.Save"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>찜 목록</title>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/resources/css/review.css" />
</head>
<body>
	<h1>찜 목록</h1>
	<%
        // 서버에서 전달된 saveList 객체 가져오기
        List<Save> saveList = (List<Save>) request.getAttribute("saveList");

        if (saveList != null && !saveList.isEmpty()) {
    %>
    <div style="background-color: white; padding: 20px;">
	<ul>
		<% 
            for (Save item : saveList) { 
        %>
		<li><img src="<%= item.getProductImage() %>" alt="상품 이미지"
			style="width: 100px; height: 100px;"margin-botoom : 50px;>
		<%-- 	     <!-- 상품 이름 -->
       		 <p class="product-name"><%= item.getProductName() %></p> --%>
        
      <%--   <!-- 상품 가격 -->
        	<p class="product-price"><%= item.getProductPrice() %>원</p> --%>
			
			 <form action="<%= request.getContextPath() %>/kart/delete" method="post">
            <input type="hidden" name="productNo" value="<%= item.getProductNo() %>" />
            <button type="submit" class="delete-button">삭제</button>
        </form>
			</li>
			
			
		<% 
            } 
        %>
        
	</ul>
	<%
        } else {
    %>
	<p>찜 목록이 비어 있습니다.</p>
	<%
        }
    %>
    <form action="<%= request.getContextPath() %>/kart/delete"
				method="post" style="display: inline;">
				<button type="submit">전체 삭제</button>
			</form>
	<button style = "margin-top :100px;"
		onclick="window.location.href='<%= request.getContextPath() %>/views/store/cu.jsp';">
		상품목록으로 이동</button>
		</div>
		
</body>