<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
if(login == null)
{
	%>
	<script>
		alert('로그인 후 이용이 가능합니다.');
		document.location = 'login.jsp';
	</script>
	<%
}

String sql = "";

sql += "select no,id,nickname,email,join_date,user_rank,jop,interest,intro,page from user where no = '" + login.getNo() + "' ";
dbms.OpenQuery(sql);
dbms.GetNext();
String no = login.getNo();
String id = dbms.GetValue("id");
String nick = dbms.GetValue("nickname");
String email = dbms.GetValue("email");
String join_date = dbms.GetValue("join_date");
String user_rank = dbms.GetValue("user_rank");
String jop = dbms.GetValue("jop");
String interest = dbms.GetValue("interest");
String intro = dbms.GetValue("intro");
String homepage = dbms.GetValue("page");
dbms.CloseQuery();

if(jop == null) jop = "";
if(interest == null) interest = "";
if(intro == null) intro = "";
if(homepage == null) homepage = "";
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
		
		return PwChack();
	}
	
	function PwChack()
	{
		
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}
	
	function Secession()
	{
		if(!confirm('정말 탈퇴하시겠습니까?')) return false;
		
		$.ajax({
			type: "get",
			url: "secession.jsp?no=<%= no %>",
			dataType: "html",
			success: function(data) {
				alert('탈퇴되었습니다.');
				window.location = "index.jsp";
			}
		});
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
							<p><span>아이디</span> <%= id %></p>
							<p><span>비밀번호</span> <input type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>닉네임</span> <%= nick %><%if(user_rank.equals("A")){%>(A)<%}%></p>
							<p><span>email</span> <%= email %></p>
							<p><span>가입일시</span> <%= join_date %></p>
							<hr>
							<p><span>직업</span> <%= jop %></p>
							<p><span>관심사</span> <%= interest %></p>
							<p><span>자기소개</span> <%= intro %></p>
							<p><span>홈페이지</span> <%= homepage %></p>
							<p><input class="btn" type="submit" value="정보수정"></p>
							<p><a href="javascript:Secession();">회원 탈퇴</a></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>