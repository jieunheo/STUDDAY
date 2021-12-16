<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
String no        = login.getNo(); //회원번호
String id        = "";            //아이디
String nickname  = "";            //닉네임
String email     = "";            //이메일
String join_date = "";            //가입일
String user_rank = "";            //권한
String jop       = "";            //직업
String interest  = "";            //관심사
String intro     = "";            //자기소개
String homepage  = "";            //홈페이지

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

no        = login.getNo();              //회원번호
id        = dbms.GetValue("id");        //아이디
nickname  = dbms.GetValue("nickname");  //닉네임
email     = dbms.GetValue("email");     //이메일
join_date = dbms.GetValue("join_date"); //가입일
user_rank = dbms.GetValue("user_rank"); //권한
jop       = dbms.GetValue("jop");       //직업
interest  = dbms.GetValue("interest");  //관심사
intro     = dbms.GetValue("intro");     //자기소개
homepage  = dbms.GetValue("page");      //홈페이지
dbms.CloseQuery();

if(jop == null)      jop = "";
if(interest == null) interest = "";
if(intro == null)    intro = "";
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

		var pw = $('#pw').val();
		
		//비밀번호 맞는지 확인
		$.ajax({
			type: "get",
			url: "pwcheck.jsp?id=<%= id %>&pw=" + pw,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				if(data != "00")
				{
					window.location = "reinfo.jsp";
				} else{
					alert('비밀번호가 일치하지 않습니다.');
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
							<p><span>아이디</span> <%= id %></p>
							<p><span>비밀번호</span> <input id="pw" type="password" name="pw" placeholder="비밀번호"></p>
							<p><span>닉네임</span> <%= nickname %>(A)</p>
							<p><span>email</span> <%= email %></p>
							<p><span>가입일시</span> <%= join_date %></p>
							<hr>
							<p><span>직업</span> <%= jop %></p>
							<p><span>관심사</span> <%= interest %></p>
							<p><span>자기소개</span> <%= intro %></p>
							<p><span>홈페이지</span> 
							<%
							if(!homepage.equals(""))
							{
								%>
								<a href="http://<%= homepage %>"><%= homepage %></a>
								<%
							}
							%>
							</p>
							<p><input class="btn" type="submit" value="정보수정"></p>
							<p><a href="jacascript:ready();">회원 탈퇴</a></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>