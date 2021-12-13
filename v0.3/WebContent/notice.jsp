<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="study recture text">
			<div class="notice text">
				<h3>Notice</h3>
				<p>홈페이지에 관한 내용이 공지 됩니다. 확인해주세요 :)</p>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>날짜</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
					<%
					for(int i=0; i<10; i++)
					{
						%>
						<tr>
							<td><%= 10-i %></td>
							<td><a href="view.jsp">공지사항</a></td>
							<td>2021-12-01</td>
							<td>관리자</td>
						</tr>
						<%
					}
					%>
					</tbody>
				</table>
				<div class="btn_wrap">
					<a class="btn" href="write.jap">글쓰기</a>
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