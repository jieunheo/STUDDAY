<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

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

/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");


UserDTO dto = new UserDTO();
System.out.println(login.getNo());

login.setNickname(request.getParameter("pw"));       //비밀번호
login.setNickname(request.getParameter("nickname")); //닉네임
login.setEmail(request.getParameter("email"));       //이메일
login.setJop(request.getParameter("jop"));           //직업
login.setInterest(request.getParameter("interest")); //관심사
login.setIntro(request.getParameter("intro"));       //자기소개
login.setHomepage(request.getParameter("homepage")); //홈페이지

UserVO re_info = dto.Update(login);
if(re_info != null)
{
	session.setAttribute("login", re_info);
	%>
	<script>
		alert('수정되었습니다.');
		document.location = 'info.jsp';
	</script>
	<%
} else {
	%>
	<script>
		alert('수정 중 문제가 생겼습니다. 다시 시도해주세요.');
		document.location = 'info.jsp';
	</script>
	<%
}
%>