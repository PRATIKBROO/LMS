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

	@WebServlet("/TrackProgressServlet")
	public class trackprogress extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int userId = Integer.parseInt(request.getParameter("user_id"));
	        int lessonId = Integer.parseInt(request.getParameter("lesson_id"));

	        String dbURL = "jdbc:mysql://localhost:3306/learning_platform";
	        String dbUser = "root";
	        String dbPassword = "password";

	        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
	            String sql = "INSERT INTO progress_tracking (user_id, lesson_id, is_completed, completion_date) " +
	                         "VALUES (?, ?, TRUE, CURRENT_TIMESTAMP) " +
	                         "ON DUPLICATE KEY UPDATE is_completed = TRUE, completion_date = CURRENT_TIMESTAMP";
	            PreparedStatement pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, userId);
	            pstmt.setInt(2, lessonId);
	            pstmt.executeUpdate();
	            con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        response.sendRedirect("courseContent.jsp?course_id=" + request.getParameter("course_id"));
	    }
	}


