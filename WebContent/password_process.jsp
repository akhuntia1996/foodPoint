<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
    <%@page import=" java.security.*"%>
    <%@page import=" java.io.*"%>
    <%@page import="javax.crypto.*"%>
    <%@page import="javax.crypto.spec.*"%>
<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="sun.misc.BASE64Encoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!
private static final String ALGORITHM = "AES";
private static final String KEY = "1Hbfh667adfDEJ78";
private static Key generateKey() throws Exception 
{
    Key key = new SecretKeySpec(KEY.getBytes(),ALGORITHM);
    return key;
}
public static String encrypt(String value) throws Exception
{
    Key key = generateKey();
    Cipher cipher = Cipher.getInstance(ALGORITHM);
    cipher.init(Cipher.ENCRYPT_MODE, key);
    byte [] encryptedByteValue = cipher.doFinal(value.getBytes("utf-8"));
    String encryptedValue64 = new BASE64Encoder().encode(encryptedByteValue);
    return encryptedValue64;
           
}
%>
<%!
public static String decrypt(String value) throws Exception
{
    Key key = generateKey();
    Cipher cipher = Cipher.getInstance(ALGORITHM);
    cipher.init(Cipher.DECRYPT_MODE, key);
    byte [] decryptedValue64 = new BASE64Decoder().decodeBuffer(value);
    byte [] decryptedByteValue = cipher.doFinal(decryptedValue64);
    String decryptedValue = new String(decryptedByteValue,"utf-8");
    return decryptedValue;
            
}
%>


<%
String pass=request.getParameter("forget_password");
String pass1=request.getParameter("forget_confirm_password");
String username=(String)session.getAttribute("username");

try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

if(pass1.equals(pass)){
	String encryptStr=encrypt(pass);
	PreparedStatement ps=con.prepareStatement("update login set password='"+encryptStr+"' where username='"+username+"'");
	int k=ps.executeUpdate();
	if(k==1){
		RequestDispatcher rd=request.getRequestDispatcher("new_password.jsp?value=98");
		rd.forward(request,response);
	}else{
		RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
		rd.forward(request,response);
	}
}else{
	RequestDispatcher rd=request.getRequestDispatcher("new_password.jsp?value=99");
	rd.forward(request,response);
}
}catch(Exception ee){
	RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
	rd.forward(request,response);
	ee.printStackTrace();
}
%>

</body>
</html>