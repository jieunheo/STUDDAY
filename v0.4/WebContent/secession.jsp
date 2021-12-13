<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
String no = request.getParameter("no"); //회원번호

if (no == null || no.equals(""))
{
	return;
}

String sql = "";
sql += "update user set retire = 'Y' where no=" + no;
dbms.RunSQL(sql);

session.removeAttribute("login");
%>
<%@ include file="./config/dbclose.jsp"%>