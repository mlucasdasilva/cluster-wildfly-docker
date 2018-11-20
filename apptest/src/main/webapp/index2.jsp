<%-- 
    Document   : index
    Created on : Jan 5, 2017, 10:48:32 PM
    Author     : eldermoraes
--%>

<%@ page import="java.net.InetAddress"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<% 

Cookie[] cookies = request.getCookies();
if (cookies == null)
  cookies = new Cookie[0];
Date thisVisit = new Date();
// add data cookie to session
Cookie c = new Cookie("lastVisit",""+thisVisit);
response.addCookie(c);
// add cookie to session
String name = request.getParameter("name");
String value = request.getParameter("value");
Cookie added = null;
if (name!=null && value!=null && name.length()>0) {
  added = new Cookie(name,value);
  if (value == "") {
	  added.setMaxAge(0);
  }
  response.addCookie(added);
}

HttpSession session2 = request.getSession();
if (request.getParameter("JSESSIONID") != null) {
    Cookie userCookie = new Cookie("JSESSIONID", request.getParameter("JSESSIONID"));
    response.addCookie(userCookie);
} else {
    String sessionId = session2.getId();
    Cookie userCookie = new Cookie("JSESSIONID", sessionId);
    response.addCookie(userCookie);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cluster Test</title>
</head>
<body>
<center>
    <p id="welcome"></p>
	<h1>apptest v0.4</h1>
	<h1>The request is being answered by:</h1>
	<h2><font color="red">IP: <%=InetAddress.getLocalHost().getHostAddress()%></font></h2>
	<h2><font color="blue">HostName: <%=InetAddress.getLocalHost().getCanonicalHostName() %></font></h2>
        <h2><font color="green">Session ID: <%=request.getSession().getId() %></font></h2>
		<font color="maroon"><p id="demo"></p></font>
<script>
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

document.getElementById("demo").innerHTML = "Cookies(js):  " + document.cookie;

var username = getCookie("username");
if (username != "") {
    document.getElementById("welcome").innerHTML = "Bem-vindo:  " + username;
} else {
   document.cookie = "username=John Doe";
}

</script>
</center>

<H3><font color="blue">Cokie Info:</font></H2>
<p><font color="black">
This visit: <%= thisVisit %><BR>
Number of cookies: <%= cookies.length %><BR>
</font></p>
<H3><font color="blue">Cookie List:</font></H3>
<p>
<%
for (int i=0; i<cookies.length; i++) {
  if ( cookies[i].getName() == name ) { 
      if ( value == "" ) {
          cookies[i].setMaxAge(0);
	  } else {
  	      cookies[i].setValue(value);
	  }
  }
  out.println(cookies[i].getName()+":\t"+
    cookies[i].getValue()+"<BR>");
  // check if added cookie already present
  if (added!=null && added.getName().equals(cookies[i].getName()))
    added = null;
}
if (added != null && value != "")
  out.println("new cookie: "+added.getName()+":\t"+
    added.getValue()+"<BR>");
%>
</p>
<H3><font color="red">Add/Update cookie</font></H2>
<FORM>
  <P>Name: <INPUT TYPE='TEXT' NAME='name'></P>
  <P>Value: <INPUT TYPE='TEXT' NAME='value'>(blank value will remove cookie)</p>
  <INPUT TYPE='SUBMIT' VALUE='Add new value'>
</FORM>


</body>
</html>


