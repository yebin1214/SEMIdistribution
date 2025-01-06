<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/service.css"
	type="text/css">

</head>
<body>
    <div class="container">
        <!-- Sidebar Include -->        
        <div><%@ include file="/views/common/serviceSidebar.jsp"%></div>

        <div class="content">
            <!-- Header Include -->            
            <div><%@ include file="/views/common/serviceHeader.jsp"%></div>

            <div class="inquiry">
                <h2>1:1 문의</h2>
                
                <div class="write-button">
                    <a href="write.html">글 작성</a>
                </div>                
                
                <table>
                    <thead>
                        <tr>
                            <th width="20%">번호</th>
                            <th width="40%">제목</th>
                            <th width="20%">작성일</th>
                        </tr>
                    </thead>
                    <tbody id="inquiryTableBody">
                        <!-- 데이터가 동적으로 삽입될 부분 -->
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <a href="#">&lt;</a>
                <a href="#">1</a>
                <a href="#">&gt;</a>
            </div>
        </div>
    </div>

    <script>
        // Sidebar와 Header Include
        document.getElementById('sidebar').innerHTML = fetch('sidebar.html')
            .then(response => response.text())
            .then(data => document.getElementById('sidebar').innerHTML = data);

        document.getElementById('header').innerHTML = fetch('header.html')
            .then(response => response.text())
            .then(data => document.getElementById('header').innerHTML = data);

        // 데이터 동적 추가
        const inquiryData = [
            { id: 1, title: '문의합니다.', date: '2024.12.11' },
            { id: 2, title: '편의점 문의합니다.', date: '2024.12.12' },
            { id: 3, title: '상품 문의합니다.', date: '2024.12.13' }
        ];

        const tableBody = document.getElementById('inquiryTableBody');
        inquiryData.forEach(item => {
            const row = `<tr>
                <td>${item.id}</td>
                <td>${item.title} <span style='color: red;'>[1]</span></td>
                <td>${item.date}</td>
            </tr>`;
            tableBody.innerHTML += row;
        });
    </script>
</body>
</html>
