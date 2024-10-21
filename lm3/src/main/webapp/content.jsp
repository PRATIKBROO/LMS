<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.org.dto.CourseContent"%>
<%@ include file="additional/bootstrapCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Learning Materials</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: rgba(2, 0, 36, 1);
    	background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
    color: orange;
    padding: 20px;
}

.content-card {
	background-color: rgba(2, 0, 36, 1);
		background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%,
		rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
    border: 0px solid #ddd;
    padding: 15px;
    margin-bottom: 10px;
      max-width: 100%;
   
}

h2 {
    text-align: center;
}
img,video{
height: 200px;
}
</style>
</head>
<body>

<h2>Learning Materials</h2>

<div class="container">
    <%
    List<CourseContent> contentList = (List<CourseContent>) request.getAttribute("contentList");

    if (contentList != null && !contentList.isEmpty()) {
        for (CourseContent content : contentList) {
            String contentType = content.getDescription();
            String filePath = content.getUrl(); // Relative file path from the database
            String serveFileUrl = request.getContextPath() + "/serveFile?filePath=" + filePath; // URL to the ServeFileServlet
    %>
    <div class="content-card">
        <h3><%=content.getTitle()%></h3>
        <p>Type: <%=content.getDescription()%></p>


        <%
        System.out.println(filePath);
        System.out.println(serveFileUrl);
/*         session.getAttribute(arg0);
 */        if ("image/jpeg".equals(contentType) || "image/png".equals(contentType)) {
        %>
        <img src="<%=filePath%>" alt="<%=content.getTitle()%>" width="300">
        <%
        } else if ("video/mp4".equals(contentType)) {
        %>
        <video controls width="300">
            <source src="<%=filePath%>" type="video/mp4">
        </video>
        <%
        } else {
        %>
        <a href="<%=serveFileUrl%>" target="_blank">Download Material</a>
        <%
        }
        %>
    </div>
    <%
        }
    } else {
    %>
    <p>No learning materials available for this course.</p>
    <%
    }
    %>
</div>

</body>
</html>
