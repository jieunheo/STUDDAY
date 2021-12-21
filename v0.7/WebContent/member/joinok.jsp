<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
/* 인코딩 방식 */
request.setCharacterEncoding("UTF-8");

/* 값 받아오기 */
String id        = request.getParameter("id");       //아이디
String pw        = request.getParameter("pw");       //비밀번호
String nickname  = request.getParameter("nickname"); //닉네임
String email     = request.getParameter("email");    //이메일
String no        = null; //회원번호
String user_rank = "U";	 //권한

/* 값이 비었을 경우 */
if(id == null || pw == null || nickname == null || email == null)
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = '/Studday0.6/member/join.jsp';
	</script>
	<%
}

if(id == "" || pw == "" || nickname == "" || email == "")
{
	%>
	<script>
		alert('필요한 정보가 일부 입력되지 않았습니다.');
		document.location = '/Studday0.6/member/join.jsp';
	</script>
	<%
}

//아이디 중복 확인
UserDTO dto = new UserDTO();
int code = dto.IsDuplicate("id",id);
if(code == UserDTO.NOT_DUPLICATE)
{
	//id 중복이 아닌 경우 인서트
	UserVO user = new UserVO(id,pw,nickname,email);
	
	if( dto.Insert(user) == false)
	{
		%>
		<script>
			alert("회원가입 중 오류가 있습니다. 다시 시도해주세요.");
			window.location = '/Studday0.6/member/join.jsp';
		</script>
		<%	
	} else
	{
		//회원가입 성공
		%>
				/*
		<script>
			if(confirm("바로 로그인 하시겠습니까?"))
			{
				//자동으로 로그인 시킨다.
				UserVO login = dto.Login(id, pw);
				if( login != null)
				{
					session.setAttribute("login", login);
				}
				document.location = "/Studday0.6/index.jsp";
			}
		</script>
				*/
		<%
		/*response.sendRedirect("/Studday0.6/index.jsp");*/
	}
}else
{
	//아이디가 중복됨
	%>
	<script>
		alert("중복된 아이디가 존재합니다. 다시 시도해 주세요.");
		window.location = "join.jsp";
	</script>
	<%
}
%>