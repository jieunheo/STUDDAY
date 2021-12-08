<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
id = request.getParameter("id");
String pw = request.getParameter("pw");
String nick = request.getParameter("nickname");
String email = request.getParameter("email");

if(id == null || pw == null || nick == null || email == null)
{
	%>
	<script>
		alert('잘못된 접근입니다. 로그인해주세요.');
		document.location = 'login.jsp';
	</script>
	<%
}

if(id == "" || pw == "" || nick == null || email == null)
{
	%>
	<script>
		alert('필요한 정보가 일부 입력되지 않았습니다.');
		document.location = 'login.jsp';
	</script>
	<%
}
%>
<script>
	if(confirm('회원가입이 완료 되었습니다. 바로 로그인하시겠습니까?') == true)
	{
		<%
		session.setAttribute("id", id);
		session.setAttribute("nickname", nick);
		%>
		alert('로그인 되었습니다.');
		document.location = 'index.jsp';
	}
	document.location = 'index.jsp';
</script>
<%@ include file="./include/footer.jsp" %>