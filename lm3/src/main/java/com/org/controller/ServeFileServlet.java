package com.org.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@WebServlet("/serveFile")
public class ServeFileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the file path from the request
        String filePath = request.getParameter("filePath");

        // Create a file object from the given file path
        String absoluteFilePath = getServletContext().getRealPath("") + File.separator + filePath;
        File file = new File(absoluteFilePath);

        // Check if file exists
        if (!file.exists()) {
            response.getWriter().write("File not found.");
            return;
        }

        // Set the correct content type (image/jpeg, video/mp4, etc.)
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);

        // Set content length
        response.setContentLength((int) file.length());

        // Write the file to the response output stream
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}
