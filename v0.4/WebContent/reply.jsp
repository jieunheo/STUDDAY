<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./config/dbopen.jsp"%>
<%
LoginVo login = (LoginVo)session.getAttribute("login");	//로그인정보

String bno      = request.getParameter("bno");   //게시물번호
String no       = ""; //작성자번호
String rpost    = ""; //댓글내용
String rdate    = ""; //값
String nick     = ""; //작성자닉네임

if (bno == null)
{	//값이 없음
	out.print("댓글이 없습니다.");
	return;
}

if(bno == "")
{
	out.print("잘못된 게시판입니다.");
	return;
}

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date today = new Date();		//오늘날짜
%>

<%
//로그인 해야 댓글 작성 가능
if(login != null)
{
	%>
	<div class="line"></div>
	<div class="reply now">
		<form id="reply" name="reply" method="post" action="replyupload.jsp" onsubmit="return ReplyUpload();">
			<input type="hidden" name="bno" value="<%= bno %>">
			<span><%= login.getNick() %></span>
			<input type="text" id="rpost" name="rpost" placeholder="댓글을 입력해주세요">
			<span class="date"><%= sdf.format(today) %></span>
			<input class="btn" type="submit" value="댓글달기">
		</form>
	</div>
	<%
}

String sql = "";

//댓글 출력
sql = "";
sql += "select rno,bno,r.no,rpost,rdate,u.nickname ";
sql += "from reply as r ";
sql += "inner join user as u ";
sql += "on r.no = u.no ";
sql += "where bno = '" + bno + "' ";
sql += "order by rno desc ";
dbms.OpenQuery(sql);

if(dbms.GetNext())
{
	if(login == null)
	{
		%>
		<div class="line"></div>
		<%
	}
	%>
	<div id="replyalready" class="replyalready">
	<%
	do
	{
		String rno         = dbms.GetValue("rno");      //댓글번호
		String reply_nick  = dbms.GetValue("nickname"); //댓글 작성자 닉네임
		no    = dbms.GetValue("no");    //작성자회원번호
		rpost = dbms.GetValue("rpost"); //댓글내용
		rdate = dbms.GetValue("rdate"); //댓글 작성일
		%>
		<div class="reply">
			<span><%= reply_nick %></span>
			<p><%= rpost %></p>
			<span class="date"><%= rdate.split(" ")[0] %></span>
			<%
			if(login.getNo().equals(no))
			{
				%>
				<a href="javascript:ReplyDelete('replydelete.jsp?bno=<%=bno%>&rno=<%=rno%>');">삭제</a>
				<%
			}
			%>
		</div>
		<%
	}while(dbms.GetNext());
	dbms.CloseQuery();
}
%>
</div>
<%@ include file="./config/dbclose.jsp"%>