<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Food Point | Online Based Food Ordering System</title>

<script>setTimeout(function(){window.location.href='thankyou.jsp'},5000);</script>

</head>
<body>
<h1>Please Wait ... </h1>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");
	
	String username=(String)session.getAttribute("logged_user");
	int cost=(int)session.getAttribute("cost");
	int sno=0;
	//String mode=request.getParameter("paymode");
	String payfor=(String)session.getAttribute("payfor");
	
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from payment");
	while(rs.next())
		sno++;
	
	PreparedStatement ps=con.prepareStatement("insert into payment values(?,?,?,?)");
	ps.setInt(1,sno);
	ps.setString(2,username);
	ps.setInt(3,cost);
	ps.setString(4,payfor);
		int k=ps.executeUpdate();
		if(k!=1){
			RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
			rd.forward(request,response);
		}else{
			// sql code is successful...
		}

}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
	ee.printStackTrace();
}
%>
</body>
</html>