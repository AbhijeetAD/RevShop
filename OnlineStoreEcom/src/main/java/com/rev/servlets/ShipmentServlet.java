package com.rev.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.rev.service.dao.OrderServiceImpl;
import com.rev.service.dao.UserServiceImpl;
import com.rev.utilities.MailMessage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



/**
 * Servlet implementation class ShipmentServlet
 */
@WebServlet("/ShipmentServlet")
public class ShipmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ShipmentServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("usertype");
        if (userType == null) {
            response.sendRedirect("login.jsp?message=Access Denied, Login Again!!");
            return;
        }

        String orderId = request.getParameter("orderid");
        String prodId = request.getParameter("prodid");
        String userName = request.getParameter("userid");
        Double amount = Double.parseDouble(request.getParameter("amount"));
        
        OrderServiceImpl orderService = new OrderServiceImpl();
        String status = orderService.shipNow(orderId, prodId);

        String pagename = "shippedItems.jsp";
        if ("FAILURE".equalsIgnoreCase(status)) {
            pagename = "unshippedItems.jsp";
        } else {
            UserServiceImpl userService = new UserServiceImpl();
            MailMessage.orderShipped(userName, userService.getFName(userName), orderId, amount);
        }

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();
        RequestDispatcher rd = request.getRequestDispatcher(pagename);

        rd.include(request, response);
        pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

