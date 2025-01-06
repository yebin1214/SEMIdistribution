package com.kh.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.user.model.service.ReviewService;
import com.kh.user.model.service.SaveListService;
import com.kh.user.model.vo.Member;
import com.kh.user.model.vo.Save;

/**
 * Servlet implementation class SaveDelete
 */
@WebServlet("/kart/delete")
public class SaveDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public SaveDelete() {
		super();
	}

	/**
	 * Handles GET requests.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/kart/savelist");
	}

	/**
	 * Handles POST requests for deleting an item from the save list.
	 */
	@Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 로그인 확인
        if (loginUser == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 요청 파라미터에서 reviewNo와 productNo 가져오기
            int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
            int productNo = Integer.parseInt(request.getParameter("productNo"));

            // 리뷰 삭제 로직 수행
            int result = new ReviewService().deleteReview(reviewNo);

            if (result > 0) {
                session.setAttribute("alertMsg", "리뷰가 성공적으로 삭제되었습니다.");
                response.sendRedirect(request.getContextPath() + "/product/detail?pno=" + productNo);
            } else {
                request.setAttribute("errorMsg", "리뷰 삭제에 실패했습니다.");
                request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "숫자 형식이 잘못되었습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "서버 오류가 발생했습니다.");
            request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
        }
    }
}