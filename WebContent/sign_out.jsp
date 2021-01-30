<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>Food Point | Online Based Food Ordering System</title>
<script type="text/javascript">
window.history.forward();
function onBack(){
	window.history.forward();
}
</script>
<script>setTimeout(function(){window.location.href='sign_out2.jsp'},3000);</script>
</head>
<body onload="onBack();" onpageshow="if (event.persisted) onBack();" onunload="">
<h1>Please Wait ...</h1>
<%
session.setAttribute("is_logged", "no");
%>

</body>
</html>