<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Manage Users</title>
    <%@ include file="additional/bootstrapCss.jsp"%>
    <style type="text/css">
        body {
            background: radial-gradient(circle, rgba(49, 103, 103, 1) 20%, rgba(2, 0, 36, 1) 69%, rgba(2, 0, 36, 1) 81%);
            color: orange;
        }
        .card-body{
        background-color: rgba(49, 103, 103, 1);
        }
        th, td {
            color: orange;
        }

        h2 {
            text-align: center;
        }

        p {
            background-color: black;
        }
    </style>
</head>
<body>
    <h2>Manage Users</h2>
 
    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-12">
                <div class="card paint-card">
                    <div class="card-body">
                        <p class="fs-1 text-center">User Details</p>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            Connection con = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            String dbURL = "jdbc:mysql://localhost:3306/lms";
                            String dbUser = "root";
                            String dbPassword = "root";

                            try {
                                // Ensure MySQL driver is loaded
                                Class.forName("com.mysql.cj.jdbc.Driver");

                                // Establish the connection to the database
                                con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                // SQL query to fetch users
                                String sql = "SELECT id, name, email FROM user";
                                pstmt = con.prepareStatement(sql);
                                rs = pstmt.executeQuery();

                                // Iterate through the result set and display each user
                                while (rs.next()) {
                                    int userId = rs.getInt("id");
                                    String name = rs.getString("name");
                                    String email = rs.getString("email");
                            %>
                                <tr>
                                    <td><%=userId%></td>
                                    <td><%=name%></td>
                                    <td><%=email%></td>
                                    <td>
                                      <%--   <a href="editUser.jsp?user_id=<%=userId%>" class="btn btn-md btn-primary">Edit</a>  --%>|
                                        <a href="deleteUserServlet?user_id=<%=userId%>" class="btn btn-md btn-danger">Delete</a>
                                    </td>
                                </tr>
                            <%
                                }
                            } catch (SQLException e) {
                                out.println("Error: Unable to connect to the database.<br>" + e.getMessage());
                                e.printStackTrace();
                            } catch (ClassNotFoundException e) {
                                out.println("Error: MySQL JDBC Driver not found.<br>" + e.getMessage());
                                e.printStackTrace();
                            } finally {
                                // Close the ResultSet, PreparedStatement, and Connection
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                                if (con != null) try { con.close(); } catch (SQLException ignore) {}
                            }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
