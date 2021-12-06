<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
window.onload = function()
{
	document.join.id.focus();
}

function OnFocus(value)
{
	value.focus();
}

function FormCheck()
{
	if(document.join.id.value == "")
	{
		alert('아이디를 입력해주세요.');
		OnFocus(document.join.id);
		return false;
	}
	
	if(document.join.pw.value == "")
	{
		alert('비밀번호를 입력해주세요.');
		OnFocus(document.join.pw);
		return false;
	}
	
	if(document.join.pw.value != document.join.pwok.value)
	{
		alert('비밀번호가 일치하지 않습니다.');
		OnFocus(document.join.pw);
		return false;
	}
	
	if(document.join.nickname.value == "")
	{
		alert('닉네임을 입력해주세요.');
		OnFocus(document.join.pw);
		return false;
	}
	
	if(document.join.email.value == "")
	{
		alert('이메일을 입력해주세요.');
		OnFocus(document.join.email);
		return false;
	}
}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category join">
					<p>Join</p>
				</div>
				<div>
					<form class="join" name="join" method="post" action="joinok.jap" onsubmit="return FormCheck();">
						<p><input type="text" name="id" placeholder="아이디"></p>
						<p><input type="password" name="pw" placeholder="비밀번호"></p>
						<p><input type="password" name="pwok" placeholder="비밀번호확인"></p>
						<p><input type="text" name="nickname" placeholder="닉네임"></p>
						<p><input type="email" name="email" placeholder="hong@naver.com"></p>
						<p><input class="btn" type="submit" value="회원가입"></p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>