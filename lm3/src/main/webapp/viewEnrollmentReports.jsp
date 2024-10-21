<%@ page import="java.util.List"%>
<%@ page import="com.org.dto.EnrollmentReport"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<html>
<head>
<title>View Enrollment Reports</title>
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
	<div class="navbar">
		<a href="admin_dashboard.jsp">Dashboard</a> <a href="manageUsers.jsp">Manage
			Users</a> <a href="manageInstructors.jsp">Manage Instructors</a> <a
			href="manageCouses.jsp">Manage Courses</a> <a
			href="AdminLogoutServlet">Logout</a>
	</div>
	<h2>Enrollment Reports</h2>

	<!-- Filter Form -->
	<form action="ViewEnrollmentReportsServlet" method="get">
		<label for="course_id">Course ID:</label> <input type="text"
			name="course_id" id="course_id"> <label for="date_from">From
			Date:</label> <input type="date" name="date_from" id="date_from"> <label
			for="date_to">To Date:</label> <input type="date" name="date_to"
			id="date_to">

		<button type="submit">Filter</button>
	</form>

	<!-- Enrollment Table -->
	<table>
		<tr>
			<th>Course ID</th>
			<th>Course Title</th>
			<th>Total Enrollments</th>
		</tr>
		<%
		@SuppressWarnings("unchecked")
		List<EnrollmentReport> reportList = (List<EnrollmentReport>) request.getAttribute("reportList");
		if (reportList != null && !reportList.isEmpty()) {
			for (EnrollmentReport report : reportList) {
		%>
		<tr>
			<td><%=report.getCourseId()%></td>
			<td><%=report.getCourseTitle()%></td>
			<td><%=report.getTotalEnrollments()%></td>
		</tr>
		<%
		}
		} else {
		%>
		<tr>
			<td colspan="3">No enrollment data available</td>
		</tr>
		<%
		}
		%>
	</table>
</body>
<%@ include file="additional/footer.jsp"%>
</html>
