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

ListDTO dto = new ListDTO(search);
int total = dto.GetTotal();

ListStateVO list_state = new ListStateVO(search.getKinds());
%>
<table id="board_table">
	<thead>
		<tr>
			<th>번호</th>
			<th><%= list_state.getTitle() %></th>
			<%
			if(search.getKinds().equals("1"))
			{
				%>
				<th>모집 기간</th>
				<th>모집 여부</th>
				<%
			} else
			{
				if( !(search.getKinds().equals("0") || search.getKinds().equals("9")) )
				{
					%>
					<th>언어</th>
					<%
				}
				%>
				<th>날짜</th>
				<%
			}
			%>
			<th><%= list_state.getWriter() %></th>
		</tr>
	</thead>
	<tbody>
	<%
	dto.GetList(search.getCurpage());
	int seqno = dto.GetListTotal();
	
	if(seqno == 0) {
		%>
		<tr>
			<td colspan="5">게시물이 없습니다.</td>
		</tr>
		<%
	} else
	{
		for(int i=0; i < seqno; i++)
		{
			BoardVO vo = dto.GetItem(i);
			System.out.println(i);
			%>
			<tr>
				<td><%= vo.getBno() %></td>
				<td>
					<a href="view.jsp?<%= search.GetViewLink(vo.getBno()) %>">
						<%= vo.getTitle() %><%if(vo.getReplyCount() > 0){%> <span class="relpy_count">[<%= vo.getReplyCount() %>]</span><%} if(vo.getAttach() > 0){%><span class="relpy_count">&nbsp;★</span><%}%>
					</a>
				</td>
				<%
				if(list_state.getFilter() == 1)
				{
					%>
					<td><%= vo.getStartDate() %> ~ <%= vo.getEndDate() %></td>
					<td <% if(vo.GetStudyState().equals("모집 중")){%>class="ing"<%}%>><%= vo.GetStudyState() %></td>
					<%
				} else
				{
					if(list_state.getFilter() != 0)
					{
						%>
						<td><%= vo.getLangName() %></td>
						<%
					}
					%>
					<td><%= vo.GetDate(vo.getDate()) %></td>
					<%
				}
				%>
				<td><%= vo.getNickname() %></td>
			</tr>
			<%
			}
	}
	%>
	</tbody>
</table>
<div class="table_btn_wrap">
	<form class="search" name="search" method="get" action="">
		<input id="key" type="text" name="key" value="">
		<input class="btn" type="submit" value="검색">
		<%
		if(login != null)
		{
			%>
			<a class="btn" href="write.jsp?<%= search.GetPageLink(search.getCurpage()) %>">글쓰기</a>
			<%
		}
		%>
	</form>
</div>
<div class="paging">
	<ul>
	<%
	Paging pager = new Paging(search);
	pager.setTotal(total, search.getCurpage());
	String link;
	link = pager.getPrevBlock();
	if( link != null )
	{
		%><li><a href="study.jsp?<%= link %>"> ◀  </a></li><%
	}	
	
	for(int x = pager.getStartBlock(); x <= pager.getEndBlock(); x++)
	{
		link = pager.getPage(x);
		%><li><a href="study.jsp?<%= link %>" <% if(pager.getPage(x).equals(search.GetPageLink(search.getCurpage()))){%>class="now"<%}%>> <%= x %> </a></li><%
	}
	
	link = pager.getNextBlock();
	if( link != null)
	{
		%><li><a href="study.jsp?<%= link %>"> ▶  </a></li><%
	}			
	%>
	</ul>
</div>