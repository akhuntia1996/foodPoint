<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>Food Point | Online Based Food Ordering System</title>
</head>
<body>
<div class="header">
	<div class="header1">
		<img src="image/logo.png" />
	</div>
	<div class="header2">
		<div class="menu"><a href="index.jsp">Home</a></div>
		<div class="menu"><a href="service.jsp">Services</a></div>
		<div class="menu"><a href="menu.jsp">Food Menu</a></div>
		<%
		Object ob=session.getAttribute("logged_user");
		if(ob==null){
			out.println("<div class='menu'><a href='login.jsp?value=0'>Login</a></div>");
		}
		%>
	</div>
</div>
<%
	ob=session.getAttribute("logged_user");
	if(ob!=null){
		out.println("<div class='lower_header'><div class='lower_header_left'>");
		out.println("Hi,"+session.getAttribute("logged_user")+"</div>");
		out.println("<div class='lower_header_right'>");
		out.println("<div class='lower_header_menu'><a href='profile.jsp?value=0'>My Profile</a></div>");
		out.println("<div class='lower_header_menu'><a href='details.jsp?value=0'>My Transactions</a></div>");
		out.println("<div class='lower_header_menu'><a href='sign_out.jsp?value=0'>SignOut</a></div></div></div>");
	}
%>
<div class="service_body">
<a href="tablebook.jsp?value=0"><div class="service_menu"><img src="image/table_book.png"><br>Book Table</div></a>
<a href="spotbook.jsp?value=0"><div class="service_menu"><img src="image/spot_book.png"><br>Spot Food Book</div></a>
<a href="fooddelivery.jsp?value=0"><div class="service_menu"><img src="image/food_deliver.png"><br>Food Delivery</div></a>
</div>
<div class="footer">
	<div class="footer1">
		<div class="footer11">
			<b>Address:</b><br>Jaydev Vihar, Bhubaneswar<br><br>
			<b>Phone:</b><br>+91 99999 99999
		</div>
		<div class="footer12">
			<h2>Contact Us:</h2>
			<form method="get" action="contact_process.jsp" name="contact_form">
				<input type="text" name="contact_name" placeholder="Name" /><br><br>
				<input type="email" name="contact_email" placeholder="Email Address" /><br><br>
				<input type="text" name="contact_message" placeholder="Message" /><br><br>
				<input type="submit" name="contact_submit" value="Submit" />
			</form>
		</div>
		<div class="footer13">
			<a href="index.jsp">Home</a><br><br>
			<a href="service.jsp">Services</a><br><br>
			<a href="menu.jsp">Food Menu</a><br><br>
			<%
			ob=session.getAttribute("logged_user");
			if(ob==null){
				out.println("<a href='login.jsp?value=0'>Login</a>");
			}
			%>
		</div>
	</div>
	<div class="footer2">
		<div class="footer21">Developed By - Abhishek Khuntia | Balmiki Prasad Nayak</div> 
	</div>
</div>
</body>
</html>