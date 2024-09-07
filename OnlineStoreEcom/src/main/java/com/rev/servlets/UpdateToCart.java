package com.rev.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.rev.data.ProductData;
import com.rev.data.RequestData;
import com.rev.service.dao.CartServiceImpl;
import com.rev.service.dao.ProductServiceImpl;
import com.rev.service.dao.RequestServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class UpdateToCart
 */
@WebServlet("/UpdateToCart")
public class UpdateToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateToCart() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("username");
		String password = (String) session.getAttribute("password");

		if (userName == null || password == null) {
			response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
			return; // Ensure that further processing is halted after redirection
		}

		// Login Check Successful

		String userId = userName;
		String prodId = request.getParameter("pid");
		int pQty = Integer.parseInt(request.getParameter("pqty"));

		CartServiceImpl cart = new CartServiceImpl();
		ProductServiceImpl productDao = new ProductServiceImpl();

		ProductData product = productDao.getProductDetails(prodId);
		int availableQty = product.getProdQuantity();

		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();

		if (availableQty < pQty) {
			String status = cart.updateProductToCart(userId, prodId, availableQty);
			status = "Only " + availableQty + " no of " + product.getProdName()
					+ " are available in the shop! So we are adding only " + availableQty + " products into Your Cart.";

			RequestData demandBean = new RequestData(userName, product.getProdId(), pQty - availableQty);
			RequestServiceImpl demand = new RequestServiceImpl();
			boolean flag = demand.addProduct(demandBean);

			if (flag) {
				status += "<br/>Later, We Will Mail You when " + product.getProdName()
						+ " will be available in the Store!";
			}

			RequestDispatcher rd = request.getRequestDispatcher("cartDetails.jsp");
			rd.include(request, response);
			pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
		} else {
			String status = cart.updateProductToCart(userId, prodId, pQty);

			RequestDispatcher rd = request.getRequestDispatcher("cartDetails.jsp");
			rd.include(request, response);
			pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
