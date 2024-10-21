<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.org.dto.admindto"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
}

.main {
	/* height: 600px;
	width: 1450px; */
	height: 100vh;
	width: 100%;
	font-size: x-large;
	font-weight: 600;
	background-image: linear-gradient(111.4deg, rgba(7, 7, 9, 1) 6.5%,
		rgba(27, 24, 113, 1) 93.2%);
	padding: 20px 0px 20px 0px;
}

li {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 10px;
}

a:hover {
	color: green;
}

body {
	color: orange;
}

h2 {
	text-align: center;
}

a {
	color: orange;
	text-decoration: none;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 10px;
}
</style>
</head>
<body>

	<%
	admindto user1 = (admindto) session.getAttribute("userobj");
	if (user1 == null) {
		response.sendRedirect("adminlogin.jsp");
	} else {
	%>
	<%-- 	<%@ include file="additional/home_nav.jsp"%>
 --%>
	<h2>Welcome <%=user1.getName() %>!!</h2>
	<div class="main">
		


			<a href="manageUsers.jsp" class="bi bi-arrow-right-square-fill">Manage
				Users</a>
			<a href="manageInstructors.jsp" >Manage Instructors</a>
			<a href="addCourses.jsp" class="bi bi-bag-plus-fill">Add Course</a>
			<a href="manageCouses.jsp">Manage Courses</a>
			<a href="manageMaterials.jsp">Manage Learning Materials</a>
			<a href="viewEnrollmentReports.jsp">View Enrollment Reports</a>
			<!-- <a href="viewCompletionReports.jsp">View Course Completion
				Reports</a> -->
			<a href="AdminLogoutServlet">Logout</a>


		
	</div>
	<%
	}
	%>


	<%@ include file="additional/footer.jsp"%>

</body>
</html>