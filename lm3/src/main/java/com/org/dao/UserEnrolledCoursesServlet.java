package com.org.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dto.UserDTO;

@WebServlet("/userenrolled_courses")
public class UserEnrolledCoursesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the session and retrieve the user object
		HttpSession session = request.getSession(false);
		UserDTO user = (UserDTO) session.getAttribute("userobj");

		// Check if user is logged in
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Get userId from UserDTO object
		int userId = user.getId();

		// Database connection details
		String jdbcURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";

		List<Course> enrolledCourses = new ArrayList<>();

		// Database operation to fetch enrolled courses
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

			// SQL query with dynamic user_id
			String sql = "SELECT c.id, c.title, c.description, c.category " + "FROM enrollment e "
					+ "JOIN courses c ON e.course_id = c.id " + "WHERE e.user_id = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId); // Use the dynamic userId here
			ResultSet rs = pstmt.executeQuery();

			// Iterate through the result set and collect courses
			while (rs.next()) {
				Course course = new Course();
				course.setId(rs.getInt("id"));
				course.setTitle(rs.getString("title"));
				course.setDescription(rs.getString("description"));
				course.setCategory(rs.getString("category"));
				enrolledCourses.add(course);
			}
			con.close();

			// Debugging to see how many courses are retrieved
			System.out.println("Courses retrieved: " + enrolledCourses.size());
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		// Set the enrolled courses list as a request attribute
		request.setAttribute("enrolledCourses", enrolledCourses);

		// Forward the request to the JSP page

		request.getRequestDispatcher("userenrolled_courses.jsp").forward(request, response);
	}

	// A simple Course class to hold course information
	public static class Course {
		private int id;
		private String title;
		private String description;
		private String category;

		// Getters and Setters
		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}
	}
}
