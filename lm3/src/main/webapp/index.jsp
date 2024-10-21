<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="additional/bootstrapCss.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.5);
	background-color: rgba(2, 0, 36, 1);
	color: orange;
}

body {
	background: rgb(49, 103, 103);
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
}

.main {
	padding: 130px;
	display: flex;
	justify-content: center;
	align-items: center;
}

a {
 	text-decoration: none;
	color: orange;
	margin: 25px;
}


p{
color: white;
}
button {
	width: 70px;
	height: 70px;
	background-color: black;
	margin: 20px;
	border-radius: 10px;
}

h3 {
	color: orange;
	text-align: center;
}
</style>
</head>
<body>
	<h3>Learning Management System</h3>

	<div class="container p-5">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="car paint-card">
					<div class="card-body">
						<div class="main">
							<p>
								<a class="btn btn-success btn-lg"
									href="login.jsp">User </a>
							</p>

							<p>
								<a class="btn btn-primary btn-lg"
									href="adminlogin.jsp">admin </a>
							</p>


						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>