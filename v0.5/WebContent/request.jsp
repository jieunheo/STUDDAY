<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String send_email = request.getParameter("send_email");
String title = request.getParameter("title");
String body  = request.getParameter("body");
%>
<script>
	window.onload = function ()
	{
		$('#send_email').focus();
	}
</script>
<div class="main">
	<div class="request">
		<div class="wrap">
			<div class="text">
				<h3>Request</h3>
				<p>언제든 문의하실 내용 있으시면 폼 보내주세요 :)</p>
			</div>
			<form class="form" name="request" action="" method="post" onsubmit="return MailCheck();">
				<p><input id="send_email" type="email" name="send_email" placeholder="이메일" value="<%if(login != null){%><%=login.getEmail()%><%}%>"></p>
				<p><input id="title" type="text" name="title" placeholder="문의 제목"></p>
				<textarea id="body" name="body" placeholder="문의 내용"></textarea>
				<p><input class="btn" type="submit" value="문의하기"></p>
			</form>
			</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>