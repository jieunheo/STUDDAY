<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>    
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>STUDDAY</title>
		<!-- 제이쿼리 -->
		<script src="/Studday0.6/js/jquery-3.6.0.js"></script>
		<!-- 외부 js -->
		<script src="/Studday0.6/js/script.js"></script>
		<!-- 외부 css -->
		<link href="/Studday0.6/css/style.css" rel="stylesheet">
	</head>
	<body>
		<header class="clearfix">
			<div class="wrap">
				<h1 class="logo"><a href="/Studday0.6/index.jsp"></a></h1>
				<div class="info_wrap">
				<%
				if (login == null)
				{
					%>
					<a href="/Studday0.6/member/join.jsp">JOIN</a>&nbsp;|&nbsp;
					<a href="/Studday0.6/login/login.jsp">LOGIN</a>
					<%
				} else
				{
					%>
					<a href="/Studday0.6/member/info.jsp">INFO</a>&nbsp;|&nbsp;
					<a href="/Studday0.6/login/logout.jsp">LOGOUT</a>
					<%
				}
				%>
				</div>
				<div class="nav">
					<ul>
						<li><a href="/Studday0.6/main/howto.jsp">How To</a></li>
						<li>
							<a href="/Studday0.6/main/study.jsp">Study</a>
							<ul class="sub_nav">
								<li><a href="/Studday0.6/main/study.jsp?kinds=1">With Us</a></li>
								<li><a href="/Studday0.6/main/study.jsp?kinds=2">Lecture</a></li>
								<li><a href="/Studday0.6/main/study.jsp?kinds=3">Reference</a></li>
								<li><a href="/Studday0.6/main/study.jsp?kinds=4">Tip</a></li>
								<li><a href="/Studday0.6/main/study.jsp?kinds=5">Q&A</a></li>
							</ul>
						</li>
						<li><a href="/Studday0.6/main/study.jsp?kinds=9">Talk</a></li>
						<li>
							<a href="/Studday0.6/main/study.jsp?kinds=0">Contact</a>
							<ul class="sub_nav">
								<li><a href="/Studday0.6/main/study.jsp?kinds=0">Notice</a></li>
								<li><a href="/Studday0.6/main/request.jsp">Request</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</header>