<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.vo.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.dbms.*" %>
<%@ page import="ezen.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");	//로그인정보

SearchVO search = new SearchVO();
search.setKinds(request.getParameter("kinds"));
search.setKeyword(request.getParameter("key"));
search.setSortcol(request.getParameter("oc"));
search.setSortorder(request.getParameter("ob"));
search.setCurpage(request.getParameter("page"));

String bno = request.getParameter("bno");
ReplyDTO dto = new ReplyDTO();

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date today = new Date();		//오늘날짜

%>
<div class="line"></div>
<%
//로그인 해야 댓글 작성 가능
if(login != null)
{
%>
	<div class="reply now">
		<form id="reply" name="reply" method="post" action="replyupload.jsp" onsubmit="return ReplyUpload();">
			<input id="bno" type="hidden" name="bno" value="<%= bno %>">
			<input id="no" type="hidden" name="no" value="<%= login.getNo() %>">
			<span><%= login.getNickname() %></span>
			<input type="text" id="rpost" name="rpost" placeholder="댓글을 입력해주세요">
			<span class="date"><%= sdf.format(today) %></span>
			<input class="btn" type="submit" value="댓글달기">
		</form>
	</div>
	<%
}

if(dto.GetReply(bno))
{
	%>
	<div id="replyalready" class="replyalready">
	<%
	ArrayList<ReplyVO> list = dto.GetListArray();
	
	for(int i=0; i<list.size(); i++)
	{
		ReplyVO vo = null;
		vo = list.get(i);
		vo.PrintInfo();
		%>
		<script>
			function ReplyModify(rno)
			{
				//alert(rno);
			}
		</script>
		<div class="reply">
			<span><%= vo.getNickname() %></span>
			<p><%= vo.getRpost() %></p>
			<span class="date"><%= vo.getRdate().split(" ")[0] %></span>
			<%
			if(login != null && login.getNo().equals(vo.getNo()))
			{
				%>
				<a href="javascript:ready();">수정</a> 
				<a href="javascript:ReplyDelete('replydelete.jsp?bno=<%=bno%>&rno=<%=vo.getRno()%>');">삭제</a>
				<%
			}
			%>
		</div>
		<%
	}
	%>
	</div>
	<%
} else
{
	out.print("<p class='none_reply'>댓글이 없습니다.</p>");
}
%>