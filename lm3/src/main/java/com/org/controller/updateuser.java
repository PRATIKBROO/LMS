package com.org.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.userdao;
import com.org.dto.UserDTO;

@WebServlet("/update")
public class updateuser extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		int age = Integer.parseInt(req.getParameter("age"));
		String email = req.getParameter("email");
		long mobile = Long.parseLong(req.getParameter("mobile"));

/*		int id = Integer.parseInt(req.getParameter("id"));
*/		HttpSession session = req.getSession();
        int id=(int) session.getAttribute("id");

		UserDTO user = new UserDTO();

		user.setName(name);
		user.setAge(age);
		user.setEmail(email);
		user.setMobile(mobile);
		user.setId(id);

		
		userdao dao = new userdao();
		dao.updateUserById(id, user);

		System.out.println(user.getId());
		resp.sendRedirect("userdashboard.jsp");
	}
}
