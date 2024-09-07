<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: white;">

	<%@ include file="header.jsp"%>

	<%
	String message = request.getParameter("message");
	%>
	<br><br>
	<div class="container">
    <div class="row" style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
        <form action="./LoginServlet" method="post" style="background-color: gray;"
            class="col-md-8 col-md-offset-2"
            style="border: 1px solid black; border-radius: 10px; background-color: white; padding: 20px;">
            <div style="font-weight: bold;" class="text-center">
                <h2 style="color: black;">Login Form</h2>
                <% if (message != null) { %>
                <p style="color: blue;"><%=message%></p>
                <% } %>
            </div>
            <div class="form-group row">
                <label for="username" class="col-md-2 col-form-label text-right">Username</label>
                <div class="col-md-10">
                    <input type="email" placeholder="Enter Username" name="username"
                        class="form-control" id="username" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="password" class="col-md-2 col-form-label text-right">Password</label>
                <div class="col-md-10">
                    <input type="password" placeholder="Enter Password" name="password"
                        class="form-control" id="password" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="userrole" class="col-md-2 col-form-label text-right">Login As</label>
                <div class="col-md-10">
                    <select name="usertype" id="userrole" class="form-control" required>
                        <option value="customer" selected>CUSTOMER</option>
                        <option value="admin">ADMIN</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-12 text-center">
                    <button type="submit" class="btn btn-success">Login</button>
                </div>
            </div>
        </form>
    </div>
</div>
	<%@ include file="footer.html"%>

</body>
</html>