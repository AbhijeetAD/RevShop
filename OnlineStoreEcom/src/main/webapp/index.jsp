<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rev.service.dao.*, com.rev.service.*,com.rev.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>RevShop</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<style>
    body {
        background-color: #ff012f;
        font-family: Verdana, sans-serif;
    }

    /* Company Header */
    .company-header {
        margin-top: 45px;
        background-color: white;
        color: black;
        padding: 5px;
    }
    .company-header h2, .company-header h6 {
        margin: 0;
    }
    .company-header form .form-control {
        width: 80%;
        max-width: 400px;
    }
    .company-header form .btn {
        background-color: #d9534f; /* Bootstrap's btn-danger color */
        border-color: #d9534f;
    }
    .company-header p {
        color: orange;
        font-weight: bold;
        margin: 5px 0;
    }

    /* Navigation Bar */
    .navbar-custom {
        background-color: #333;
    }
    .navbar-custom .navbar-brand {
        color: white;
    }
    .navbar-custom .navbar-nav > li > a {
        color: white;
    }
    .navbar-custom .navbar-nav > li > a:hover {
        background-color: #555;
    }

    /* Featured Products */
    .featured-products {
        padding: 10px 0;
        width:100%;
        
        background-color: #fff;
        color: #333;
    }
    .featured-products h2 {
        margin-bottom: 20px;
    }
    .product-item {
        margin-bottom: 20px;
        text-align: center;
    }
    .product-item img {
        width: 100%;
        height: 200px; /* Set height to ensure uniformity */
        object-fit: cover;
        border-radius: 10px;
    }
    .product-item h4 {
        margin: 10px 0;
    }
    .product-item p {
        margin: 5px 0;
    }
    .product-item .btn {
        background-color: #d9534f;
        border-color: #d9534f;
        color: #fff;
    }

    /* Testimonials */
    .testimonials {
        padding: 20px;
        background-color: #f8f8f8;
        color: #333;
    }
    .testimonials h2 {
        margin-bottom: 20px;
    }
    .testimonial-item {
        text-align: center;
        margin-bottom: 20px;
    }
    .testimonial-item img {
        width: 150px; /* Set width */
        height: 150px; /* Set height to ensure uniformity */
        object-fit: cover;
        border-radius: 50%;
    }
    .testimonial-item p {
        font-style: italic;
    }
   
    .product-item:hover > div {
        transform: rotateY(180deg);
    }

    
</style>
</head>
<body style="background-color: #E6F9E6;">


	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");
	String userType = (String) session.getAttribute("usertype");

	boolean isValidUser = true;

	if (userType == null || userName == null || password == null || !userType.equals("customer")) {

		isValidUser = false;
	}

	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductData> products = new ArrayList<ProductData>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "Products";
	if (search != null) {
		products = prodDao.searchAllProducts(search);
		message = "Showing Results for '" + search + "'";
	} else if (type != null) {
		products = prodDao.getAllProductsByType(type);
		message = "Showing Results for '" + type + "'";
	} else {
		products = prodDao.getAllProducts();
	}
	if (products.isEmpty()) {
		message = "No items found for the search '" + (search != null ? search : type) + "'";
		products = prodDao.getAllProducts();
	}
	%>

	<jsp:include page="header.jsp" />

<!-- End of Navigation Bar -->

    <!-- Featured Products Section -->
    
    <div class="featured-products" style="background-color: #E6F9E6">
        <h2 style="text-align:center;background-color:gray;"><b>Featured Products</b></h2><br>
        <br><br><br><br>
        <div class="container" >
    <div class="row">
        <div class="col-sm-4">
            <div class="product-item" style="background-color: transparent; width: 100%; height: 100%; perspective: 1000px;">
                <div style="position: relative; width: 100%; height: 100%; text-align: center; transition: transform 0.6s; transform-style: preserve-3d;">
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden; display: flex; justify-content: center; align-items: center;">
                        <img src="images/cloth.jpg" alt="Product 1" style="width:210px">
                    </div>
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden; transform: rotateY(180deg); display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 10px;">
                        <h4>Silk Cloth</h4>
                        <p>Clothes. This is an amazing product with top-notch features.</p>
                        <p><strong>Rs.1000</strong></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-4">
            <div class="product-item" style="background-color: transparent; width: 100%; height: 100%; perspective: 1000px;">
                <div style="position: relative; width: 100%; height: 100%; text-align: center; transition: transform 0.6s; transform-style: preserve-3d;">
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden; display: flex; justify-content: center; align-items: center;">
                        <img src="images/watch.jpg" alt="Product 2" style="width:140px">
                    </div>
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden; transform: rotateY(180deg); display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 10px;">
                        <h4 style="color:black">Watch</h4>
                        <p>Watch. This product offers excellent value for money.</p>
                        <p><strong>Rs.2500</strong></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-4">
            <div class="product-item" style="background-color: transparent; width: 100%; height: 100%; perspective: 1000px;">
                <div style="position: relative; width: 100%; height: 100%; text-align: center; transition: transform 0.6s; transform-style: preserve-3d;">
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden; display: flex; justify-content: center; align-items: center;">
                        <img src="images/earbud.jpg" alt="Product 3" style="width:100px">
                    </div>
                    <div style="position: absolute; width: 100%; height: 100%; backface-visibility: hidden;transform: rotateY(180deg); display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 10px;">
                        <h4>Ear Bud</h4>
                        <p>EarBUd. Highly recommended for those who love quality.</p>
                        <p><strong>Rs.3000</strong></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
        <br><br><br><br><br><br>
<div class="testimonials">
        <h2 style="text-align:center">What Our Customers Say</h2>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="testimonial-item">
                        <p>"The products are fantastic! Excellent quality and great customer service."</p>
                        <p class="author">- Jane Doe</p>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="testimonial-item">
                        <p>"I had a great shopping experience. The delivery was fast and the product was as described."</p>
                        <p class="author">- John Smith</p>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="testimonial-item">
                        <p>"Highly recommend this store. Amazing deals and a wide variety of products."</p>
                        <p class="author">- Emily Johnson</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    


	<div class="text-center"
		style="color: black; font-size: 34px; font-weight: bold;"><%=message%></div>
	<div class="text-center" id="message"
		style="color: black; font-size: 14px; font-weight: bold;"></div>
	<!-- Start of Product Items List -->
	<div class="container" >
		<div class="row text-center">

			<%
			for (ProductData product : products) {
				int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
			%>
			<div class="col-sm-4" style="height: 350px;">
				<div class="thumbnail" style="border-radius:50px; background-color:#d0dbeb">
					<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
						style="height: 150px; max-width: 180px">
					<p class="productname" style="color:black;"><%=product.getProdName()%>
					</p>
					<%
					String description = product.getProdInfo();
					description = description.substring(0, Math.min(description.length(), 100));
					%>
					<p class="productinfo"><%=description%>..
					</p>
					<p class="price">
						Rs
						<%=product.getProdPrice()%>
					</p>
					<form method="post" >
						<%
						if (cartQty == 0) {
						%>
						<button type="submit"
							formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-success" style="border-radius:50px; background-color:#f9d30e;">Add to Cart</button>
						&nbsp;&nbsp;&nbsp;
						<button type="submit"
							formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-primary" style="border-radius:50px; background-color:#cc7f19;">Buy Now</button>
						<%
						} else {
						%>
						<button type="submit"
							formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0"
							class="btn btn-danger" >Remove From Cart</button>
						&nbsp;&nbsp;&nbsp;
						<button type="submit" formaction="cartDetails.jsp"
							class="btn btn-success">Checkout</button>
						<%
						}
						%>
					</form>
					<br />
				</div>
			</div>

			<%
			}
			%>

		</div>
	</div>
	
	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>

</body>
</html>