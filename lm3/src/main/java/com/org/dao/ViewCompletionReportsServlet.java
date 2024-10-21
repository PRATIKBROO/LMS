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

@WebServlet("/ViewCompletionReportsServlet")
public class ViewCompletionReportsServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String courseId = request.getParameter("course_id");
		String dateFrom = request.getParameter("date_from");
		String dateTo = request.getParameter("date_to");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

			// Build the SQL query dynamically based on the filters provided
			StringBuilder sql = new StringBuilder(
					"SELECT c.course_id, c.title, COUNT(DISTINCT pt.user_id) AS completed_students " + "FROM courses c "
							+ "JOIN progress_tracking pt ON c.course_id = pt.course_id "
							+ "WHERE pt.is_completed = TRUE ");
			if (courseId != null && !courseId.isEmpty()) {
				sql.append("AND c.course_id = ? ");
			}
			if (dateFrom != null && !dateFrom.isEmpty()) {
				sql.append("AND pt.completion_date >= ? ");
			}
			if (dateTo != null && !dateTo.isEmpty()) {
				sql.append("AND pt.completion_date <= ? ");
			}
			sql.append("GROUP BY c.course_id, c.title");

			pstmt = con.prepareStatement(sql.toString());

			// Set the prepared statement parameters based on the filters
			int paramIndex = 1;
			if (courseId != null && !courseId.isEmpty()) {
				pstmt.setInt(paramIndex++, Integer.parseInt(courseId));
			}
			if (dateFrom != null && !dateFrom.isEmpty()) {
				pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateFrom));
			}
			if (dateTo != null && !dateTo.isEmpty()) {
				pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateTo));
			}

			rs = pstmt.executeQuery();
			con.close();
			// Forward the result set to the JSP for display
			request.setAttribute("resultSet", rs);
			request.getRequestDispatcher("viewCompletionReports.jsp").forward(request, response);

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ignore) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ignore) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ignore) {
				}
		}
	}
}
