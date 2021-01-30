<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int id=Integer.parseInt(request.getParameter("id"));

			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");
				
				Statement st=con.createStatement();
				ResultSet rs;
				
				rs=st.executeQuery("select * from menu where sno="+id);
				if(rs.next())
				{
					out.println("<img src='"+rs.getString(5)+"'/>");
				}
			}
			catch(Exception ee)
			{
				ee.printStackTrace();
				RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
				rd.forward(request,response);
			}
%>
</body>
</html>