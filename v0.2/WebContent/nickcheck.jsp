<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname = request.getParameter("nickname");

if (nickname == null || nickname.equals(""))
{	//값이 없음
	out.print("none");
} else if (nickname.equals("test") || nickname.equals("ezen"))
{	//닉네임이 이미 있음
	out.print("isNick");
} else if(nickname.length() >= 4)
{	//사용 가능한 닉네임
	out.print("doNick");
}
%>