<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//kinds 값 분석(0/1/2/3/4/5/9)
String kinds = request.getParameter("kinds");
if(kinds == null || kinds.equals("")) kinds = "1";
%>
<div class="main">
	<div class="wrap">
		<div class="study text howto">
			<div class="tab_menu">
					<ul>
						<li><h3><a href="howto.jsp?kinds=1" <%if(kinds.equals("1")){%>class="now"<%}%>>Study</a></h3></li>
						<li><h3><a href="howto.jsp?kinds=2" <%if(kinds.equals("2")){%>class="now"<%}%>>Homepage</a></h3></li>
					</ul>
			</div>
			<div class="rules">
			<%
			if(kinds.equals("1"))
			{
				%>
				<div>
					<h4>스터디원을 구하는 방법 1</h4>
					<ol>
						<li>1. 회원가입을 한다.</li>
						<li>2. 카카오톡에서 같이 공부 할 오픈톡방을 만든다.</li>
						<li>3. Study 카테고리의 With Us 탭에 가서 글을 쓴다.</li>
						<li>4. 연락을 기다린다.</li>
						<li>5. 공부한다!!</li>
					</ol>
				</div>
				
				<div>
					<h4>스터디원을 구하는 방법 2</h4>
					<ol>
						<li>1. 회원가입을 한다.</li>
						<li>2. Study 카테고리의 With Us 탭에 모집중인 글을 구경한다.</li>
						<li>3. 연락한다.</li>
						<li>4. 공부한다!!</li>
					</ol>
				</div>
				<%
				} else
				{
				%>
				<div>
					<h4>메인 페이지</h4>
					<p>웰컴 스터데이!!</p>
					<ol>
						<li>1. 배너: 로그인 한 사람은 with us 화면이로 이동</li>
						<li>2. 아이콘: 바로가기 아이콘!</li>
						<li>3. With Us: 모집중인 최근 8개의 게시물이 올라옵니다</li>
						<li>4. Request: 홈페이지 관련 문의를 보내주세요!</li>
					</ol>
				</div>
				
				<div>
					<h4>How To</h4>
					<p>스터디를 구하는 방법과 홈페이지 사용 방법에 대한 설명이 있습니다.</p>
				</div>
				
				<div>
					<h4>Study</h4>
					<p>스터디와 관련된 탭이 모여있습니다.</p>
					<ol>
						<li>1. With Us: 함께 공부 할 사람을 찾는 공간</li>
						<li>2. Lecture: 추천 강의를 적는 공간</li>
						<li>3. Reference: 좋은 자료를 공유하는 공간</li>
						<li>4. Tip: 공유하고싶은 팁을 작성하는 공간</li>
						<li>5. Q&A: 질문이 있으면 작성하고 답변하는 공간</li>
					</ol>
				</div>
				
				<div>
					<h4>Talk</h4>
					<p>공부하다 힘들 때 쓸 수 있는 노닥노닥 자유 게시판</p>
				</div>
				
				<div>
					<h4>Contect</h4>
					<p>홈페이지에 관한 정보 공간</p>
					<ol>
						<li>1. Notice: 공지사하잉 올라옵니다</li>
						<li>2. Request: 문의사항이 있을 때 메일로 보내주세요</li>
					</ol>
				</div>
				<%
			}
			%>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>