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
try{
	String username=request.getParameter("register_username");
	String password=request.getParameter("register_password");
	String confirm_password=request.getParameter("register_confirm_password");
	String email=request.getParameter("register_email");
	int sno=0;
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost/foodpoint_db","root","");

	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from login");
	int flag=0;
	while(rs.next()){
		if(rs.getString(2).equals(username)){
			RequestDispatcher rd=request.getRequestDispatcher("register.jsp?value=97");
			rd.forward(request,response);
			flag=1;
		}
	}
	
	rs=st.executeQuery("select * from login");
	while(rs.next()){
		sno++;
	}sno++;

	java.util.Date dt=new java.util.Date();
	java.sql.Date date1=new Date(dt.getTime());
	java.sql.Time time=new Time(dt.getTime());
	
	String encryptStr=encrypt(password);
	
	if(password.equals(confirm_password) && flag==0){
		PreparedStatement ps=con.prepareStatement("insert into login values(?,?,?,?,?)");
		ps.setInt(1,sno);
		ps.setString(2,username);
		ps.setString(3,encryptStr);
		ps.setString(4,email);
		ps.setDate(5,date1);
		int k=ps.executeUpdate();
		if(k!=1){
			RequestDispatcher rd=request.getRequestDispatcher("error.jsp");
			rd.forward(request,response);
		}else{
			RequestDispatcher rd=request.getRequestDispatcher("register.jsp?value=99");
			rd.forward(request,response);
		}
	}else{
		RequestDispatcher rd=request.getRequestDispatcher("register.jsp?value=98");
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