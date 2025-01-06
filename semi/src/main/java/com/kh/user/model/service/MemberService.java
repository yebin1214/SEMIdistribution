package com.kh.user.model.service;
import static com.kh.common.template.JDBCTemplate.*;

import java.sql.Connection;

import com.kh.user.model.dao.MemberDao;
import com.kh.user.model.vo.Member;



public class MemberService {
	MemberDao dao = new MemberDao();

	public Member login(String userId, String userPwd) {
		// dao가 database에 접속할수 있도록 Connection생성하기		
		Connection conn = getConnection();
		
		// dao에게 connection과 id,pwd를 전달하여 로그인 기능 수행
		Member m = dao.login(conn, userId, userPwd);
		
		close(conn);
		
		return m;		
	}

}
