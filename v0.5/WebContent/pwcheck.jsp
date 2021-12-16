<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
String id = request.getParameter("id"); //id
String pw = request.getParameter("pw"); //pw

if (pw == null || pw.equals("") || id == null || id.equals(""))
{	//값이 없음
	out.print("00");
	return;
}

String sql = "";
sql += "select id,pw from user ";
sql += "where id='" + id + "' ";
sql += "and pw= md5('" + pw + "') ";
dbms.OpenQuery(sql);

if(dbms.GetNext() == true)
{ //값이 이미 있음
	dbms.CloseQuery();
	out.print("01");
	return;
} else
{	//틀림
	out.print("00");
}
dbms.CloseQuery();
%>
<%@ include file="./config/dbclose.jsp"%>