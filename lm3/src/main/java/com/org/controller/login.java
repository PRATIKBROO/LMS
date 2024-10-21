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

@WebServlet("/log")
public class login extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		userdao dao = new userdao();
		UserDTO user1= dao.fetchUserByUserAndPassword(email,password);

		HttpSession session =req.getSession();

		if(user1!=null) {
		session.setAttribute("userobj", user1);
		session.setAttribute("id", user1.getId());  // Assuming 'user.getId()' returns the user's ID
		session.setAttribute("name", user1.getName());
		resp.sendRedirect("userdashboard.jsp");	
		}
		else {
		session.setAttribute("msg", "Invalid credential");
		resp.sendRedirect("login.jsp");
		}
	}
}
