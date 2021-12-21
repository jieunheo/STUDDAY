<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
//회원 탈퇴
String no = request.getParameter("no"); //회원번호

if (no == null || no.equals(""))
{
	return;
}

UserDTO dto = new UserDTO();
if(dto.Delete(login))
{
	//회원 탈퇴 완료
	%>
	01
	<%
} else
{
	%>
	00
	<%
}
%>