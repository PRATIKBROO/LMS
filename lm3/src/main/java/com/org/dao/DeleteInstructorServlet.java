package com.org.dao;

 
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.SQLException;

	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;

	@WebServlet("/deleteInstructorServlet")
	public class DeleteInstructorServlet extends HttpServlet {
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int instructorId = Integer.parseInt(request.getParameter("instructor_id"));

	        String dbURL = "jdbc:mysql://localhost:3306/lms";
	        String dbUser = "root";
	        String dbPassword = "root";

	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

	            String sql = "DELETE FROM admin WHERE id = ?";
	            PreparedStatement pstmt = con.prepareStatement(sql);
	            pstmt.setInt(1, instructorId);
	            pstmt.executeUpdate();

	            pstmt.close();
	            con.close();

	            response.sendRedirect("manageInstructors.jsp");
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.getWriter().println("Error deleting instructor: " + e.getMessage());
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	            response.getWriter().println("MySQL JDBC Driver not found.");
	        }
	    }
	}


