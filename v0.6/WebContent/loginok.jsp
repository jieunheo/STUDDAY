<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
	/* 값 받아오기 */
String no       = "";													//회원번호
String id       = request.getParameter("id"); //아이디
String pw       = request.getParameter("pw"); //비밀번호
String nickname = "";													//닉네임
String email    = "";													//이메일
String rank     = "";												  //권한

/* 비어있는 값 확인 */
if(id == null || pw == null)
{
%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'login.jsp';
	</script>
	<%
		}

	if(id == "" || pw == "")
	{
	%>
	<script>
		alert('아이디 또는 비밀번호가 입력되지 않았습니다.');
		document.location = 'login.jsp';
	</script>
	<%
		}

	/* 회원 정보 확인 */
	String sql = "";
	sql += "select no,id,nickname,email,user_rank ";
	sql += "from user ";
	sql += "where id = '" + id + "' ";
	sql += "and pw = md5('" + pw + "') ";
	sql += "and retire = 'N';"; //탈퇴여부
	dbms.OpenQuery(sql);
	if(dbms.GetNext() == false)
	{
		dbms.CloseQuery();
	%>
	<script>
		alert('아이디 또는 비밀번호가 틀렸습니다.');
		document.location = 'login.jsp';
	</script>
	<%
		} else
	{
		no       = dbms.GetValue("no");
		nickname = dbms.GetValue("nickname");
		email    = dbms.GetValue("email");
		rank     = dbms.GetValue("user_rank");
	}
	dbms.CloseQuery();

	login = new LoginVO(no,id,nickname,rank,email);
	session.setAttribute("login", login);
	%>
<script>
	alert('로그인 되었습니다.');
	window.location = 'index.jsp';
</script>
<%@ include file="./include/footer.jsp" %>