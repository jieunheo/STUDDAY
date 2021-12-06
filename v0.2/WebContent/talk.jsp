<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="study recture text">
			<div class="notice text">
				<h3>Talk</h3>
				<p>우리 모두 다함께 노닥노닥 :)</p>
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
							<td><a href="view.jsp">20시간 짠 코드 날라감 ㅜㅜ</a></td>
							<td>2021-12-01</td>
							<td>홍길동</td>
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