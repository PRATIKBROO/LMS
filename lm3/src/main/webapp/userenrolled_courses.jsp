<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.org.dao.UserEnrolledCoursesServlet.Course"%>
<%@ page import="java.util.List"%>
<%@page import="com.org.dto.UserDTO"%><%@page
	import="com.org.controller.ViewCourseContentServlet"%>

<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Enrolled Courses</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
	text-align: center;
}

.container {
	width: 80%;
	margin: 20px auto;
	padding: 20px;
	background-color: rgba(49, 103, 103, 1);
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: left;
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
	text-decoration: underline;
}

.navbar {
	overflow: hidden;
	background-color: rgba(2, 0, 36, 1);
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
	<%

	%>
	<div class="container">
		<div class="navbar">
			<a href="userdashboard.jsp">Home</a> <a href="usercourselist.jsp">All
				Courses</a> <a href="updateuser.jsp">Account Setting</a> <a
				href="<%=request.getContextPath()%>/logoutservlet">Log Out</a>
		</div>
		<h2>Your Enrolled Courses</h2>

		<%
		// Retrieve the user from the session
		UserDTO user = (UserDTO) session.getAttribute("userobj");
		if (user == null) {
			// Redirect to login page if the user is not logged in
			response.sendRedirect("login.jsp");
			return;
		}
		session.setAttribute("user_id", user.getId()) ;
		// Retrieve the list of enrolled courses from the request attribute
		@SuppressWarnings("unchecked")
		List<Course> enrolledCourses = (List<Course>) request.getAttribute("enrolledCourses");

		if (enrolledCourses != null && !enrolledCourses.isEmpty()) {
		%>

		<table>
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Category</th>
					<th>Details</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Course course : enrolledCourses) {
				%>
				<tr>
					<td><%=course.getTitle()%></td>
					<td><%=course.getDescription()%></td>
					<td><%=course.getCategory()%></td>
					<td><a href="viewCourseContent?course_id=<%=course.getId()%>">View</a></td>

				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<%
		} else {
		%>
		<p>You are not enrolled in any courses.</p>
		<%
		}
		%>
	</div>

</body>
</html>
