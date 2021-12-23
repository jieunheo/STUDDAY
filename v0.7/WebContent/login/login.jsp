<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
window.onload = function()
{
	document.login.id.focus();
}

function FormCheck()
{
	if(document.login.id.value == "")
	{
		alert('아이디를 입력해주세요.');
		document.login.id.focus();
		return false;
	}
	
	if(document.login.pw.value == "")
	{
		alert('비밀번호를 입력해주세요.');
		document.login.pw.focus();
		return false;
	}
	
	var param = "";
	param  = "id=" + $("#id").val();
	param += "&";
	param += "pw=" + $("#pw").val();
	
	$.ajax({
		type : "get",
		url: "loginok.jsp?" + param,
		dataType: "html",
		success : function(data)
		{
			data = data.trim();
			if(data == "TRUE")
			{
				window.location = "/Studday0.6/index.jsp";	
			}else
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#id").focus();
			}
		}
	});
	return false;
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
						<p><input id="id" type="text" name="id" placeholder="아이디"></p>
						<p><input id="pw" type="password" name="pw" placeholder="비밀번호"></p>
						<p><input class="btn" type="submit" value="로그인"></p>
						<p><a href="../member/join.jsp">회원가입</a></p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>