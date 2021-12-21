<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

/* 값 받아오기 */
String id = request.getParameter("id"); //아이디
String pw = request.getParameter("pw"); //비밀번호

UserDTO dto   = new UserDTO();
UserVO  login = dto.Login(id,pw);

if( login != null)
{
	//로그인 성공
	session.setAttribute("login", login);
	out.print("TRUE");
}else
{
	//로그인 실패
	out.print("FALSE");
}
%>