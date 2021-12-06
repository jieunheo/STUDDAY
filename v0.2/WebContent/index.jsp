<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="banner">
		<div class="wrap">
			<div>
				<div class="title">
					<h2>WELCOME STUDDAY</h2>
					<p>혼자 하기 버거운 공부를 함께 하는 공간</p>
					<p>오늘도 공부하는 날 :)</p>
				</div>
				<div class="b_btn">
					<a href="login.jsp">동료 구하기</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="icons">
		<div class="wrap">
			<a class="icon" href="withus.jsp">
				<img alt="How To" src="./img/icon_how.png">
				<p>How To</p>
			</a>
			<a class="icon" href="javascript:ready();">
				<img alt="How To" src="./img/icon_ref.png">
				<p>Ref</p>
			</a>
			<a class="icon" href="javascript:ready();">
				<img alt="How To" src="./img/icon_tip.png">
				<p>Tip</p>
			</a>
			<a class="icon" href="javascript:ready();">
				<img alt="How To" src="./img/icon_qa.png">
				<p>Q&A</p>
			</a>
			<a class="icon" href="notice.jsp">
				<img alt="How To" src="./img/icon_notice.png">
				<p>Notice</p>
			</a>
		</div>
	</div>
	
	<div class="study_list">
		<div class="wrap">
			<div class="text">
				<h3>With Us</h3>
				<p>마음에 드는 스터디를 찾아 함께 해보세요 :)</p>
			</div>
			<div>
				<a class="before_btn" href="#"></a>
				<div class="overflow">
					<ul>
					<%
					for (int i = 1; i<=8; i++)
					{
						%>
						<li class="item">
							<a href="view.jsp">
								<div class="thumb thumb<%= (i%3)+1 %>"></div>
								<p><%= i %> 스터디원 구합니다.</p>
							</a>
						</li>
						<%
					}
					%>
					</ul>
				</div>
				<a class="after_btn" href="#"></a>
			</div>
		</div>
	</div>
	
	<div class="request">
		<div class="wrap">
			<div class="text">
				<h3>Request</h3>
				<p>언제든 문의하실 내용 있으시면 폼 보내주세요 :)</p>
			</div>
			<form class="form" name="request" action="">
				<p><input type="email" name="email" placeholder="이메일"></p>
				<p><input type="text" name="title" placeholder="문의 제목"></p>
				<textarea name="content" placeholder="문의 내용"></textarea>
				<p><input type="button" value="문의하기" onclick="javascript:ready();"></p>
			</form>
			</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>