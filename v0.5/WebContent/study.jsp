<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
String strmenu   = "STUDY"; //메뉴표시이름

//kinds 값 분석(0/1/2/3/4/5/9)
String kinds = request.getParameter("kinds");
if (kinds == null)	kinds = "1"; //값이 없으면 1로
switch (kinds)
{
	case "0": 
		strmenu = "Notice";
		break;
	case "9":
		strmenu = "Talk";
		break;
}

//key 값 분석
String key = request.getParameter("key");
if(key == null) key = "";
if(key.equals("null")) key = "";

//page 값 분석
int cur_page = 0;
if (request.getParameter("page") != null) //넘어온 페이지 번호
{ //비어있지 않으면 curpage에 해당 값 할당
	cur_page = Integer.parseInt(request.getParameter("page"));
} else
{ //비어있으면 1
	cur_page = 1;
}
%>
<script>
	window.onload = function() {
		$.ajax({
			type: "get",
			url: "board.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>",
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
		<div class="study <%if(kinds.equals("1")){%>withus<%}else{%>recture<%}%> text">
			<h3><%= strmenu %></h3>
			<%
			if(kinds.equals("0") || kinds.equals("9"))
			{
				%>
				<div class="notice">
					<%if(kinds.equals("0")){%><p>홈페이지에 관한 내용이 공지 됩니다. 확인해주세요 :)</p><%}%>
					<%if(kinds.equals("9")){%><p>우리 모두 다함께 노닥노닥 :)</p><%}%>
				</div>
				<%
			} else
			{
				%>
				<div class="tab_menu">
					<ul>
						<li><a href="study.jsp?kinds=1" <%if(kinds.equals("1")){%>class="now"<%}%>>With Us</a></li>
						<li><a href="study.jsp?kinds=2" <%if(kinds.equals("2")){%>class="now"<%}%>>Lecture</a></li>
						<li><a href="study.jsp?kinds=3" <%if(kinds.equals("3")){%>class="now"<%}%>>Reference</a></li>
						<li><a href="study.jsp?kinds=4" <%if(kinds.equals("4")){%>class="now"<%}%>>Tip</a></li>
						<li><a href="study.jsp?kinds=5" <%if(kinds.equals("5")){%>class="now"<%}%>>Q&A</a></li>
					</ul>
				</div>
				<%
			}
			%>
			<div id="board"></div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>