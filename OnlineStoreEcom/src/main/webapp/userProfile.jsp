<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rev.service.dao.*, com.rev.service.*,com.rev.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile Details</title>
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

<!-- Additional CSS -->
<style>
    body {
        background-color: white;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .breadcrumb {
        background-color: white;
        border-radius: 10px;
    padding: 10px;
    }

    .card {
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card-body {
        padding: 30px;
    }

    .rounded-circle {
        border: 3px solid #3498db;
    }

    .text-muted {
        color: #6c757d !important;
    }

    .container {
        margin-top: 20px;
    }

    hr {
        border: 1px solid #3498db;
        width: 80%;
        margin: 10px auto;
    }

    .list-group-item {
        background-color: #3498db ;
        color: white;
        font-weight: bold;
    }

    .list-group-item:hover {
        background-color: #2980b9;
    }

    .btn-primary {
        background-color: #3498db;
        border-color: #2980b9;
    }

    .btn-primary:hover {
        background-color: #2980b9;
    }
    
</style>
</head>
<body style="background-color:white;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	UserService dao = new UserServiceImpl();
	UserData user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserData("Abhijeet", 9834813727L, "abhi@gmail.com", "Hira Nagar, Khamgaon, Maharashtra", 87659, "lksdjf");
	%>

	<jsp:include page="header.jsp" />

	<div class="container" style="background-color:white;padding:30px;border-radius:10px">
		<div class="row">
			<div class="col">
				<nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
					<ol class="breadcrumb mb-0">
						<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page">User Profile</li>
					</ol>
				</nav>
			</div>
		</div>

		<div class="row" >
			
			<div class="col-lg-8" style="background-color:white;border-radius:30px;left: 18%;">
				<div class="card mb-4">
					<div class="card-body"style="color:orange" >
						<div class="row" >
							<div class="col-sm-3">
								<p class="mb-0"><b>Full Name</b></p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0" style="font-weight:bold;"><%=user.getName()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0"><b>Email</b></p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="font-weight:bold;"><%=user.getEmail()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0"><b>Phone</b></p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="font-weight:bold;"><%=user.getMobile()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0"><b>Address</b></p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="font-weight:bold;"><%=user.getAddress()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0"><b>PinCode</b></p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="font-weight:bold;"><%=user.getPinCode()%></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>

</body>
</html>
