<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

String pw       = request.getParameter("pw");       //비밀번호
String nickname = request.getParameter("nickname"); //닉네임
String email    = request.getParameter("email");    //이메일
String jop      = request.getParameter("jop");      //직업
String interest = request.getParameter("interest"); //관심사
String intro    = request.getParameter("intro");    //자기소개
String homepage = request.getParameter("homepage"); //홈페이지

/* 권한 검사 */
if(login == null)
{
	%>
	<script>
		alert('로그인 후 이용이 가능합니다.');
		window.location = '../login/login.jsp';
	</script>
	<%
}

UserDTO dto = new UserDTO();
if(pw == null) pw = "";
System.out.println(login.getNo());

login.setNickname(nickname);
login.setEmail(email);
login.setJop(jop);
login.setInterest(interest);
login.setIntro(intro);
login.setHomepage(homepage);

if(dto.Update(login,pw) == true)
{
	%>
	<script>
		alert('수정되었습니다.');
		document.location = '../member/reinfo.jsp';
	</script>
	<%
} else {
	%>
	<script>
		alert('로그인 후 이용이 가능합니다.');
		document.location = '../login/login.jsp';
	</script>
	<%
}

%>