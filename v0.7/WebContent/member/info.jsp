<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%
/* 권한 검사 */
if(login == null )
{
	%>
	<script>
		alert('로그인 후 이용이 가능합니다.');
		window.location = '/Studday0.6/login/login.jsp';
	</script>
	<%
}
%>
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

		var pw = $('#pw').val();
		//비밀번호 맞는지 확인
		$.ajax({
			type: "get",
			url: "pwcheck.jsp?id=<%= login.getId() %>&pw=" + pw,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				if(data != "TRUE")
				{
					alert('비밀번호가 일치하지 않습니다.');
					return false;
				} else {
					window.location = "reinfo.jsp";
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
				<div class="category info">
					<p>Info</p>
				</div>
				<div>
					<div class="info">
						<form name="info" method="post" action="reinfo.jsp" onsubmit="return FormCheck();">
							<p><span>아이디</span> ${ login.id }</p>
							<p><span>비밀번호</span> <input id="pw" type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>닉네임</span> ${ login.nickname } (${ login.user_rank })</p>
							<p><span>email</span> ${ login.email }</p>
							<p><span>가입일시</span> ${ login.join_date.split(' ')[0] }</p>
							<hr>
							<p><span>직업</span> ${ login.jop }</p>
							<p><span>관심사</span> ${ login.interest }</p>
							<p><span>자기소개</span> ${ login.intro }</p>
							<p><span>홈페이지</span><a href="http://${ login.homepage }">${ login.homepage }</a>
							</p>
							<p><input class="btn" type="submit" value="정보수정"></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>