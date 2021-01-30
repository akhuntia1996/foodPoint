<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.io.*" %>
    <%@ page import="javax.mail.*" %>
    <%@ page import="javax.mail.internet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
try{
	String uname=request.getParameter("forget_username");
	String email=request.getParameter("forget_email");
	String mode=request.getParameter("forget_mode");
	
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");
	
		Statement st=con.createStatement();	
		ResultSet rs=st.executeQuery("select * from login where username='"+uname+"' and email='"+email+"'");
		if(rs.next()){
			session.setAttribute("username", uname);
			
			if(mode.equals("none")){
				RequestDispatcher rd=request.getRequestDispatcher("forget.jsp?value=90");
				rd.forward(request,response);
			}
			if(mode.equals("offline")){
				RequestDispatcher rd=request.getRequestDispatcher("new_password.jsp?value=0");
				rd.forward(request,response);
			}
			if(mode.equals("online")){
				Random rn=new Random();
				int num=rn.nextInt(99999)+1;
		
				final String username = "obfssapex@gmail.com"; // enter your mail id
				final String password = "obfss2014";// enter ur password
		
				Properties props = new Properties();
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.port", "587");
		
				Session sess = Session.getInstance(props,new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				});
		
				try{
					Message message = new MimeMessage(sess);
					message.setFrom(new InternetAddress("obfssapex@gmail.com")); // same email id
					message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(email));// whome u have to send mails that person id
					message.setSubject("Online Based Food Serving System: PASSWORD RECOVERY");
					//message.setText("<h1>Dear Mail Crawler</h1>,"+ "\n\n No spam to my email, please!");
					message.setContent("Your OTP :<br><h1>"+num+"</h1>","text/html");
					Transport.send(message);
					System.out.println("Email Done Sucessfully");
				}catch (MessagingException e){
					RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
					rd.forward(request,response);
					e.printStackTrace();
				}
				
				session.setAttribute("random", num);
				RequestDispatcher rd=request.getRequestDispatcher("verify_otp.jsp?value=0");
				rd.forward(request,response);
			}else{
				RequestDispatcher rd=request.getRequestDispatcher("forget.jsp?value=99");
				rd.forward(request,response);
			}
		}
}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
	ee.printStackTrace();
}
%>

</body>
</html>