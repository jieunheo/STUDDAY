<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp" %>
<%
String kind  = request.getParameter("kind");  //검사할 값 종류
String value = request.getParameter("value"); //값

if (value == null || value.equals(""))
{	//값이 없음
	out.print("00");
	return;
}

String sql = "";
sql += "select " + kind + " from user where " + kind + " = '" + value + "'";
dbms.OpenQuery(sql);

if(dbms.GetNext() == true)
{ //값이 이미 있음
	dbms.CloseQuery();
	out.print("01");
	return;
} else
{	
	if( (!kind.equals("nickname") && value.length() < 4) || (kind.equals("nickname") && value.length() < 2) )
	{
		out.print("00");
		return;
	}
	
	//사용 가능
	out.print("02");
}
dbms.CloseQuery();
%>
<%@ include file="./config/dbclose.jsp" %>