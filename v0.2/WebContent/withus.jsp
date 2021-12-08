<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="study withus text">
			<h3>STUDY</h3>
			<div class="tab_menu">
				<ul>
					<li><a href="withus.jsp" class="now">With Us</a></li>
					<li><a href="javascript:ready();">Lecture</a></li>
					<li><a href="javascript:ready();">Reference</a></li>
					<li><a href="javascript:ready();">Tip</a></li>
					<li><a href="javascript:ready();">Q&A</a></li>
				</ul>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>스터디</th>
							<th>리더</th>
							<th>모집 기간</th>
							<th>모집 여부</th>
						</tr>
					</thead>
					<tbody>
					<%
					for(int i=0; i<10; i++)
					{
						%>
						<tr>
							<td><%= 10-i %></td>
							<td><a href="view.jsp">Java 스터디 구합니다</a></td>
							<td>홍길동</td>
							<td>2021-12-01 ~ 2012-12-10</td>
							<td>모집 중</td>
						</tr>
						<%
					}
					%>
					</tbody>
				</table>
				<%
				if(login != null)
				{
					%>
					<div class="btn_wrap">
						<a class="btn" href="write.jsp">글쓰기</a>
					</div>
					<%
				}
				%>
				<div class="paging">
					<ul>
						<li><a href="#" class="now">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#">6</a></li>
						<li><a href="#">7</a></li>
						<li><a href="#">8</a></li>
						<li><a href="#">9</a></li>
						<li><a href="#">10</a></li>
						<li><a href="#">▶</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>