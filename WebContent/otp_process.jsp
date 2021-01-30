<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
int otp=Integer.parseInt(request.getParameter("otp_entered"));
int num=(int)session.getAttribute("random");
if(otp==num){
	RequestDispatcher rd=request.getRequestDispatcher("new_password.jsp?value=0");
	rd.forward(request,response);
}else{
	RequestDispatcher rd=request.getRequestDispatcher("verify_otp.jsp?value=99");
	rd.forward(request,response);
}
%>

</body>
</html>