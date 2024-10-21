package com.org.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.org.dto.UserDTO;

public class userdao {
	public void saveUser(UserDTO user) {

		String name = user.getName();
		int age = user.getAge();
		String email = user.getEmail();
		long mobile = user.getMobile();
		String password = user.getPassword();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con
					.prepareStatement("insert into user (name,age,email,mobile,password) values (?,?,?,?,?)");

			pst.setString(1, name);
			pst.setInt(2, age);
			pst.setString(3, email);
			pst.setLong(4, mobile);
			pst.setString(5, password);

			pst.executeUpdate();

			System.out.println("Done");
			con.close();

		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public UserDTO fetchUserById(int id) {
		UserDTO user = new UserDTO();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("select * from user where id=?");
			pst.setInt(1, id);
			ResultSet rst = pst.executeQuery();

			while (rst.next()) {
				user.setName(rst.getString("name"));
				user.setAge(rst.getInt("age"));
				user.setEmail(rst.getString("email"));
				user.setMobile(rst.getLong("mobile"));
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

	public List<UserDTO> fetchAllUsers() {
		List<UserDTO> userlist = new ArrayList();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("select * from user");
			ResultSet rst = pst.executeQuery();
			while (rst.next()) {
				UserDTO user = new UserDTO();
				user.setId(rst.getInt("id"));
				user.setName(rst.getString("name"));
				user.setAge(rst.getInt("age"));
				user.setEmail(rst.getString("email"));
				user.setMobile(rst.getLong("mobile"));
				user.setPassword(rst.getString("password"));

				userlist.add(user);

			}
			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userlist;
	}

	public void updateUserById(int id, UserDTO user) {
		UserDTO user1 = fetchUserById(id);
		if (user1 != null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
				PreparedStatement pst = con
						.prepareStatement("UPDATE user SET name=?, age=?, email=?, mobile=? WHERE id=?");
				pst.setString(1, user.getName());
				pst.setInt(2, user.getAge());
				pst.setString(3, user.getEmail());
				pst.setLong(4, user.getMobile());
				pst.setInt(5, id);

				pst.executeUpdate();
				System.out.println(user.getId());

				con.close();

			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public void deleteUserById(int id) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("delete from user where id =?");
			pst.setInt(1, id);

			pst.executeUpdate();
			con.close();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public UserDTO fetchUserByUserAndPassword(String email, String password) {

		UserDTO user = new UserDTO();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
			PreparedStatement pst = con.prepareStatement("select * from user where email=? and password =?");
			pst.setString(1, email);
			pst.setString(2, password);
			ResultSet rst = pst.executeQuery();
			if (rst.next()) {
				int id = rst.getInt("id");
				String name = rst.getString("name");
				int age = rst.getInt("age");
				String email1 = rst.getString("email");
				long mobile = rst.getLong("mobile");
				String password1 = rst.getString("password");

				user.setId(id);
				user.setName(name);
				user.setAge(age);
				user.setEmail(email1);
				user.setMobile(mobile);
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
