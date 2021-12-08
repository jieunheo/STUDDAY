<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nickname = request.getParameter("nick");

if (nickname == null || nickname.equals("") || nickname.length() < 4)
{	//값이 없음
	out.print("00");
} else if (nickname.equals("nick") || nickname.equals("ezen"))
{	//닉네임이 이미 있음
	out.print("01");
} else if(nickname.length() >= 4)
{	//사용 가능한 닉네임
	out.print("02");
}
%>