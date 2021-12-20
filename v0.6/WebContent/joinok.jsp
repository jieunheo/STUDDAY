<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp" %>
<%
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

/* 값 받아오기 */
String id    = request.getParameter("id");       //아이디
String pw    = request.getParameter("pw");       //비밀번호
String nick  = request.getParameter("nickname"); //닉네임
String email = request.getParameter("email");    //이메일
String no    = null; //회원번호
String rank  = "U";	 //권한

/* 값이 비었을 경우 */
if(id == null || pw == null || nick == null || email == null)
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'join.jsp';
	</script>
	<%
}

if(id == "" || pw == "" || nick == "" || email == "")
{
	%>
	<script>
		alert('필요한 정보가 일부 입력되지 않았습니다.');
		document.location = 'join.jsp';
	</script>
	<%
}

String sql = "";

//아이디 중복 확인
sql += "select id from user where id = '" + id + "';";
System.out.println("SQL: " + sql);
dbms.OpenQuery(sql);
boolean isNext = dbms.GetNext();
dbms.CloseQuery();

if (isNext == true)
{
	%>
	<p>중복된 아이디가 존재합니다.</p>
	<%
} else
{
	try
	{
		sql = "";
		sql += "insert into user (id,pw,nickname,email) ";
		sql += "value ('" + id + "',md5('" + pw + "'),'" + nick + "','" + email + "')";
		dbms.RunSQL(sql);
		
		no = dbms.GetLastID("no");
	}catch(Exception e)
	{
		%>
		<script>
			alert('오류로 인해 가입되지 않았습니다.');
			window.location = 'error.jsp';
		</script>
		<%
	}
}
%>
<script>
	if(confirm('회원가입이 완료 되었습니다. 바로 로그인하시겠습니까?') == true)
	{
		<%LoginVO login = new LoginVO(no,id,nick,rank,email);
		session.setAttribute("login", login);%>
		alert('로그인 되었습니다.');
		window.location = 'index.jsp';
	}
</script>
<%@ include file="./config/dbclose.jsp" %>