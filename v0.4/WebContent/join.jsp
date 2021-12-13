<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
	window.onload = function()
	{
		document.join.id.focus();
		
		/* 실시간으로 값이 있는지 확인 */
		//아이디값 확인
		ValueCheck(id);
		//닉네임값 확인
		ValueCheck(nickname);
		//이메일값 확인
		ValueCheck(email);
	}
	
	/* join 버튼 클릭 시 폼 체크 */
	function FormCheck()
	{
		if(document.join.id.value == "")
		{
			alert('아이디를 입력해주세요.');
			document.join.id.focus();
			return false;
		}	else if(document.join.id.value.length < 4)
		{
			alert('아이디를 4글자 이상 입력해주세요');
			document.join.id.focus();
			return false;
		}
		
		if(document.join.pw.value == "")
		{
			alert('비밀번호를 입력해주세요.');
			document.join.pw.focus();
			return false;
		}	else if(document.join.pw.value.length < 4)
		{
			alert('비밀번호를 4글자 이상 입력해주세요');
			document.join.id.focus();
			return false;
		}
		
		if(document.join.pw.value != document.join.pwok.value)
		{
			alert('비밀번호가 일치하지 않습니다.');
			document.join.pw.focus();
			return false;
		}
		
		if(document.join.nickname.value == "")
		{
			alert('닉네임을 입력해주세요.');
			document.join.nickname.focus();
			return false;
		}	else if(document.join.nickname.value.length < 2)
		{
			alert('닉네임을 2글자 이상 입력해주세요');
			document.join.nickname.focus();
			return false;
		}
		
		if(document.join.email.value == "")
		{
			alert('이메일을 입력해주세요.');
			document.join.email.focus();
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
					<form class="join" name="join" method="post" action="reinfook.jsp" onsubmit="return FormCheck();">
						<p><input id="id" type="text" name="id" placeholder="아이디"></p>
						<p><input id="pw" type="password" name="pw" placeholder="비밀번호"></p>
						<p><input id="pwok" type="password" name="pwok" placeholder="비밀번호확인"></p>
						<p><input id="nickname" type="text" name="nickname" placeholder="닉네임"></p>
						<p><input id="email" type="email" name="email" placeholder="hong@naver.com"></p>
						<p><input class="btn" type="submit" value="회원가입"></p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>