package com.org.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.org.dto.admindto;

public class admindao {

	public void saveUser(admindto admin) {

		String name = admin.getName();

		String email = admin.getEmail();

		String password = admin.getPassword();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("insert into admin (name,email,password) values (?,?,?)");

			pst.setString(1, name);
			pst.setString(2, email);
			pst.setString(3, password);

			pst.executeUpdate();

			System.out.println("Done");
			con.close();

		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public admindto fetchUserById(int id) {
		admindto user = new admindto();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("select * from admin where id=?");
			pst.setInt(1, id);
			ResultSet rst = pst.executeQuery();

			while (rst.next()) {
				user.setName(rst.getString("name"));

				user.setEmail(rst.getString("email"));

				user.setPassword(rst.getString("password"));

				return user;
			}
			con.close();

		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public admindto fetchUserByUserAndPassword(String email, String password) {

		admindto user = new admindto();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("select * from admin where email=? and password =?");
			pst.setString(1, email);
			pst.setString(2, password);
			ResultSet rst = pst.executeQuery();
			if (rst.next()) {
				int id = rst.getInt("id");
				String name = rst.getString("name");
				String email1 = rst.getString("email");
				String password1 = rst.getString("password");

				user.setId(id);
				user.setName(name);
				user.setEmail(email1);
				user.setPassword(password1);

				return user;

			}

			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
}