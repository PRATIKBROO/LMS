package com.org.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import com.org.dto.EnrollmentReport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewEnrollmentReportsServlet")
public class ViewEnrollmentReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseId = request.getParameter("course_id");
        String dateFrom = request.getParameter("date_from");
        String dateTo = request.getParameter("date_to");

        List<EnrollmentReport> reportList = new ArrayList<>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");

            String sql = "SELECT c.id, c.title, COUNT(e.user_id) AS total_enrollments " +
                         "FROM courses c " +
                         "JOIN enrollment e ON c.id = e.course_id " +
                         "WHERE 1=1 "; // Dynamic filtering

            if (courseId != null && !courseId.isEmpty()) {
                sql += " AND c.id = ?";
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                sql += " AND e.enrollment_date >= ?";
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                sql += " AND e.enrollment_date <= ?";
            }
            sql += " GROUP BY c.id, c.title";

            pstmt = con.prepareStatement(sql);

            int paramIndex = 1;
            if (courseId != null && !courseId.isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(courseId));
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                EnrollmentReport report = new EnrollmentReport();
                report.setCourseId(rs.getInt("id"));
                report.setCourseTitle(rs.getString("title"));
                report.setTotalEnrollments(rs.getInt("total_enrollments"));
                reportList.add(report);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Pass the processed report list to the JSP
        request.setAttribute("reportList", reportList);
        request.getRequestDispatcher("viewEnrollmentReports.jsp").forward(request, response);
    }
}

// Class to hold enrollment report data


