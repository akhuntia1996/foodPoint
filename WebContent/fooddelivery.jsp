<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
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

<div class="spotbook_body">
<h1>Food Menu</h1><hr>
<div class="downArrow"><a href="#book_button"><img src="image/down_arrow.png" /></a></div>
<%
String val=request.getParameter("value");
if(val.equals("99")){
	out.println("<h2 style='color:red'>Please Tick the Items and enter the Quantity !!!</h2>");
}
%>
<form action="delivery_process.jsp" method="get" name="choose_food_delivery">
<%
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery("select * from menu where category='nonveg'");
out.println("<h2>Non Veg</h2>");
out.println("<table cellspacing=4>");
out.println("<tr><th>Food ID</th><th>Name</th><th>Photo</th><th>Price</th><th>Quantity</th></tr>");
while(rs.next()){
	int sno=rs.getInt(1);
	String s="c"+sno;
	String s1="q"+sno;
	out.println("<tr><td>00"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td><a href='food_image.jsp?id="+rs.getInt(1)+"'>View Image</a></td><td>"+rs.getDouble(4)+"</td><td><input type=text name="+s1+" value='0' /></td><td><input type=checkbox name="+s+" ></td></tr>");
}
out.println("</table>");

rs=st.executeQuery("select * from menu where category='veg'");
out.println("<h2>Veg</h2>");
out.println("<table cellspacing=4>");
out.println("<tr><th>Food ID</th><th>Name</th><th>Photo</th><th>Price</th><th>Quantity</th></tr>");
while(rs.next()){
	int sno=rs.getInt(1);
	String s="c"+sno;
	String s1="q"+sno;
	out.println("<tr><td>00"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td><a href='food_image.jsp?id="+rs.getInt(1)+"'>View Image</a></td><td>"+rs.getDouble(4)+"</td><td><input type=text name="+s1+" value='0' /></td><td><input type=checkbox name="+s+"></td></tr>");
}
out.println("</table>");

rs=st.executeQuery("select * from menu where category='rice'");
out.println("<h2>Rice</h2>");
out.println("<table cellspacing=4>");
out.println("<tr><th>Food ID</th><th>Name</th><th>Photo</th><th>Price</th><th>Quantity</th></tr>");
while(rs.next()){
	int sno=rs.getInt(1);
	String s="c"+sno;
	String s1="q"+sno;
	out.println("<tr><td>00"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td><a href='food_image.jsp?id="+rs.getInt(1)+"'>View Image</a></td><td>"+rs.getDouble(4)+"</td><td><input type=text name="+s1+" value='0' /></td><td><input type=checkbox name="+s+"></td></tr>");
}
out.println("</table>");

rs=st.executeQuery("select * from menu where category='sweets'");
out.println("<h2>Sweets</h2>");
out.println("<table cellspacing=4>");
out.println("<tr><th>Food ID</th><th>Name</th><th>Photo</th><th>Price</th><th>Quantity</th></tr>");
while(rs.next()){
	int sno=rs.getInt(1);
	String s="c"+sno;
	String s1="q"+sno;
	out.println("<tr><td>00"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td><a href='food_image.jsp?id="+rs.getInt(1)+"'>View Image</a></td><td>"+rs.getDouble(4)+"</td><td><input type=text name="+s1+" value='0' /></td><td><input type=checkbox name="+s+"></td></tr>");
}
out.println("</table>");

rs=st.executeQuery("select * from menu where category='other'");
out.println("<h2>Others</h2>");
out.println("<table cellspacing=4>");
out.println("<tr><th>Food ID</th><th>Name</th><th>Photo</th><th>Price</th><th>Quantity</th></tr>");
while(rs.next()){
	int sno=rs.getInt(1);
	String s="c"+sno;
	String s1="q"+sno;
	out.println("<tr><td>00"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td><a href='food_image.jsp?id="+rs.getInt(1)+"'>View Image</a></td><td>"+rs.getDouble(4)+"</td><td><input type=text name="+s1+" value='0' /></td><td><input type=checkbox name="+s+"></td></tr>");
}
out.println("</table>");
}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
}

%><br>
<section id="book_button">
<input style="padding:7px;" type="submit" name="submit_button" value="Book" />
</section>
</form>
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