<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

String bno = request.getParameter("bno");   //게시물번호
String rno = request.getParameter("rno");   //댓글번호

if (bno == null || rno == null)
{	//값이 없음
	out.print("values None");
	return;
}

if(bno == "" || rno == "")
{
	out.print("values Empty");
	return;
}

String sql = "";
sql += "delete from reply ";
sql += "where ";
sql += "bno= '"+ bno + "' and ";
sql += "rno= '"+ rno + "' ";
dbms.RunSQL(sql);

out.print(bno);
%>
<%@ include file="./config/dbclose.jsp"%>