<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
	document.onload = function()
	{
		document.info.pw.focus();
	}
	
	function FormCheck()
	{
		if(document.info.pw.value == "")
		{
			alert('비밀번호를 입력해주세요');
			document.info.pw.focus();
			return false;
		}
		
		return PwChack();
	}
	
	function PwChack()
	{
		
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category info">
					<p>Info</p>
				</div>
				<div>
					<div class="info">
						<form name="info" method="post" action="reinfo.jsp" onsubmit="return FormCheck();">
							<p><span>아이디</span> ezen</p>
							<p><span>비밀번호</span> <input type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>닉네임</span> 관리자(A)</p>
							<p><span>email</span> ezen@ezen.com</p>
							<p><span>가입일시</span> 2021-12-01</p>
							<hr>
							<p><span>직업</span> </p>
							<p><span>관심사</span> JAVA, Javscript</p>
							<p><span>자기소개</span> </p>
							<p><span>홈페이지</span> </p>
							<p><input class="btn" type="submit" value="정보수정"></p>
							<p><a href="#">회원 탈퇴</a></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>