package com.org.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

@WebServlet("/GoogleLoginServlet")
	public class GoogleLoginServlet extends HttpServlet {
	    private static final String CLIENT_ID = "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com";

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String idTokenString = request.getParameter("idtoken");

	        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new JacksonFactory())
	            .setAudience(Collections.singletonList(CLIENT_ID))
	            .build();

	        try {
	            GoogleIdToken idToken = verifier.verify(idTokenString);
	            if (idToken != null) {
	                GoogleIdToken.Payload payload = idToken.getPayload();

	                String userId = payload.getSubject();
	                String email = payload.getEmail();
	                String name = (String) payload.get("name");

	                HttpSession session = request.getSession();
	                session.setAttribute("id", userId);
	                session.setAttribute("email", email);
	                session.setAttribute("name", name);

	                response.sendRedirect("userdashboard.jsp");
	            } else {
	                response.sendRedirect("login.jsp?error=InvalidGoogleLogin");
	            }
	        } catch (GeneralSecurityException | IOException e) {
	            e.printStackTrace();
	            response.sendRedirect("login.jsp?error=GoogleLoginFailed");
	        }
	    }
	}

