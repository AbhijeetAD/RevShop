package com.rev.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.rev.data.OrderDetails;
import com.rev.service.OrderService;
import com.rev.service.dao.OrderServiceImpl;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
            return;
        }

        String amountParam = request.getParameter("amount");
        double paidAmount = 0.0;

        if (amountParam != null && !amountParam.isEmpty()) {
            try {
                paidAmount = Double.parseDouble(amountParam.trim());
            } catch (NumberFormatException e) {
                response.sendRedirect("payment.jsp?message=Invalid amount provided!");
                return;
            }
        } else {
            response.sendRedirect("payment.jsp?message=Amount is required!");
            return;
        }

        OrderService orderService = new OrderServiceImpl();
        orderService.paymentSuccess(userName, paidAmount);

        List<OrderDetails> orders = orderService.getAllOrderDetails(userName);

        // Check if orders are populated
        if (orders == null || orders.isEmpty()) {
            System.out.println("No orders found for user: " + userName);
        } else {
            System.out.println("Orders: " + orders);
        }

        request.setAttribute("orders", orders);
        RequestDispatcher rd = request.getRequestDispatcher("orderDetails.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

