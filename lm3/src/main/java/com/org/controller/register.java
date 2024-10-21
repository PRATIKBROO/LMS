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

@WebServlet("/regi")
public class register extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name =req.getParameter("name");
		int age =Integer.parseInt(req.getParameter("age"));
		String email =req.getParameter("email");
		long mobile =Long.parseLong( req.getParameter("mob"));
		String password =req.getParameter("password");

		UserDTO u = new UserDTO();
		u.setName(name);
		u.setAge(age);
		u.setEmail(email);
		u.setMobile(mobile);
		u.setPassword(password);
		
		userdao dao =new userdao();
		dao.saveUser(u);
		
		HttpSession session =req.getSession();
		session.setAttribute("msg", "Registraion Successfull");
		resp.sendRedirect("register.jsp");
		
	}
}
