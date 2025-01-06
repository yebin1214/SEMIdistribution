package com.kh.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.product.model.service.ProductService;
import com.kh.product.model.vo.Product;
import com.kh.user.model.service.ReviewService;
import com.kh.user.model.vo.Review;

@WebServlet("/product/detail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductDetailServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            String pnoParam = request.getParameter("pno");

           
            if (pnoParam == null || pnoParam.trim().isEmpty()) {
                redirectToErrorPage(request, response, "상품 번호가 유효하지 않습니다.");
                return;
            }

            int productNo;
            try {
                productNo = Integer.parseInt(pnoParam);
            } catch (NumberFormatException e) {
                redirectToErrorPage(request, response, "상품 번호가 숫자가 아닙니다.");
                return;
            }

            // 상품 정보 가져오기
            ProductService productService = new ProductService();
            Product product = productService.getProductById(productNo);

            // 상품이 존재하지 않을 경우
            if (product == null) {
                redirectToErrorPage(request, response, "해당 상품을 찾을 수 없습니다.");
                return;
            }

            // 리뷰 리스트 가져오기
            ReviewService reviewService = new ReviewService();
            List<Review> reviewList = reviewService.selectReviewList(productNo);

            // JSP로 데이터 전달
            request.setAttribute("product", product);
            request.setAttribute("reviewList", reviewList);

            // JSP로 포워딩
            request.getRequestDispatcher("/views/product/product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            redirectToErrorPage(request, response, "알 수 없는 에러가 발생했습니다.");
        }
    }

    /**
     * 에러 페이지로 리다이렉트하는 유틸리티 메서드
     */
    private void redirectToErrorPage(HttpServletRequest request, HttpServletResponse response, String errorMsg)
            throws ServletException, IOException {
        request.setAttribute("errorMsg", errorMsg);
        request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
    }
   

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}