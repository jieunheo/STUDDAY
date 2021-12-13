<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
session.removeAttribute("login");
%>
<script>
	alert('로그아웃 되었습니다.');
	document.location = 'index.jsp';
</script>
<%@ include file="./include/footer.jsp" %>