<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>    
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
String kind  = request.getParameter("kind");  //검사할 값 종류
String value = request.getParameter("value"); //값

//아이디를 검사한다. 리턴값 : TRUE - 중복, FALSE - 중복아님
UserDTO dto = new UserDTO();

int code = dto.IsDuplicate(kind,value);
if(code == UserDTO.NOT_DUPLICATE)
{
	out.print("02");
}else if(code == UserDTO.DUPLICATE)
{
	out.print("01");
}else
{
	out.print("00");
}
%>