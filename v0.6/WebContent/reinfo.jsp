<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
/* 권한 검사 */
if(login == null)
{
	%>
	<script>
		alert('로그인 후 이용이 가능합니다.');
		window.location = 'login.jsp';
	</script>
	<%
}

String sql = "";
sql += "select no,id,nickname,email,join_date,";
sql += "user_rank,jop,interest,intro,page ";
sql += "from user ";
sql += "where no = '" + login.getNo() + "' ";
dbms.OpenQuery(sql);
if(!dbms.GetNext()) {
	dbms.CloseQuery();
	%>
	<script>
		alert('정상적인 회원이 아닙니다.');
		window.location = 'login.jsp';
	</script>
	<%
}

String no        = login.getNo();              //회원번호
String id        = dbms.GetValue("id");        //아이디
String nickname  = dbms.GetValue("nickname");  //닉네임
String email     = dbms.GetValue("email");     //이메일
String join_date = dbms.GetValue("join_date"); //가입일
String user_rank = dbms.GetValue("user_rank"); //권한
String jop       = dbms.GetValue("jop");       //직업
String interest  = dbms.GetValue("interest");  //관심사
String intro     = dbms.GetValue("intro");     //자기소개
String homepage  = dbms.GetValue("page");      //홈페이지
dbms.CloseQuery();

if(jop == null)      jop = "";
if(interest == null) interest = "";
if(intro == null)    intro = "";
if(homepage == null) homepage = "";
%>
<script>
	window.onload = function()
	{
		document.reinfo.pw.focus();
		
		//닉네임값 확인
		ValueCheck(nickname);
		//이메일값 확인
		ValueCheck(email);
	}
	
	function FormCheck()
	{
		if(document.reinfo.pw.value != document.reinfo.pwok.value)
		{
			alert('비밀번호가 일치하지 않습니다.');
			document.reinfo.pw.focus();
			return false;
		}
		
		if(document.reinfo.nickname.value == "")
		{
			alert('닉네임을 입력해주세요.');
			document.reinfo.nickname.focus();
			return false;
		}	else if(document.reinfo.nickname.value.length < 2)
		{
			alert('닉네임을 2글자 이상 입력해주세요');
			document.reinfo.nickname.focus();
			return false;
		}
		
		if(document.reinfo.email.value == "")
		{
			alert('이메일을 입력해주세요.');
			document.reinfo.email.focus();
			return false;
		}
	}
	
	function Secession(no)
	{
		if(confirm('탈퇴하시면 해당 정보로 다시 가입이 불가합니다.\n정말 탈퇴하시겠습니까?'))
		{
			$.ajax({
				type: "get",
				url: "secession.jsp?no=" + no,
				dataType: "html",
				success: function(data) {
					data = data.trim();
					if(data == "00")
					{
						alert('탈퇴할 수 없는 회원입니다.');
						return false;
					} else {
						alert('탈퇴 되었습니다.');
						document.location = "index.jsp";
					}
				}
			});
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
							<p><span>아이디</span> <%= id %></p>
							<p><span>비밀번호</span> <input type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>비밀번호 확인</span> <input type="password" name="pwok" placeholder="비밀번호 확인"></p>
							<p><span>닉네임</span>  <input id="nickname" type="text" name="nickname" placeholder="닉네임" value="<%= nickname %>"></p>
							<p><span>email</span> <input id="email" type="email" name="email" placeholder="ex)hong@naver.com" value="<%= email %>"></p>
							<p><span>가입일시</span> 2021-12-12</p>
							<hr>
							<p><span>직업</span> <input type="text" name="jop" placeholder="ex)개발자" value="<%= jop %>"></p>
							<p><span>관심사</span> <input type="text" name="interest" placeholder="ex)JAVA, SQL" value="<%= interest %>"></p>
							<p><span>자기소개</span></p>
							<textarea name="intro" placeholder="ex)본인 소개를 해주세요"><%= intro %></textarea>
							<p><span>홈페이지</span> <input type="text" name="page" placeholder="ex)블로그 주소, 깃 주소 등" value=" <%= homepage %>"></p>
							<p><input class="btn" type="submit" value="수정완료"></p>
							<p><a href="javascript:Secession(<%= login.getNo() %>);">회원 탈퇴</a></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>