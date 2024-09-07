<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.rev.service.dao.*, com.rev.service.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Logout Header</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
</head>
<body style="background-color: #ff012f;font-family: Verdana, sans-serif;">
	<!--Company Header Starting  -->
	<div class="container-fluid" style="margin-top: 45px; background-color: #bccce3; color: white; padding: 5px; position: relative;">
    <!-- Left Image -->
    <img src="images/men.jpg" style="position: absolute; left: 20px; top: 50%; transform: translateY(-50%); width: 380px; border-radius: 30px;" alt="Left Image">

    <!-- Main Logo -->
    <h2 style="text-align: center; margin: 0;">
        <img src="images/logo3.png" style="width: 200px; border-radius: 30px;" alt="RevShop Logo">
    </h2>

    <!-- Right Image -->
    <img src="images/cell.jpg" style="position: absolute; right: 60px; top: 50%; transform: translateY(-50%); width: 300px; border-radius: 30px;" alt="Right Image">
    
    <h6 style="text-align: center; color: black; margin-top: 0px;"><marquee behavior="alternate"><b>Your One-Stop Shop for Electronics, Fashion, and More!</b></marquee></h6>
    
		<div style="position:absolute;right:420px;top:155px; margin-bottom: 20px; ">
        <form class="form-inline" action="index.jsp" method="get">
            <div class="input-group" >
                <input type="text" class="form-control" size="50" name="search" placeholder="Search Items" style="border-top-left-radius:50px;border-bottom-left-radius:50px" required>
                <div class="input-group-btn">
                    <input type="submit" class="btn btn-danger" value="Search" />
                </div>
            </div>
        </form>
    </div>
		
		<p align="center"
			style="color: red; font-weight: bold; margin-top: 5px; margin-bottom: 5px;"
			id="message"></p>
	</div>
	<!-- Company Header Ending -->

	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	if (userType == null) { //LOGGED OUT
	%>

	<!-- Starting Navigation Bar -->
	<nav class="navbar navbar-default navbar-fixed-top navbar-custom" style="background-color:#38e7eb">
		<div class="container-fluid" style="background-color:#38e7eb">
			<div class="navbar-header" style="background-color:#38e7eb">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">RevShop</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar" style="background-color:#38e7eb">
				<ul class="nav navbar-nav navbar-right">
				<li><a href="register.jsp">Register</a></li>
					<li><a href="login.jsp">Login</a></li>
					<li><a href="index.jsp">Products</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Category <span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="index.jsp?type=mobile">Mobiles</a></li>
							<li><a href="index.jsp?type=tv">TVs</a></li>
							<li><a href="index.jsp?type=laptop">Laptops</a></li>
							<li><a href="index.jsp?type=camera">Camera</a></li>
							<li><a href="index.jsp?type=speaker">Speakers</a></li>
							<li><a href="index.jsp?type=tablet">Tablets</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<%
	} else if ("customer".equalsIgnoreCase(userType)) { 

	int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
	%>
	<nav class="navbar navbar-default navbar-fixed-top">

		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="userHome.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>RevShop</a>
			</div>

			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="userHome.jsp"><span
							class="glyphicon glyphicon-home">Products</span></a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Category <span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="userHome.jsp?type=mobile">Mobiles</a></li>
							<li><a href="userHome.jsp?type=tv">TV</a></li>
							<li><a href="userHome.jsp?type=laptop">Laptops</a></li>
							<li><a href="userHome.jsp?type=camera">Camera</a></li>
							<li><a href="userHome.jsp?type=speaker">Speakers</a></li>
							<li><a href="userHome.jsp?type=tablet">Tablets</a></li>
						</ul></li>
					<%
					if (notf == 0) {
					%>
					<li><a href="cartDetails.jsp"> <span
							class="glyphicon glyphicon-shopping-cart"></span>Cart
					</a></li>

					<%
					} else {
					%>
					<li><a href="cartDetails.jsp"
						style="margin: 0px; padding: 0px;" id="mycart"><i
							data-count="<%=notf%>"
							class="fa fa-shopping-cart fa-3x icon-white badge"
							style="background-color: #333; margin: 0px; padding: 0px; padding-bottom: 0px; padding-top: 5px;">
						</i></a></li>
					<%
					}
					%>
					<li><a href="orderDetails.jsp">Orders</a></li>
					<li><a href="userProfile.jsp">Profile</a></li>
					<li><a href="./LogoutServlet">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<%
	} else {
	%>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="adminViewProduct.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>RevShop</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="adminViewProduct.jsp">Products</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Category <span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="adminViewProduct.jsp?type=mobile">Mobiles</a></li>
							<li><a href="adminViewProduct.jsp?type=tv">Tvs</a></li>
							<li><a href="adminViewProduct.jsp?type=laptop">Laptops</a></li>
							<li><a href="adminViewProduct.jsp?type=camera">Camera</a></li>
							<li><a href="adminViewProduct.jsp?type=speaker">Speakers</a></li>
							<li><a href="adminViewProduct.jsp?type=tablet">Tablets</a></li>
						</ul></li>
					<li><a href="adminStock.jsp">Stock</a></li>
					<li><a href="shippedItems.jsp">Shipped</a></li>
					<li><a href="unshippedItems.jsp">Orders</a></li>
					<!-- <li><a href=""> <span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Cart</a></li> -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">Update Items <span
							class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="addProduct.jsp">Add Product</a></li>
							<li><a href="removeProduct.jsp">Remove Product</a></li>
							<li><a href="updateProductById.jsp">Update Product</a></li>
						</ul></li>
					<li><a href="./LogoutServlet">Logout</a></li>

				</ul>
			</div>
		</div>
	</nav>
	<%
	}
	%>
	<!-- End of Navigation Bar -->
</body>
</html>