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
	String username=(String)session.getAttribute("logged_user");
	int quantity=Integer.parseInt(request.getParameter("tablebook_quantity"));
	String day=request.getParameter("tablebook_day");
	String month=request.getParameter("tablebook_month");
	String year=request.getParameter("tablebook_year");
	String time=request.getParameter("tablebook_time");
	int sno=0;
	
	if(month.equals("Febuary") && (Integer.parseInt(day))>29){
		RequestDispatcher rd=request.getRequestDispatcher("tablebook.jsp?value=99");
		rd.forward(request,response);
	}
	if(month.equals("April") || month.equals("June") || month.equals("September") || month.equals("November")){
		if((Integer.parseInt(day))>30){
			RequestDispatcher rd=request.getRequestDispatcher("tablebook.jsp?value=98");
			rd.forward(request,response);
		}
	}
	
	if(month.equals("January"))
		month="01";
	if(month.equals("Febuary"))
		month="02";
	if(month.equals("March"))
		month="03";
	if(month.equals("April"))
		month="04";
	if(month.equals("May"))
		month="05";
	if(month.equals("June"))
		month="06";
	if(month.equals("July"))
		month="07";
	if(month.equals("August"))
		month="08";
	if(month.equals("September"))
		month="09";
	if(month.equals("October"))
		month="10";
	if(month.equals("November"))
		month="11";
	if(month.equals("December"))
		month="12";
	
	if(day.equals("1"))
		day="01";
	if(day.equals("2"))
		day="02";
	if(day.equals("3"))
		day="03";
	if(day.equals("4"))
		day="04";
	if(day.equals("5"))
		day="05";
	if(day.equals("6"))
		day="06";
	if(day.equals("7"))
		day="07";
	if(day.equals("8"))
		day="08";
	if(day.equals("9"))
		day="09";
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from tablebook");
	
	while(rs.next())
		sno++;
	
	String date=year+"-"+month+"-"+day;
	//out.println(date);
	
	SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date user_date=formatter.parse(date);
	java.util.Date sys_date=new java.util.Date();
	
	
	if(user_date.before(sys_date) || user_date.equals(sys_date)){
		RequestDispatcher rd=request.getRequestDispatcher("tablebook.jsp?value=99");
		rd.forward(request,response);
	}else{
		PreparedStatement ps=con.prepareStatement("insert into tablebook values(?,?,?,?,?)");
		ps.setInt(1, sno);
		ps.setString(2,username);
		ps.setInt(3,quantity);
		ps.setString(4,date);
		ps.setString(5,time);
		int k=ps.executeUpdate();
		if(k!=1){
			RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
			rd.forward(request,response);
		}else{
			RequestDispatcher rd=request.getRequestDispatcher("payment.jsp?payfor=tablebook&quantity="+quantity);
			rd.forward(request,response);
		}
	}
}catch(Exception ee){
	ee.printStackTrace();
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
}
%>

</body>
</html>