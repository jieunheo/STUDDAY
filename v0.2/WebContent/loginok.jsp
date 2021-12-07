<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
id = request.getParameter("id");
String pw = request.getParameter("pw");

if(id == null || pw == null)
{
	%>
	<script>
		alert('잘못된 접근입니다. 로그인해주세요.');
		document.location = 'login.jsp';
	</script>
	<%
}

if(id == "" || pw == "")
{
	%>
	<script>
		alert('아이디 또는 비밀번호가 입력되지 않았습니다.');
		document.location = 'login.jsp';
	</script>
	<%
}

session.setAttribute("id", id);
session.setAttribute("nickname", "pongdang");
%>
<script>
	alert('로그인 되었습니다.');
	document.location = 'index.jsp';
</script>
<%@ include file="./include/footer.jsp" %>