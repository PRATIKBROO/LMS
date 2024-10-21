<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="com.org.dto.UserDTO"%>


<%
// Get the course ID from the request parameter
int courseId = Integer.parseInt(request.getParameter("course_id"));
int id = (Integer)session.getAttribute("id");
UserDTO user= (UserDTO) session.getAttribute("userobj");
session.setAttribute("user_id", user.getId());
/* session.setAttribute("user_id");*/
 // Database connection details
String jdbcURL = "jdbc:mysql://localhost:3306/lms";
String dbUser = "root";
String dbPassword = "root";
String sql = "SELECT * FROM courses WHERE id = ?";

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, courseId);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		String title = rs.getString("title");
		String description = rs.getString("description");
		String category = rs.getString("category");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Course Details</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
	padding: 20px;
	text-align: center;
}

h2 {
	color: white;
	margin-bottom: 20px;
}

.course-details {
	background-color: #222;
	padding: 20px;
	border-radius: 8px;
	display: inline-block;
	text-align: left;
	color: #fff;
}

.course-details p {
	margin: 10px 0;
}

a, button {
	color: white;
	text-decoration: none;
	background-color: #007bff;
	padding: 10px 15px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
}

a:hover, button:hover {
	background-color: #0056b3;
}

.btn-back {
	background-color: #6c757d;
}

.btn-back:hover {
	background-color: #5a6268;
}
</style>
</head>
<body>

	<h2>Course Details</h2>
	<div class="course-details">
		<p>
			<strong>Title:</strong>
			<%=title%></p>
		<p>
			<strong>Description:</strong>
			<%=description%></p>
		<p>
			<strong>Category:</strong>
			<%=category%></p>
	</div>

	<br />
	<br />

	<!-- Enroll Button -->
	<form action="EnrollServlet" method="post">
		<input type="hidden" name="course_id" value="<%=courseId%>">
		<button type="submit">Enroll in Course</button>
	</form>

	<br />
	<br />

	<!-- Back to Courses Button -->
	<a href="usercourselist.jsp" class="btn-back">Back to Courses</a>

</body>
	<%@ include file="additional/footer.jsp"%>

</html>

<%
} else {
out.println("Course not found.");
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
