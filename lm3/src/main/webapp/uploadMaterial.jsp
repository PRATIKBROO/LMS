<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="additional/bootstrapCss.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Upload Learning Material</title>
<style type="text/css">
body {
	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
	color: orange;
}

h2 {
	text-align: center;
}

div {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: rgba(49, 103, 103, 1) 20%;
    margin-top: 100px;
}
button{
background-color: black;
color:white;
}
button:hover{
background-color: white;
color:black;
}
</style>
</head>
<body>
	<h2>Upload New Learning Material</h2>
	<div>
		<form action="UploadMaterialServlet" method="post"
			enctype="multipart/form-data">
			<label>Course ID:</label> <input type="number" name="course_id"
				required><br>
			<br> <label>Select File:</label> <input type="file" name="file"
				required><br>
			<br>

			<button type="submit">Upload</button>
		</form>
	</div>
</body>

<%@ include file="additional/footer.jsp"%>

</html>
