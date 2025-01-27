<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="cssFiles/orderDetails.css">
</head>
<body style="background-color: #E6F9E6;">

    <jsp:include page="header.jsp" />

    <div class="text-center"
		style="color: black; font-size: 24px; font-weight: bold; margin:10px">Order
		Details</div>
	<!-- Start of Product Items List -->
	<div class="container">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: gray; color: white; font-size: 14px; font-weight: bold;">
					<tr>
						<th>Picture</th>
						<th>ProductName</th>
						<th>OrderId</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Time</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody
					style="background-color: white; font-size: 15px; font-weight: bold;">
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td data-label="Picture">
                                <img src="./ShowImage?pid=${order.productId}" alt="Product Image" style="width: 50px; height: 50px;">
                            </td>
                            <td data-label="ProductName">${order.prodName}</td>
                            <td data-label="OrderId">${order.orderId}</td>
                            <td data-label="Quantity">${order.qty}</td>
                            <td data-label="Price">Rs ${order.amount}</td>
                            <td data-label="Time">${order.time}</td>
                            <td data-label="Status" class="text-success">
                                <c:choose>
                                    <c:when test="${order.shipped == 0}">
                                        ORDER_PLACED
                                    </c:when>
                                    <c:otherwise>
                                        ORDER_SHIPPED
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.html"%>
</body>
</html>