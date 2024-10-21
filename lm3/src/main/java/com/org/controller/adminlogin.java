package com.org.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.admindao;
import com.org.dto.admindto;

@WebServlet("/adlog")
public class adminlogin extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		admindao dao = new admindao();
		admindto user1= dao.fetchUserByUserAndPassword(email,password);

		HttpSession session =req.getSession();

		if(user1!=null) {
		session.setAttribute("userobj", user1);
		resp.sendRedirect("admin_dashboard.jsp");	
		}
		else {
		session.setAttribute("msg", "Invalid credential");
		resp.sendRedirect("adminlogin.jsp");
		}
	}
}
