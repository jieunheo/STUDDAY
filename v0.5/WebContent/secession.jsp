<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp"%>
<%
//회원 탈퇴
String no = request.getParameter("no"); //회원번호

if (no == null || no.equals(""))
{
	return;
}

String sql = "";

sql += "select no from user name where no = " + no + "and retire = 'N'";
dbms.OpenQuery(sql);
if(dbms.GetNext() == false)
{
	dbms.CloseQuery();
	out.print("탈퇴할 수 없는 회원입니다.");
	return;
}
dbms.CloseQuery();
sql = "";
sql += "update user set retire = 'Y' where no=" + no;
dbms.RunSQL(sql);



session.removeAttribute("login");
%>
<%@ include file="./config/dbclose.jsp"%>