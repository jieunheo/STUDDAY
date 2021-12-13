<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="study withus text">
			<h3>STUDY</h3>
			<div class="tab_menu">
				<ul>
					<li><a href="study.jsp" class="now">With Us</a></li>
					<li><a href="study.jsp">Lecture</a></li>
					<li><a href="study.jsp">Reference</a></li>
					<li><a href="study.jsp">Tip</a></li>
					<li><a href="study.jsp">Q&A</a></li>
				</ul>
			</div>
			<div>
				<table id="board_table">
					<thead>
						<tr>
							<th>번호</th>
							<th>스터디 이름</th>
							<th>모집 기간</th>
							<th>모집 여부</th>
							<th>리더</th>
						</tr>
					</thead>
					<tbody>
					<%
					for(int i=0; i<10; i++)
					{
						%>
						<tr>
							<td><%= 10-i %></td>
							<td><a href="view.jsp">Java 스터디입니다.</a></td>
							<td>2021-12-12 ~ 2012-12-15</td>
							<td class="ing">모집중</td>
							<td>홍선생</td>
						</tr>
						<%
					}
					%>
					</tbody>
				</table>
				<div class="btn_wrap">
					<a class="btn" href="write.jsp">글쓰기</a>
				</div>
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