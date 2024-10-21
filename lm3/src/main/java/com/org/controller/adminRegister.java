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

@WebServlet("/adregi")
public class adminRegister extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name =req.getParameter("name");
		String email =req.getParameter("email");
		String password =req.getParameter("password");

		admindto u = new admindto();
		u.setName(name);
		u.setEmail(email);
		u.setPassword(password);
		
		admindao dao =new admindao();
		dao.saveUser(u);
		
		HttpSession session =req.getSession();
		session.setAttribute("msg", "Registraion Successfull");
		resp.sendRedirect("adminregister.jsp");
		
	}
}
