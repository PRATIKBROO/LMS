package com.org.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLogoutServlet")
	public class AdminLogoutServlet extends HttpServlet {
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Invalidate the session to log the user out
	    	HttpSession session = request.getSession();
	 	   session.removeAttribute("userobj");
	 	   session.invalidate();

	        // Redirect the user to the login page (or home page)
	        response.sendRedirect("adminlogin.jsp");
	    }
	}


