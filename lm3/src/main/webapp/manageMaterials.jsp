<%@ page import="java.sql.*"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<html>
<head>
<title>Manage Learning Materials</title>
<style type="text/css">
body {
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
}

h2 {
	text-align: center;
}

table {
	width: 80%;
	margin: auto;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid white;
}

th, td {
	padding: 10px;
	text-align: center;
}

a {
	color: green;
}

.navbar {
	overflow: hidden;
	background-color: #333;
	margin-bottom: 20px;
}

.navbar a {
	float: left;
	font-size: 16px;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 20px;
	text-decoration: none;
}

.navbar a:hover {
	background-color: #ddd;
	color: black;
}
</style>
</head>
<body>
	<div class="navbar">
		<a href="admin_dashboard.jsp">Dashboard</a> <a href="manageUsers.jsp">Manage
			Users</a> <a href="manageInstructors.jsp">Manage Instructors</a> <a
			href="manageCouses.jsp">Manage Courses</a> <a
			href="AdminLogoutServlet">Logout</a>
	</div>
	<h2>Manage Learning Materials</h2>
	<a href="uploadMaterial.jsp" class="btn btn-primary">Upload New
		Material</a>
	<br>
	<br>
	<table>
		<tr>
			<th>Material ID</th>
			<th>Course ID</th>
			<th>File Name</th>
			<th>File Type</th>
			<th>Uploaded At</th>
			<th>Actions</th>
		</tr>
		<%
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

			// Fetch all materials from the learning_materials table
			String sql = "SELECT material_id, course_id, file_name, file_type, uploaded_at FROM learning_materials";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int materialId = rs.getInt("material_id");
				int courseId = rs.getInt("course_id");
				String fileName = rs.getString("file_name");
				String fileType = rs.getString("file_type");
				Timestamp uploadedAt = rs.getTimestamp("uploaded_at");
		%>
		<tr>
			<td><%=materialId%></td>
			<td><%=courseId%></td>
			<td><%=fileName%></td>
			<td><%=fileType%></td>
			<td><%=uploadedAt%></td>
			<td><a
				href="deleteMaterialServlet?material_id=<%=materialId%>">Delete</a>
			</td>
		</tr>
		<%
		}
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
		%>
	</table>
</body>
</html>
