<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sign = (String)session.getAttribute("sign");
out.print(sign);
%>