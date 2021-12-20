<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./config/dbopen.jsp" %>
<%
	LoginVO login = (LoginVO)session.getAttribute("login");	//로그인정보

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

	/* 값 받아오기 */
	String no       = login.getNo();                    //회원번호
	String id       = login.getId();                    //아이디
	String pw       = request.getParameter("pw");       //비밀번호
	String nick     = request.getParameter("nickname"); //닉네임
	String email    = request.getParameter("email");    //이메일
	String jop      = request.getParameter("jop");      //직업
	String interest = request.getParameter("interest"); //관심사
	String intro    = request.getParameter("intro");    //자기소개
	String homepage = request.getParameter("page");     //홈페이지
	String rank     = "";                               //권한

	if(nick == null || email == null || nick.equals("") || email.equals(""))
	{
	%>
	<script>
		alert('필요한 정보가 일부 입력되지 않았습니다.');
		window.location = 'join.jsp';
	</script>
	<%
		}

	if(jop == null)      jop = "";
	if(interest == null) interest = "";
	if(intro == null)    intro = "";
	if(homepage == null) homepage = "";

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
	rank = dbms.GetValue("user_rank");

	sql = "";
	sql += "update user set ";
	if(pw != null && !pw.equals(""))
	{
		sql += "pw=md5('" + pw + "'), ";
	} else
	{
		pw = dbms.GetValue("pw");
		sql += "pw='" + pw + "', ";
	}

	sql += "nickname='" + nick + "', ";
	sql += "email='" + email + "', ";
	sql += "jop='" + jop + "', ";
	sql += "interest='" + interest + "', ";
	sql += "intro='" + intro + "', ";
	sql += "page='" + homepage + "' ";
	sql += "where no = '" + login.getNo() + "' ";
	dbms.RunSQL(sql);
	%>
<script>
		<%login = new LoginVO(no,id,nick,rank,email);
		session.setAttribute("login", login);%>
		alert('정보 수정이 완료되었습니다.');
		window.location = 'info.jsp';
</script>
<%@ include file="./config/dbclose.jsp" %>