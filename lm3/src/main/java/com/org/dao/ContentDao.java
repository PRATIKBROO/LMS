package com.org.dao;

import com.org.dto.CourseContent;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContentDao {

    // Fetch course content for a specific course if the user is enrolled
    public List<CourseContent> fetchEnrolledCourseContent(int courseId, int userId) {
        List<CourseContent> contentList = new ArrayList<>();
        String sql = "SELECT lm.material_id, lm.file_name, lm.file_path, lm.file_type " +
                     "FROM learning_materials lm " +
                     "JOIN enrollment e ON lm.course_id = e.course_id " +
                     "WHERE e.user_id = ? AND lm.course_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lms", "root", "root");
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, userId);
            pst.setInt(2, courseId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                CourseContent content = new CourseContent();
                content.setContentId(rs.getInt("material_id"));
                content.setTitle(rs.getString("file_name"));
                content.setDescription(rs.getString("file_type"));
                content.setUrl(rs.getString("file_path"));

                contentList.add(content);
            }
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return contentList;
    }
}
