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

@WebServlet("/ViewCoursesServlet")
public class ViewCoursesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Fetch courses and forward to the JSP
		List<Course> courses = fetchCourses();

		// Store the courses list in the request
		request.setAttribute("courses", courses);

		// Forward the request to the JSP
		request.getRequestDispatcher("view_courses.jsp").forward(request, response);
	}

	// Method to fetch all courses from the database
	private List<Course> fetchCourses() {
		List<Course> courses = new ArrayList<>();

		String jdbcURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";

		String sql = "SELECT id, title, description, category FROM courses";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				// Create a new Course object for each row in the result set
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String category = rs.getString("category");

				courses.add(new Course(id, title, description, category));
			}
			con.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return courses;
	}

	// A simple model class to represent a Course
	public static class Course {
		private int id;
		private String title;
		private String description;
		private String category;

		public Course(int id, String title, String description, String category) {
			this.id = id;
			this.title = title;
			this.description = description;
			this.category = category;
		}

		// Getters for the fields
		public int getId() {
			return id;
		}

		public String getTitle() {
			return title;
		}

		public String getDescription() {
			return description;
		}

		public String getCategory() {
			return category;
		}
	}
}
