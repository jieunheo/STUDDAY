<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="/Studdat0.6/error/error.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="../include/header.jsp" %>
<%
SearchVO search = new SearchVO();
search.setKinds(request.getParameter("kinds"));
search.setKeyword(request.getParameter("key"));
search.setSortcol(request.getParameter("oc"));
search.setSortorder(request.getParameter("ob"));
search.setCurpage(request.getParameter("page"));

String bno = request.getParameter("bno");
BoardDTO dto = new BoardDTO();
BoardVO vo = dto.Read(bno, true);

ListStateVO list_state = new ListStateVO(search.getKinds());


%>
<script>
	window.onload = function ()
	{
		ReadReply(<%= vo.getBno() %>);
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category view">
					<p>Study > <%= list_state.getKind() %> > View</p>
				</div>
				<div>
					<div class="view">
						<div>
							<p><span><%= list_state.getTitle() %> </span><%= vo.getTitle() %></p>
							<p><span><%= list_state.getWriter() %> </span><%= vo.getNickname() %></p>
							<%
							if(list_state.getFilter() != 0)
							{
								%>
								<p><span>언어 </span><%= vo.getLang() %></p>
								<%
							}
							
							if(list_state.getFilter() == 1)
							{
								%>
								<p><span>모집 여부 </span><%= vo.GetStudyState() %></p>
								<p><span>모집 기간 </span><%= vo.getStartDate() %> ~ <%= vo.getEndDate() %></p>
								<%
							} else
							{
								%>
								<p><span>작성일 </span><%= vo.getToday() %></p>
								<%
							}
							%>
							<div class="line"></div>
							<div class="content"><%= vo.getPost() %></div>
							
							<div class="btn_wrap">
								<a class="btn" href="study.jsp?<%= search.GetPageLink(search.getCurpage()) %>">뒤로가기</a>
								<%
								if(login != null)
								{
									if(login.getNo().equals(vo.getNo()) || login.getUser_rank().equals("A"))
									{
										if(login.getNo().equals(vo.getNo()))
										{
											%>
											<a class="btn" href="modify.jsp?<%= search.GetPageLink(search.getCurpage()) %>">글수정</a>
											<%
											}
										%>
										<a class="btn" href="delete.jsp?<%= search.GetPageLink(search.getCurpage()) %>" onclick="return confirm('삭제하시겠습니까?');">글삭제</a>
									<%
									}
								}
								%>
							</div>
						</div>
						
						<div id="reply_wrap" class="reply_wrap"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>