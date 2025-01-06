package com.kh.admin.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.admin.model.dto.BlockMemberDTO;
import com.kh.admin.model.service.BlockService;

/**
 * Servlet implementation class ReleaseUserController
 */
@WebServlet("/admin/releaseUser")
public class ReleaseUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReleaseUserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		reader.close();
		
		Gson gson = new Gson();
		BlockMemberDTO[] users = gson.fromJson(sb.toString(), BlockMemberDTO[].class);
		
		BlockService service = new BlockService();
		boolean isSuccess = true;
		
		for(BlockMemberDTO user : users) {
			int result = service.releaseUser(user.getMember().getUserId());
			if(result <= 0) {
				isSuccess = false;
				break;
			}
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		JsonObject json = new JsonObject();
		json.addProperty("success", isSuccess);
		response.getWriter().write(json.toString());
		
	
	}

}





























