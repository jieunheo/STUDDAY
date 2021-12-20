<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String send_email = request.getParameter("send_email");
String title = request.getParameter("title");
String body  = request.getParameter("body");

if(send_email == null || title == null || body == null)
{
	%>
	<script>
		alert('값이 비었습니다!');
		window.location = "request.jsp";
	</script>
	<%
	return;
}

if(!send_email.equals("") && !title.equals("") && !body.equals(""))
{
	title = "[STUDDAY: " + send_email + "] "+title;
	MailVO vo = new MailVO(title,body);
	try
	{
		vo.SendMail();
		out.print("01");
	}catch(Exception e)
	{
		out.print("00");
	}
} else {
	out.print("00");
}
%>
<%@ include file="./config/dbclose.jsp" %>