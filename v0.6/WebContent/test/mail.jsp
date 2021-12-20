<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.*" %>    
<%
request.setCharacterEncoding("UTF-8");

String send_email = request.getParameter("send_email");
String title = request.getParameter("title");
String body  = request.getParameter("body");

if(send_email == null) send_email = "";
if(title == null) title = "";
if(body == null)  body = "";

if(!send_email.equals("") || !title.equals("") || !body.equals(""))
{
	title = "[STUDDAY: " + send_email + "] "+title;
	MailVO vo = new MailVO(title,body);
	vo.SendMail();
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<form name="mailto" method="post" action="">
			보내는 사람 이메일: <input  type="text" name="send_email"><br>
			제목: <input  type="text" name="title"><br>
			내용: <input  type="text" name="body"><br>
			<input  type="submit" value="보내기"><br>
		</form>
	</body>
</html>