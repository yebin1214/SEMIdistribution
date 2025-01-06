package com.kh.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.user.model.service.ReviewService;
import com.kh.user.model.vo.Review;
import com.kh.user.model.vo.Member;

@WebServlet("/review/create")
public class ReviewCreate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewCreate() {
        super();
    }

    // POST : 리뷰 작성 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1) 로그인된 유저 확인
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("alertMsg", "로그인 후 이용해주세요.");
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        // 2) 파라미터 추출
        int productNo = Integer.parseInt(request.getParameter("productNo"));
        String reviewContent = request.getParameter("reviewContent");
        int reviewScore = Integer.parseInt(request.getParameter("reviewScore"));

        // 3) 리뷰 객체 생성 및 기본값 설정
        Review review = Review.builder()
                .reviewWriter(loginUser.getUserNo()) // 로그인된 사용자 ID
                .productNo(productNo) // 상품 번호
                .reviewContent(reviewContent) // 리뷰 내용
                .reviewScore(reviewScore) // 별점
                .reviewStatus('N') // 기본값: 정상 상태
                .build();

        // 4) 서비스 호출
        ReviewService reviewService = new ReviewService();
        int result = reviewService.insertReview(review);

        // 5) 결과 처리
        if (result > 0) {
            session.setAttribute("alertMsg", "리뷰가 성공적으로 등록되었습니다.");
        } else {
            session.setAttribute("alertMsg", "리뷰 등록에 실패했습니다.");
        }

        // 상품 상세 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/product/detail?pno=" + productNo);
    }
}
