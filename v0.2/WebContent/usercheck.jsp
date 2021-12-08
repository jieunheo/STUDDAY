<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
String kind = request.getParameter("kind"); //검사할 값
String value   = request.getParameter("value");   //값

if (value == null || value.equals("") || value.length() < 4)
{	//값이 없음
	out.print("00");
	return;
}

String sql = "";
sql += "select " + kind + " from user where " + kind + " = '" + value + "'";
dbms.OpenQuery(sql);
if(dbms.GetNext() == true)
{ //이미 있음
	dbms.CloseQuery();
	out.print("01");
	return;
} else
{	//사용 가능
	dbms.CloseQuery();
	out.print("02");
	return;
}
%>