<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<html>
<head>
<title>Course List</title>
<style type="text/css">
body {
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
	font-family: Arial, sans-serif;
	text-align: center;
	margin: 0;
	padding: 20px;
}

h2 {
	margin-bottom: 20px;
}

table {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
	background-color: black;
	border: 1px solid #ddd;
}

th, td {
	padding: 15px;
	text-align: left;
	border: 1px solid #ddd;
}

th {
	background-color: #333;
	color: white;
}

a {
	color: #007bff;
	text-decoration: none;
}

a:hover {
	
}

.navbar {
	overflow: hidden;
	background-color: rgba(7, 7, 9, 1);
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
	background-color: orange;
	color: black;
}
</style>
</head>
<body>
	<div class="navbar">
		<a href="userdashboard.jsp">DashBoard</a>
			<a href="usercourselist.jsp">All Courses</a>
			<a
			href="userenrolled_courses">Enrolled Courses</a>
			<a
			href="updateuser.jsp">Account Setting</a>
			<a
			href="<%=request.getContextPath()%>/logoutservlet">Log Out</a>
	</div>
	<h2>Available Courses</h2>
	<table>
		<tr>
			<th>Course Title</th>
			<th>Description</th>
			<th>Category</th>
			<th>View Course</th>
		</tr>
		<%
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lms";
			String dbUser = "root";
			String dbPassword = "root";
			con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
			stmt = con.createStatement();
			String sql = "SELECT id, title, description, category FROM courses";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				int courseId = rs.getInt("id");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String category = rs.getString("category");
		%>
		<tr>
			<td><%=title%></td>
			<td><%=description%></td>
			<td><%=category%></td>
			<td><a href="course_details.jsp?course_id=<%=courseId%>"
				class="btn  btn-md btn-primary">View Course</a></td>
		</tr>
		<%
		}
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		if (rs != null)
		rs.close();
		if (stmt != null)
		stmt.close();
		if (con != null)
		con.close();
		}
		%>
	</table>
</body>
<%-- <%@ include file="additional/footer.jsp"%>
 --%>
</html>
