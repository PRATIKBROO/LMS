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

@WebServlet("/deleteMaterialServlet")
public class DeleteMaterialServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int materialId = Integer.parseInt(request.getParameter("material_id"));

		String dbURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
			// Delete the material from the database
			String sql = "DELETE FROM learning_materials WHERE material_id = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, materialId);
			pstmt.executeUpdate();
			con.close();

			// Redirect back to the manage materials page
			response.sendRedirect("manageMaterials.jsp");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
