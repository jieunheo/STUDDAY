<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
String no       = "";													//회원번호
String id       = request.getParameter("id"); //아이디
String pw       = request.getParameter("pw"); //비밀번호
String nickname = "";													//닉네임
String rank     = "";												  //권한

if(id == null || pw == null)
{
	%>
	<script>
		alert('잘못된 접근입니다. 로그인해주세요.');
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

String sql = "";
sql += "select no,id,nickname,user_rank ";
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
	no = dbms.GetValue("no");
	nickname = dbms.GetValue("nickname");
	rank = dbms.GetValue("user_rank");
}
dbms.CloseQuery();

login = new LoginVo(no,id,nickname,rank);
session.setAttribute("login", login);
%>
<script>
	alert('로그인 되었습니다.');
	document.location = 'index.jsp';
</script>
<%@ include file="./include/footer.jsp" %>