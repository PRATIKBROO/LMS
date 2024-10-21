<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="additional/bootstrapCss.jsp" %>
<style type="text/css">
.paint-card{
box-shadow: 0 0 10px 0 rgba(0,0,0,0.8);
background-color: rgba(2,0,36,1);
color:orange;
}
.container{

}
body{
/* background-color: #363532;
 */
background: rgb(49,103,103);
background: radial-gradient(circle, rgba(49,103,103,1) 20%, rgba(2,0,36,1) 69%, rgba(2,0,36,1) 81%);
}
.btn:hover{
background-color: black;
color:white;
}
</style>
</head>
<body>
<%@ include file="additional/index_nav.jsp" %>

<div class="container p-5">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="car paint-card" >
					<div class="card-body">
					<p class="fs-4 text-center">User Resgistration</p>
					<% String msg=(String)session.getAttribute("msg");
				 	if(msg!=null){%>
						<p class="fs-4 text-center text-success"> <%= msg %></p>
						
				 	<% session.removeAttribute("msg"); }
				 	else{%>
				 		
				 	<% }%>
					
						
						<form action="regi" method="post">
							<div class="mb-3">
								<label class="form-label">Name</label>
								<input name="name" type="text" class="form-control" required>					
							</div>
							<div class="mb-3">
								<label class="form-label">Age</label>
								<input name="age" type="text" class="form-control" required>					
							</div>
							<div class="mb-3">
								<label class="form-label">Email Address</label>
								<input name="email" type="email" class="form-control" required>					
							</div>
							<div class="mb-3">
								<label class="form-label">Mobile</label>
								<input name="mob" type="text" class="form-control" required>					
							</div>
								<div class="mb-3">
								<label class="form-label">Password</label>
								<input name="password" type="password" class="form-control" required>					
							</div>
							<button type="submit" class="btn bg-secondary text-white col-md-12">Register</button>
						</form>
					
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
	<%@ include file="additional/footer.jsp"%>

</html>