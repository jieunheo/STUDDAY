<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- dbms 열기 -->
<%@ include file="../config/dbopen.jsp" %>
<%
LoginVO login = (LoginVO)session.getAttribute("login");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>STUDDAY</title>
		<!-- 제이쿼리 -->
		<script src="./js/jquery-3.6.0.js"></script>
		<!-- 외부 js -->
		<script src="./js/script.js"></script>
		<!-- 외부 css -->
		<link href="./css/style.css" rel="stylesheet">
	</head>
	<body>
		<header class="clearfix">
			<div class="wrap">
				<h1 class="logo"><a href="index.jsp"></a></h1>
				<div class="info_wrap">
				<%
				if(login == null) {
				%>
					<a href="join.jsp">JOIN</a>&nbsp;|&nbsp;
					<a href="login.jsp">LOGIN</a>
				<%
				} else {
				%>
					<a href="info.jsp">INFO</a>&nbsp;|&nbsp;
					<a href="logout.jsp">LOGOUT</a>
				<%
				}
				%>
				</div>
				<div class="nav">
					<ul>
						<li><a href="howto.jsp">How To</a></li>
						<li>
							<a href="study.jsp">Study</a>
							<ul class="sub_nav">
								<li><a href="study.jsp?kinds=1">With Us</a></li>
								<li><a href="study.jsp?kinds=2">Lecture</a></li>
								<li><a href="study.jsp?kinds=3">Reference</a></li>
								<li><a href="study.jsp?kinds=4">Tip</a></li>
								<li><a href="study.jsp?kinds=5">Q&A</a></li>
							</ul>
						</li>
						<li><a href="study.jsp?kinds=9">Talk</a></li>
						<li>
							<a href="study.jsp?kinds=0">Contact</a>
							<ul class="sub_nav">
								<li><a href="study.jsp?kinds=0">Notice</a></li>
								<li><a href="request.jsp">Request</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</header>