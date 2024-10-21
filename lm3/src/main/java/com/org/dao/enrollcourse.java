package com.org.dao;

	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.SQLException;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.servlet.http.HttpSession;

	@WebServlet("/EnrollServlet")
	public class enrollcourse extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int courseId = Integer.parseInt(request.getParameter("course_id"));
	        HttpSession session = request.getSession();
	        int userId = (Integer) session.getAttribute("user_id");

	        String dbURL = "jdbc:mysql://localhost:3306/lms";
	        String dbUser = "root";
	        String dbPassword = "root";

	        try {
	        	Class.forName("com.mysql.cj.jdbc.Driver");
	        	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
	            String sql = "INSERT INTO enrollment (user_id, course_id) VALUES (?, ?)";
	            PreparedStatement pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, userId);
	            pstmt.setInt(2, courseId);
	            pstmt.executeUpdate();
	            System.out.println("done");
	            con.close();
				
				 
				 	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	        response.sendRedirect("userdashboard.jsp");
			/*
			 * response.sendRedirect("course_details.jsp?course_id=" + courseId);
			 */	    }
	}


