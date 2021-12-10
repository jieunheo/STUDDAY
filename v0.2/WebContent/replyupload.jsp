<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

String bno      = request.getParameter("bno");   //게시물번호
String no       = request.getParameter("no");    //작성자번호
String rpost    = request.getParameter("rpost"); //댓글내용

if (bno == null || no == null || rpost == null)
{	//값이 없음
	out.print("values None");
	return;
}

if(bno == "" || no == "" || rpost == "")
{
	out.print("values Empty");
} else
{
	String sql = "";
	sql += "insert into reply (bno,no,rpost) ";
	sql += "values ('" + bno + "','" + no + "','" + rpost + "') ";
	dbms.RunSQL(sql);
}
%>