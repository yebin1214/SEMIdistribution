package com.kh.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.user.model.service.MemberService;
import com.kh.user.model.vo.Member;




@WebServlet("/member/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

    // GET : 로그인 페이지로 이동
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // views/userPage/member/login.jsp 로 포워딩
        request.getRequestDispatcher("/views/userPage/member/login.jsp").forward(request, response);
    }

    // POST : 로그인 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1) 파라미터 추출
        String userId = request.getParameter("userId");
        String userPwd = request.getParameter("password");

        // 2) 서비스 호출(실제 DB 조회)
        MemberService service = new MemberService();
        Member m = service.login(userId, userPwd); // 성공 시 Member 객체, 실패 시 null

        // 3) 로그인 결과 처리
        if (m == null) {
            // 로그인 실패 -> 다시 로그인 페이지로 이동(Forward)
            request.setAttribute("errorMsg", "로그인 실패! 아이디/비밀번호를 확인하세요.");
            request.getRequestDispatcher("/views/userPage/member/login.jsp").forward(request, response);
            
        } else {
            // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", m);
            session.setAttribute("alertMsg", "로그인 성공!");

            // 메인 페이지(또는 원하는 경로)로 이동 (Redirect)
            // 사용자 번호(user_no)에 따라 페이지 이동
            int userNo = m.getUserNo(); // Member 객체에서 userNo를 가져옴
            if (userNo >= 1 && userNo <= 5) {
                // 특정 번호 범위에 해당하는 사용자를 이동
                response.sendRedirect(request.getContextPath() + "/views/adminPage/admin/MainPage.jsp");
            } else {
                // 일반 사용자는 메인 페이지로 이동
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }
}
