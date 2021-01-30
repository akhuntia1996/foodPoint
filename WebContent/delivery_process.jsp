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
		<div class="menu"><a href="login.jsp?value=0">Login</a></div>
	</div>
</div>
<%
	Object ob=session.getAttribute("logged_user");
	if(ob!=null){
		out.println("<div class='lower_header'><div class='lower_header_left'>");
		out.println("Hi,"+session.getAttribute("logged_user")+"</div>");
		out.println("<div class='lower_header_right'>");
		out.println("<div class='lower_header_menu'><a href='profile.jsp?value=0'>My Profile</a></div>");
		out.println("<div class='lower_header_menu'><a href='details.jsp?value=0'>My Transactions</a></div>");
		out.println("<div class='lower_header_menu'><a href='index.jsp'>SignOut</a></div></div></div>");
	}
%>

<div class="tablebook_body">
<div class="tablebook_body_inner">
	<h1>Food Delivery Details:</h1><hr>
	<form method="get" action="payment.jsp?payfor=delivery" name="tablebook_form">
	
<%
try{
	//out.println(request.getParameter("c1"));
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from menu");
	int sno=0;
	int quantity=0;
	int sum=0;
	while(rs.next()){
		sno=rs.getInt(1);
		quantity=0;
		String req=(String)request.getParameter("c"+sno);
		if(req==null){
			continue;
		}
		if(req.equals("on")){
			quantity=Integer.parseInt(request.getParameter("q"+sno));
			sum=sum+rs.getInt(4)*quantity;
			int count1=0;
			Statement st1=con.createStatement();
			ResultSet rs1=st1.executeQuery("select * from delivery");
			while(rs1.next())
				count1++;
			count1++;
			String username=(String)session.getAttribute("logged_user");
			int price=rs.getInt(4)*quantity;
			int foodid=rs.getInt(1);
			String foodname=rs.getString(2);
			session.setAttribute("deliveryid", count1);
			PreparedStatement ps=con.prepareStatement("insert into delivery(deliveryid,username,foodid,foodname,quantity,price) values(?,?,?,?,?,?)");
			ps.setInt(1, count1);
			ps.setString(2,username);
			ps.setInt(3,foodid);
			ps.setString(4,foodname);
			ps.setInt(5,quantity);
			ps.setDouble(6,price);
			if(quantity!=0){
				int k=ps.executeUpdate();
				if(k!=1){
					RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
					rd.forward(request,response);
				}
			}
		}
	}
	if(sum==0){
		RequestDispatcher rd=request.getRequestDispatcher("fooddelivery.jsp?value=99");
		rd.forward(request,response);
	}else{
		sum=sum+50;
		session.setAttribute("cost", sum);
		out.println("<b>Cost: &nbsp;</b>Rs. "+sum+".00<br>");
	}
}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
	//out.println(ee);
}
%>
	<input type="text" name="delivery_address" placeholder="Address" /><br>
	<input type="submit" name="delivery_submit_button" value="Continue" />
	<h6>*Cost of delivery is Rs. 50.00 extra</h6>
	</form>
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
			<a href="login.jsp?value=0">Login</a>
		</div>
	</div>
	<div class="footer2">
		<div class="footer21">Developed By - Abhishek Khuntia | Balmiki Prasad Nayak</div> 
	</div>
</div>
</body>
</html>