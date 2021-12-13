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
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category reinfo">
					<p>Re Info</p>
				</div>
				<div>
					<div class="reinfo">
						<form name="reinfo" method="post" action="reinfook.jsp" onsubmit="return FormCheck();">
							<p><span>아이디</span> test</p>
							<p><span>비밀번호</span> <input type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>닉네임</span>  <input type="text" name="nickname" placeholder="닉네임" value="pongdang"></p>
							<p><span>email</span> <input type="email" name="nickname" placeholder="ex)hong@naver.com" value="hong@naver.com"></p>
							<p><span>가입일시</span> 2021-12-12</p>
							<hr>
							<p><span>직업</span> <input type="text" name="job" placeholder="ex)개발자" value=""></p>
							<p><span>관심사</span> <input type="text" name="interest" placeholder="ex)JAVA, SQL" value=""></p>
							<p><span>자기소개</span> <input type="text" name="intro" placeholder="ex)본인 소개를 해주세요" value=""></p>
							<p><span>홈페이지</span> <input type="text" name="page" placeholder="ex)블로그 주소, 깃 주소 등" value=""></p>
							<p><input class="btn" type="submit" value="수정완료"></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>