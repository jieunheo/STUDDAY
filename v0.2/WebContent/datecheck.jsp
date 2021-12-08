<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
String value   = request.getParameter("value");   //값

if (value.length() < 4)
{	//값이 없음
	out.print(value);
	return;
} else if(value.length() == 4)
{
	out.print(value + "-");
}


%>