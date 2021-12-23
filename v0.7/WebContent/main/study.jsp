<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%
SearchVO search = new SearchVO();
search.setKinds(request.getParameter("kinds"));
search.setKeyword(request.getParameter("key"));
search.setSortcol(request.getParameter("oc"));
search.setSortorder(request.getParameter("ob"));
search.setCurpage(request.getParameter("page"));

ListDTO dto = new ListDTO(search);
int total = dto.GetTotal();
%>
<script>
	window.onload = function() {
		$.ajax({
			type: "get",
			url: "board.jsp?<%= search.GetPageLink(search.getCurpage()) %>",
			dataType: "html",
			success: function(data) {
				data = data.trim();
				$('#board').html(data);
			}
		});
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="study <%if(search.getKinds().equals("1")){%>withus<%}else{%>recture<%}%> text">
			<h3><%= search.getKindName() %></h3>
			<%
			if(search.getKinds().equals("0") || search.getKinds().equals("9"))
			{
				%>
				<div class="notice">
					<%if(search.getKinds().equals("0")){%><p>홈페이지에 관한 내용이 공지 됩니다. 확인해주세요 :)</p><%}%>
					<%if(search.getKinds().equals("9")){%><p>우리 모두 다함께 노닥노닥 :)</p><%}%>
				</div>
				<%
			} else
			{
				%>
				<div class="tab_menu">
					<ul>
						<li><a href="study.jsp?kinds=1" <%if(search.getKinds().equals("1")){%>class="now"<%}%>>With Us</a></li>
						<li><a href="study.jsp?kinds=2" <%if(search.getKinds().equals("2")){%>class="now"<%}%>>Lecture</a></li>
						<li><a href="study.jsp?kinds=3" <%if(search.getKinds().equals("3")){%>class="now"<%}%>>Reference</a></li>
						<li><a href="study.jsp?kinds=4" <%if(search.getKinds().equals("4")){%>class="now"<%}%>>Tip</a></li>
						<li><a href="study.jsp?kinds=5" <%if(search.getKinds().equals("5")){%>class="now"<%}%>>Q&A</a></li>
					</ul>
				</div>
				<%
			}
			%>
			<div id="board"></div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>