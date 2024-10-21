package com.org.dao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.org.dto.CourseContent;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewEnrolledCourseContent")
public class ViewEnrolledCourseContentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get user and course info
        HttpSession session = req.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");
        String courseIdParam = req.getParameter("course_id");
        System.out.println(courseIdParam);System.out.println(userId);
        if (userId == null || courseIdParam == null) {
            resp.sendRedirect("login.jsp");  // User must be logged in and a valid course ID must be passed
            return;
        }

        int courseId = Integer.parseInt(courseIdParam);
    
        // Fetch course content only if the user is enrolled
        enrollcourse enrollmentDAO = new enrollcourse();
        List<CourseContent> contentList = new ContentDao().fetchEnrolledCourseContent(courseId, userId);

        // If content is found, forward it to the JSP
        if (contentList != null && !contentList.isEmpty()) {
            req.setAttribute("contentList", contentList);
            req.getRequestDispatcher("viewCourseContent.jsp").forward(req, resp);
        } else {
            // If user is not enrolled or content not found
            resp.sendRedirect("error.jsp");
        }
    }
}
