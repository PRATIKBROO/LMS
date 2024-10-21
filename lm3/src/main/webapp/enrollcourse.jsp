<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>Enroll in Course</title>
</head>
<body>
	<h2>Enroll in Course</h2>
	<%
	int courseId = Integer.parseInt(request.getParameter("id"));
	String courseTitle = ""; // This can be fetched from the database

	// Display the course details
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String dbURL = "jdbc:mysql://localhost:3306/lms";
		String dbUser = "root";
		String dbPassword = "root";
		Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

		String sql = "SELECT title FROM courses WHERE id = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, courseId);
		ResultSet rs = pstmt.executeQuery();

		if (rs.next()) {
			courseTitle = rs.getString("title");
		}

		rs.close();
		pstmt.close();
		con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}

	out.println("<h3>Course Title: " + courseTitle + "</h3>");
	%>

	<form action="EnrollCourseServlet" method="post">
		<input type="hidden" name="course_id" value="<%=courseId%>">
		<button type="submit">Enroll Now</button>
	</form>
</body>
<%@ include file="additional/footer.jsp"%>

</html>
