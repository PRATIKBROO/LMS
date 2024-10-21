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

@WebServlet("/deleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("user_id"));

		String dbURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";
		

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
			String sql = "DELETE FROM user WHERE id = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.executeUpdate();
            con.close();
			response.sendRedirect("manageUsers.jsp");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
