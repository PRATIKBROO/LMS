package com.org.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateCourseServlet")
public class CreateCourse extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve form data from the request
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
		/*
		 * Integer instructorId =Integer.parseInt(request.getParameter("id")) ;
		 */

        // Get the logged-in instructor's ID from the session
        HttpSession session = request.getSession();
		
		
		  Integer instructorId = (Integer) session.getAttribute("id"); // Ensure
		 		System.out.println(instructorId);
		  /*
			 * session contains `id`
			 */		 
        if (instructorId == null) {
            // If the instructor ID is not found in the session, return an error
            response.getWriter().write("Error: Instructor not logged in.");
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/lms";
        String dbUser = "root";
        String dbPassword = "root";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
        	
        	Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish database connection
            con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Step 1: Check if the instructor exists in the admin table
            String checkInstructorSQL = "SELECT id FROM admin WHERE id = ?";
            pstmt = con.prepareStatement(checkInstructorSQL);
            pstmt.setInt(1, instructorId);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                // If the instructor does not exist, show error
                response.getWriter().write("Error: Instructor with ID " + instructorId + " does not exist.");
                return;
            }

            // Step 2: Insert the course if the instructor exists
            String sql = "INSERT INTO courses (title, description, category, instructer_id) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, category);
            pstmt.setInt(4, instructorId);

            // Execute the insert
            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to the instructor's dashboard or success page
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                response.getWriter().write("Error: Unable to add course.");
            }
			con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (con != null) try { con.close(); } catch (SQLException ignore) {}
        }
    }
}




