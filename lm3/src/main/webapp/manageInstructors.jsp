<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Instructors</title>
<style type="text/css">
/* CSS styles for the page */
body {
	background-color: #f2f2f2;
	font-family: Arial, sans-serif;
	color: #333;
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
}

h2 {
	text-align: center;
	margin-top: 20px;
}

table {
	margin: auto;
	width: 80%;
	border-collapse: collapse;
	margin-bottom: 50px;
}

.table, .card-body {
	background-color: rgba(49, 103, 103, 1);
	color: orange;
}

table, th, td {
	border: 1px solid #aaa;
}

th, td {
	padding: 12px;
	text-align: left;
}

th {
	background-color: #ddd;
}

a {
	color: #007BFF;
	text-decoration: none;
	margin-right: 10px;
}

a:hover {
	text-decoration: underline;
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

/* Footer */
.footer {
	left: 0;
	bottom: 0;
	width: 100%;
	background-color: #333;
	color: white;
	text-align: center;
	padding: 10px 0;
}
</style>
</head>
<body>
	<!-- Navigation Bar -->
	<div class="navbar">
		<a href="admin_dashboard.jsp">Dashboard</a> 
		<a href="manageUsers.jsp">Manage Users</a> 
		<a href="manageInstructors.jsp">Manage Instructors</a> 
		<a href="manageCouses.jsp">Manage Courses</a> 
		<a href="AdminLogoutServlet">Logout</a>
	</div>

	<h2>Manage Instructors</h2>

	<div class="container-fluid p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-1 text-center">Instructor Details</p>

						<!-- Table structure outside the loop -->
						<table class="table">
							<thead>
								<tr>
									<th>Instructor ID</th>
									<th>Name</th>
									<th>Email</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
							<%
							Connection con = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;

							String dbURL = "jdbc:mysql://localhost:3306/lms";
							String dbUser = "root";
							String dbPassword = "root";

							try {
								// Load MySQL JDBC Driver
								Class.forName("com.mysql.cj.jdbc.Driver");

								// Establish the connection
								con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

								// SQL query to fetch instructors
								String sql = "SELECT id, name, email FROM admin";
								pstmt = con.prepareStatement(sql);
								rs = pstmt.executeQuery();

								// Iterate through the result set and generate rows
								while (rs.next()) {
									int instructorId = rs.getInt("id");
									String name = rs.getString("name");
									String email = rs.getString("email");
							%>
								<tr>
									<td><%=instructorId%></td>
									<td><%=name%></td>
									<td><%=email%></td>
									<td>
										<%-- <a href="editInstructor.jsp?instructor_id=<%=instructorId%>"
											class="btn btn-md btn-primary">Edit</a> --%>
										<a href="deleteInstructorServlet?instructor_id=<%=instructorId%>"
											class="btn btn-md btn-danger">Delete</a>
									</td>
								</tr>
							<%
								}
							} catch (SQLException e) {
								out.println("Error: Unable to connect to the database.<br>" + e.getMessage());
								e.printStackTrace();
							} catch (ClassNotFoundException e) {
								out.println("Error: MySQL JDBC Driver not found.<br>" + e.getMessage());
								e.printStackTrace();
							} finally {
								// Close the ResultSet, PreparedStatement, and Connection
								if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
								if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
								if (con != null) try { con.close(); } catch (SQLException ignore) {}
							}
							%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
		<%@ include file="additional/footer.jsp"%>
	
</body>
</html>
