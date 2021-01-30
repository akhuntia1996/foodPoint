<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

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
			ResultSet rs1=st1.executeQuery("select * from spot");
			while(rs1.next())
				count1++;
			count1++;
			String username=(String)session.getAttribute("logged_user");
			int price=rs.getInt(4)*quantity;
			int foodid=rs.getInt(1);
			String foodname=rs.getString(2);
			PreparedStatement ps=con.prepareStatement("insert into spot values(?,?,?,?,?,?)");
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
		RequestDispatcher rd=request.getRequestDispatcher("spotbook.jsp?value=99");
		rd.forward(request,response);
	}else{
		RequestDispatcher rd=request.getRequestDispatcher("payment.jsp?payfor=spotbook&sum="+sum);
		rd.forward(request,response);
	}
}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
	//out.println(ee);
}
%>


</body>
</html>