<%@ page import="java.sql.*" %>
<%@ include file="additional/bootstrapCss.jsp"%>

<html>
<head>
    <title>View Course Completion Reports</title>
    <style type="text/css">
        body {
            background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%, rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
            color: orange;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid white;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Course Completion Reports</h2>

    <table>
        <tr>
            <th>Course ID</th>
            <th>Course Title</th>
            <th>Completed Students</th>
        </tr>
        <%
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String dbURL = "jdbc:mysql://localhost:3306/lms";
            String dbUser = "root";
            String dbPassword = "root";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // SQL query to get the course completion reports
                String sql = "SELECT c.course_id, c.title, COUNT(DISTINCT pt.user_id) AS completed_students " +
                             "FROM courses c " +
                             "JOIN progress_tracking pt ON c.course_id = pt.course_id " +
                             "WHERE pt.is_completed = TRUE " +
                             "GROUP BY c.course_id, c.title";
                pstmt = con.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int courseId = rs.getInt("course_id");
                    String courseTitle = rs.getString("title");
                    int completedStudents = rs.getInt("completed_students");
        %>
        <tr>
            <td><%= courseId %></td>
            <td><%= courseTitle %></td>
            <td><%= completedStudents %></td>
        </tr>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (con != null) try { con.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
</body>
	<%@ include file="additional/footer.jsp"%>

</html>
