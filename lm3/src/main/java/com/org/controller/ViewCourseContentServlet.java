package com.org.controller;

import com.org.dao.ContentDao;
import com.org.dto.CourseContent;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewCourseContent")
public class ViewCourseContentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        // Check if the user is logged in and a course_id is provided
        String courseIdParam = req.getParameter("course_id");
        if (userId == null || courseIdParam == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int courseId = Integer.parseInt(courseIdParam);

        // Fetch course content for the enrolled user
        ContentDao contentDAO = new ContentDao();
        List<CourseContent> contentList = contentDAO.fetchEnrolledCourseContent(courseId, userId);

        // Forward the content to the JSP for display
        req.setAttribute("contentList", contentList);
        req.getRequestDispatcher("content.jsp").forward(req, resp);
    }
}
