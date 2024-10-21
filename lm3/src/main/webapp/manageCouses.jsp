<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.org.dto.admindto"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ page import="java.sql.*"%>
<head>
<title>Manage Courses</title>
<style type="text/css">
body {
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
	text-align: center;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid white;
}

th, td {
	padding: 10px;
	text-align: center;
}


/* Navigation bar */
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
		<a href="admin_dashboard.jsp">Dashboard</a> 
		<a href="manageUsers.jsp">Manage Users</a> 
		<a href="manageInstructors.jsp">Manage Instructors</a> 
		<a href="manageCouses.jsp">Manage Courses</a> 
		<a href="AdminLogoutServlet">Logout</a>
	</div>
	<%
	admindto user1 = (admindto) session.getAttribute("userobj");
	int id = user1.getId();
	%>
	<h2>Manage Courses</h2>
	<table border="1">
		<tr>
			<th>Course ID</th>
			<th>Title</th>
			<th>Description</th>
			<th>Instructor ID</th>
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
			String sql = "SELECT id, title, description, instructer_id FROM courses WHERE id=" + id;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int courseId = rs.getInt("id");
				String title = rs.getString("title");
				String description = rs.getString("description");
								int instructorId = rs.getInt("instructer_id");
		%>
		<tr>
			<td><%=courseId%></td>
			<td><%=title%></td>
			<td><%=description%></td>
 			<td><%=instructorId%></td>
 
<%-- 			<a href="editCourse.jsp?course_id=<%=courseId%>" class="btn btn-md btn-primary">Edit</a> |
 --%>				<td><a href="deleteCourseServlet?course_id=<%=courseId%>"  class="btn btn-md btn-danger">Delete</a></td>
		</tr>
		<%
		}
		} catch (SQLException e) {
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