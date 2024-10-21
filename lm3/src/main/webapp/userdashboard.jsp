<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="com.org.dto.UserDTO"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>
<style>
body {
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
}

/* .main {
	width: 100px;
	height: 100px;
	background-color: white;
	padding: 30px;
	margin: 20px;
} */
.main {
	height: 1000px;
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

h1 {
	text-align: center;
}

a {
	color: orange;
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
/* Navigation bar */
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
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.5);
	background-color: rgba(2, 0, 36, 1);
	color: orange;
}
th {
	color: orange;
	font-size: large;
}

td {
	color: white;
}

.cou {
	border: solid orange 1px;
	width: 200px;
	height: 200px;
	padding: 25px;
	margin-bottom: 20px;
}

.cou>h2 {
	text-align: center;
	padding: 10px;
}

img {
	width: 150px;
	height: 100px;
}

.mid {
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
</style>
</head>
<body>

	<%
	Integer userId = (Integer) session.getAttribute("id");
	UserDTO user= (UserDTO) session.getAttribute("userobj");
    session.setAttribute("userobj", user);
	if (userId == null) {
		// Redirect to login page if user ID is not available in session
		response.sendRedirect("login.jsp");
		return;
	}
	%>


	<div class="navbar">
		<a href="usercourselist.jsp">All Courses</a> <a href="userenrolled_courses">Enrolled
			Courses</a> <a href="updateuser.jsp">Account Setting</a>
<a href="<%= request.getContextPath() %>/logoutservlet">Log Out</a>

	</div>
	<h1>Hello Welcome To user Dashboard</h1>
	<div class="container-fluid p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card paint-card">
					<div class="card-body">
						<p class="fs-3 text-center">Courses</p>

						<div class="mid">
							<div class="cou">
								<img alt=""
									src="https://www.techmonitor.ai/wp-content/uploads/sites/29/2016/06/SQL.png">
								<h2>SQL</h2>
							</div>
							<div class="cou">
								<img alt=""
									src="https://logos-world.net/wp-content/uploads/2022/07/Java-Logo.png">
								<h2>JAVA</h2>
							</div>
							<div class="cou">
								<img alt=""
									src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/1200px-Python-logo-notext.svg.png">
								<h2>PYTHON</h2>
							</div>
							<div class="cou">
								<img alt=""
									src="https://w7.pngwing.com/pngs/79/518/png-transparent-js-react-js-logo-react-react-native-logos-icon-thumbnail.png">
								<h2>ReactJS</h2>
							</div>
							<div class="cou">
								<img alt=""
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVvmOcXHNadKGeL33EmGR66uETCvyiU1iIeA&s">
								<h2>php</h2>
							</div>
						</div>


					</div>
				</div>
			</div>
		</div>
	</div>

</body>
	<%@ include file="additional/footer.jsp"%>

</html>
