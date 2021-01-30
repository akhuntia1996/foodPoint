<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
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

<div class="payment_body">
	<div class="payment_body_inner">
	<h1>Payment Here:</h1><hr>
	<% 
	String username=(String)session.getAttribute("logged_user");
	String payfor=null;
	if(request.getParameter("payfor")!=null){
		payfor=request.getParameter("payfor");
		if(payfor.equals("tablebook")){
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			int cost=quantity*50;
			session.setAttribute("cost", cost);
			session.setAttribute("payfor", payfor);
			out.println("<table cellspacing=5><tr><th>Name:</th><td>"+username+"</td></tr>");
			out.println("<tr><th>Price:</th><td>Rs. "+cost+".00</td></tr><tr><th>For:</th><td>Table Booking</td></tr></table>");
			out.println("<form method='get' name='payment_form' action='before_thankyou.jsp'>");
			out.println("<input type='submit' value='Pay' /></form>");
		}
		if(payfor.equals("spotbook")){
			int cost=Integer.parseInt(request.getParameter("sum"));
			session.setAttribute("cost", cost);
			session.setAttribute("payfor", payfor);
			out.println("<table cellspacing=5><tr><th>Name:</th><td>"+username+"</td></tr>");
			out.println("<tr><th>Price:</th><td>Rs. "+cost+".00</td></tr><tr><th>For:</th><td>Spot Booking</td></tr></table>");
			out.println("<form method='get' name='payment_form' action='before_thankyou.jsp'>");
			out.println("<input type='submit' value='Pay' /></form>");
		}
	}else{
			Integer cost=(Integer)session.getAttribute("cost");
			String address=request.getParameter("delivery_address");
			Class.forName("com.mysql.jdbc.Driver");
			try{
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");
				PreparedStatement ps=con.prepareStatement("update delivery set address='"+address+"' where username='"+username+"'");
				int k=ps.executeUpdate();
				if(k>0){
					session.setAttribute("cost", cost);
					session.setAttribute("payfor", "delivery");
					out.println("<table cellspacing=5><tr><th>Name:</th><td>"+username+"</td></tr>");
					out.println("<tr><th>Price:</th><td>Rs. "+cost+".00</td></tr><tr><th>For:</th><td>Home Delivery</td></tr></table>");
					out.println("<form method='get' name='payment_form' action='before_thankyou.jsp'><b>Mode:</b> <select name='paymode'><option value='cod'>Cash On Delivery</option>");
					out.println("<option value='net'>Net Banking</option></select><br>");
					out.println("<input type='submit' value='Pay' /></form>");
				}else{
					RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
					rd.forward(request,response);		
				}
			}catch(Exception ee){
				ee.printStackTrace();
			}
	}
	%>
</div>
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