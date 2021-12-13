<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp" %>
<%
LoginVo login = (LoginVo)session.getAttribute("login");	//로그인정보

/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

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
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

/* 값 받아오기 */
String id    = login.getId();                    //아이디
String pw    = request.getParameter("pw");       //비밀번호
String nick  = request.getParameter("nickname"); //닉네임
String email = request.getParameter("email");    //이메일
String jop   = request.getParameter("jop");      //직업
String interest = request.getParameter("interest"); //관심사
String intro    = request.getParameter("intro");    //자기소개
String homepage = request.getParameter("page");     //홈페이지
String no    = null; //회원번호
String rank  = "U";	 //권한

/* 값이 비었을 경우 */
if(id == "")
{
	%>
	<script>
		alert('필요한 정보가 일부 입력되지 않았습니다.');
		document.location = 'join.jsp';
	</script>
	<%
}

String sql = "";

//회원 정보 확인
sql += "select no,id,pw,nickname,email,join_date,";
sql += "user_rank,jop,interest,intro,page ";
sql += "from user ";
sql += "where no = '" + login.getNo() + "' ";
dbms.OpenQuery(sql);
if (dbms.GetNext() != true)
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'join.jsp';
	</script>
	<%
}
no = dbms.GetValue("no");

System.out.println(no);
System.out.println(id);
System.out.println(pw);
System.out.println(nick);
System.out.println(email);
System.out.println(jop);
System.out.println(interest);
System.out.println(intro);
System.out.println(page);

sql = "";
sql += "update user set ";
if(pw != null       || !pw.equals(""))
{
	sql += "pw=md5('" + pw + "'), ";
} else
{
	pw = dbms.GetValue("pw");
	sql += "pw='" + pw + "', ";
}
if(nick != null     || !nick.equals(""))     sql += "nickname='" + nick + "', ";
if(email != null    || !email.equals(""))    sql += "email='" + email + "', ";
if(jop != null      || !jop.equals(""))      sql += "jop='" + jop + "', ";
if(interest != null || !interest.equals("")) sql += "interest='" + interest + "', ";
if(intro != null    || !intro.equals(""))    sql += "intro='" + intro + "', ";
if(page != null     || !page.equals(""))     sql += "page='" + homepage + "' ";
sql += "where no = '" + login.getNo() + "' ";
dbms.RunSQL(sql);

%>
<script>
		<%
		login = new LoginVo(no,id,nick,rank);
		session.setAttribute("login", login);
		%>
		alert('정보 수정이 완료되었습니다.');
		window.location = 'info.jsp';
</script>
<%@ include file="./config/dbclose.jsp" %>