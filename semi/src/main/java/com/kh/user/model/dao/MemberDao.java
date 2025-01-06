package com.kh.user.model.dao;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.user.model.vo.Member;

import static com.kh.common.template.JDBCTemplate.*;

public class MemberDao {

	private Properties prop = new Properties();

	public MemberDao() {
		try {
			// XML 파일 경로 설정
			String fileName = MemberDao.class.getResource("/sql/member/member-mapper.xml").getPath();
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Member login(Connection conn, String userId, String userPwd) {
		Member m = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("login");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				m = Member.builder().userNo(rset.getInt("USER_NO")) // INTEGER → int
						.userId(rset.getString("USER_ID")) // VARCHAR → String
						.userPwd(rset.getString("USER_PWD")) // VARCHAR → String
						.email(rset.getString("EMAIL")) // VARCHAR → String
						.enrollDate(rset.getDate("ENROLL_DATE")) // DATE → java.sql.Date
						.memberStatus(rset.getString("MEMBER_STATUS")) // VARCHAR → String
						.build();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return m;
	}
}
