<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
window.onload = function()
{
	document.login.id.focus();
}

function OnFocus(value)
{
	value.focus();
}

function FormCheck()
{
	if(document.login.id.value == "")
	{
		alert('아이디를 입력해주세요.');
		OnFocus(document.login.id);
		return false;
	}
	
	if(document.login.pw.value == "")
	{
		alert('비밀번호를 입력해주세요.');
		OnFocus(document.login.pw);
		return false;
	}
}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category login">
					<p>Login</p>
				</div>
				<div>
					<form class="login" name="login" method="post" action="loginok.jsp" onsubmit="return FormCheck();">
						<p><input type="text" name="id" placeholder="아이디"></p>
						<p><input type="password" name="pw" placeholder="비밀번호"></p>
						<p><input class="btn" type="submit" value="로그인"></p>
						<p><a href="join.jsp">회원가입</a></p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>