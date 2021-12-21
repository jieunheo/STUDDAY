<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id"); //id
String pw = request.getParameter("pw"); //pw

if (pw == null || pw.equals("") || id == null || id.equals(""))
{	//값이 없음
	out.print("FALSE");
	return;
}

UserDTO dto = new UserDTO();
int pwCheck = dto.IsPwCheck(id,pw);
if(pwCheck == UserDTO.PW_OK)
{
	out.print("TRUE");
} else
{
	out.print("FALSE");
}
%>