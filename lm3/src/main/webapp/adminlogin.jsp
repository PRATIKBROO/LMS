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
box-shadow: 0 0 10px 0 rgba(0,0,0,0.5);
background-color: rgba(2,0,36,1);
color:orange;
}
 body{
background: rgb(49,103,103);
background: radial-gradient(circle, rgba(49,103,103,1) 20%, rgba(2,0,36,1) 69%, rgba(2,0,36,1) 81%);
} 
</style>
</head>
<body>
<%@ include file="additional/adminNav.jsp" %>

<div class="container p-5">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="car paint-card" >
					<div class="card-body">
					<p class="fs-4 text-center">Admin Login</p>
 					<% String mes =(String)session.getAttribute("msg");
 					
 					if(mes!=null){%>
 					<p class="fs-4 text-center text-danger"><%= mes %></p> 
 					<% } session.removeAttribute("msg");
 					%>
 					<form action="adlog" method="post">
							<div class="mb-3">
								<label class="form-label">Email Address</label>
								<input name="email" type="email" class="form-control" required>					
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label>
								<input name="password" type="password" class="form-control" required>					
							</div>
							<button type="submit" class="btn bg-secondary text-white col-md-12">Login</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="additional/footer.jsp"%>

</body>
</html>