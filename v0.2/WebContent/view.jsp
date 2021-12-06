<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category view">
					<p>Study > With Us > View</p>
				</div>
				<div>
					<div class="view">
						<div>
							<p><span>스터디 이름 </span>Java 스터디 구합니다</p>
							<p><span>리더 </span>홍길동</p>
							<p><span>언어 </span>JAVA</p>
							<p><span>모집 여부 </span>모집 중</p>
							<p><span>모집 기간 </span>2021-12-01 ~ 2021-12-10</p>
							<div class="line"></div>
							<div class="content">
								함께 자바 스터디 하실 분 구합니다.<br>
								같이 공부해요
							</div>
							<div class="btn_wrap">
								<a class="btn" href="withus.jsp">뒤로가기</a>
								<a class="btn" href="modify.jsp">글수정</a>
								<a class="btn" href="delete.jsp">글삭제</a>
							</div>
						</div>
						<div class="comment_wrap">
							<div class="line"></div>
							<div class="comment now">
								<form name="comment">
									<span>홍선생</span>
									<input type="text" name="comment" placeholder="댓글을 입력해주세요">
									<span class="date">2021-12-03</span>
									<input class="btn" type="submit" value="댓글달기">
								</form>
							</div>
							
							<%
							for(int i=0; i<3; i++)
							{
								%>
								<div class="comment">
									<span>홍선생</span>
									<p>아주 좋아요</p>
									<span class="date">2021-12-0<%= 3-i %></span>
									<a href=#>삭제</a>
								</div>
								<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>