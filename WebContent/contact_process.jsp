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
String name=request.getParameter("contact_name");
String email=request.getParameter("contact_email");
String message=request.getParameter("contact_message");
int sno=0;

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from contact");

while(rs.next()){
	sno++;
}

java.util.Date dt=new java.util.Date();
java.sql.Date date1=new Date(dt.getTime());
java.sql.Time time=new Time(dt.getTime());

PreparedStatement ps=con.prepareStatement("insert into contact values(?,?,?,?,?)");
ps.setInt(1, sno);
ps.setString(2,name);
ps.setString(3,email);
ps.setString(4,message);
ps.setDate(5,date1);
int k=ps.executeUpdate();
if(k!=1){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
}else{
	RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
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