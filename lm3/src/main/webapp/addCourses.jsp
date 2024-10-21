<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.org.dto.admindto"%>
<%@ include file="additional/bootstrapCss.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Course</title>
<style type="text/css">
body {
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
}

.main {
	width: 100px;
	height: 100px;
	background-color: white;
	padding: 30px;
	margin: 20px;
}

.box {
	height: auto;
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: x-large;
	font-weight: 600;
	/* background-image: radial-gradient(rgb(14, 15, 15),rgb(253, 160, 10)); */
	flex-wrap: wrap;
	gap: 20px;
	padding: 20px 0px 20px 0px;
}

body {
	color: orange;
}

h1 {
	text-align: center;
}

.main {
	width: 100%;
	height: 500px;
	background-color: rgba(49, 103, 103, 1);
	display: flex;
	justify-content: center;
	align-items: center;
}

h2 {
	text-align: center;
}

input {
	margin: 15px;
	margin-left: 50px;
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
	session.setAttribute("id", user1.getId()); // Assuming `user.getId()` gets the instructor's ID
	%>
	<h2>Create a New Course</h2>
	<div class="main">
		<form action="CreateCourseServlet?id=<%user1.getId();%>" method="post">
			<label>Course Title:</label> <input type="text" name="title" required><br>

			<label>Course Description:</label>
			<textarea name="description" required></textarea>
			<br> <label>Category:</label> <input type="text" name="category"><br>


			<button type="submit">Create Course</button>
		</form>
	</div>
	<%@ include file="additional/footer.jsp"%>

</body>
</html>
