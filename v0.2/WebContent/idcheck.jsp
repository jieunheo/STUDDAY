<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

if (id == null || id.equals(""))
{	//값이 없음
	out.print("none");
} else if (id.equals("test") || id.equals("ezen"))
{	//아이디가 이미 있음
	out.print("isID");
} else if(id.length() >= 4)
{	//사용 가능한 아이디
	out.print("doID");
}
%>