<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.org.dto.CourseContent" %>
<%@ include file="additional/bootstrapCss.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Learning Materials</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .content-card {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 10px;
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
                String contentUrl = request.getContextPath() + content.getUrl(); // Correct relative URL
    %>
    <div class="content-card">
        <h3><%= content.getTitle() %></h3>
        <p>Type: <%= content.getDescription() %></p>
        
        <%
            // Check content type and display accordingly
            if ("image/jpeg".equals(contentType) || "image/png".equals(contentType)) {
        %>
            <img src="<%= contentUrl %>" alt="<%= content.getTitle() %>" width="300">
        <%
            } else if ("video/mp4".equals(contentType)) {
        %>
            <video controls width="300">
                <source src="<%= contentUrl %>" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        <%
            } else {
        %>
            <a href="<%= contentUrl %>" target="_blank">Download Material</a>
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
