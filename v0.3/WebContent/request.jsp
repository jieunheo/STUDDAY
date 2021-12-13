<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="request">
		<div class="wrap">
			<div class="text">
				<h3>Request</h3>
				<p>언제든 문의하실 내용 있으시면 폼 보내주세요 :)</p>
			</div>
			<form class="form" name="request" action="">
				<p><input type="email" name="email" placeholder="이메일"></p>
				<p><input type="text" name="title" placeholder="문의 제목"></p>
				<textarea name="content" placeholder="문의 내용"></textarea>
				<p><input type="button" value="문의하기" onclick="javascript:ready();"></p>
			</form>
			</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>