<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%
//kinds 값 분석(0/1/2/3/4/5/9)
String kinds = request.getParameter("kinds");
if(kinds == null || kinds.equals("")) kinds = "1";
%>
<div class="main">
	<div class="wrap">
		<div class="study text howto">
			<div class="top_text">
				<h3>HAPPY STUDDAY</h3>
				<p>STUDDAY는 함께 스터디 할 사람을 구하기 위한 커뮤니티 사이트로</p>
				<p><b>개인의 다툼이나 문제가 생길 경우</b> 책임지지 않습니다.</p>
			</div>
			<div class="tab_menu">
					<ul>
						<li><h4><a href="howto.jsp?kinds=1" <%if(kinds.equals("1")){%>class="now"<%}%>>Study</a></h4></li>
						<li><h4><a href="howto.jsp?kinds=2" <%if(kinds.equals("2")){%>class="now"<%}%>>Homepage</a></h4></li>
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
							<li>3. Study 카테고리의 With Us 탭에 가서 얄식에 맞게 글을 쓴다.</li>
							<li>4. 스터디원의 연락을 기다린다.</li>
							<li>5. 기간에 맞춰 열심히 공부한다!!</li>
						</ol>
					</div>
					
					<div>
						<h4>스터디원을 구하는 방법 2</h4>
						<ol>
							<li>1. 회원가입을 한다.</li>
							<li>2. Study 카테고리의 With Us 탭에 모집중인 글을 구경한다.</li>
							<li>3. 마음에 드는 스터디 리더에게 연락한다.</li>
							<li>4. 기간에 맞춰 열심히 공부한다!!</li>
						</ol>
					</div>
					<%
					} else
					{
					%>
					<div>
						<h4>메인 페이지</h4>
						<p>WELCOME STUDDAY!!</p>
						<ol>
							<li>1. 배너(동료 구하기): 로그인 하지 않았을 시 로그인 화면,<br>로그인 한 사람은 with us 화면이로 이동</li>
							<li>2. 아이콘: 필요한 게시판으로 바로 이동할 수 있는 아이콘!</li>
							<li>3. With Us: 모집중인 스터디 중 최근 게시물이며, 최대 8개 올라옵니다.</li>
							<li>4. Request: 홈페이지 관련 문의를 보내주세요!</li>
						</ol>
					</div>
					
					<div>
						<h4>How To</h4>
						<p>스터디를 구하는 방법과 홈페이지 사용 방법에 대한 설명이 있습니다.</p>
						<p>지금 보고 계시는 바로 이 페이지랍니다!</p>
					</div>
					
					<div>
						<h4>Study</h4>
						<p>
							스터디와 관련된 탭이 모여있습니다.<br>
							댓글이 있는 경우 댓글의 수가 표시되고, 첨부파일이 있는 경우 ★표시가 있습니다.
						</p>
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
						<p>하고 싶은 얘기 아무거나 해보세요 :)</p>
					</div>
					
					<div>
						<h4>Contect</h4>
						<p>홈페이지에 관한 정보 공간</p>
						<ol>
							<li>1. Notice: 공지사항이 올라옵니다</li>
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
<%@ include file="../include/footer.jsp" %>