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

//해당 회원이 있는지 확인
sql += "select no ";
sql += "from user ";
sql += "where no = " + no + " ";
sql += "and retire = 'N'";
dbms.OpenQuery(sql);
if(dbms.GetNext() == false)
{
	//없으면 00 리턴
	dbms.CloseQuery();
	out.print("00");
	return;
}
dbms.CloseQuery();

//탈퇴 정보 수정
sql = "";
sql += "update user ";
sql += "set retire = 'Y' ";
sql += "where no=" + no;
dbms.RunSQL(sql);

//해당 세션 지우기
session.removeAttribute("login");
%>
<script>
	alert('탈퇴했습니다. 감사합니다 :)');
	window.location = "index.jsp";
</script>
<%@ include file="./config/dbclose.jsp"%>