package com.rev.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fansMessage")  // This maps the URL "/fansMessage" to this servlet
public class FansMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String comments = request.getParameter("comments");

        // Process the form data (e.g., save to a database, send an email, etc.)

        // Set response content type
        response.setContentType("text/html");

        // Create a styled HTML response
        response.getWriter().println("<html><head><title>Thank You!</title>");
        response.getWriter().println("<style>");
        response.getWriter().println("body { font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; text-align: center; padding: 50px; }");
        response.getWriter().println(".message-box { background-color: #3498db; color: white; padding: 20px; border-radius: 10px; display: inline-block; }");
        response.getWriter().println("h1 { font-size: 24px; margin-bottom: 20px; }");
        response.getWriter().println("p { font-size: 18px; }");
        response.getWriter().println("</style>");
        response.getWriter().println("</head><body>");
        response.getWriter().println("<div class='message-box'>");
        response.getWriter().println("<h1>Thank you for your message, " + name + "!</h1>");
        response.getWriter().println("<p>We appreciate your feedback. We will get back to you at " + email + " as soon as possible.</p>");
        response.getWriter().println("</div>");
        response.getWriter().println("</body></html>");
    }
}
