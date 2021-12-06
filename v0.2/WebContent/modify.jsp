<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category modify">
					<p>Study > With Us > Modify</p>
				</div>
				<div>
					<form class="modify" name="write" method="post" action="view.jsp">
						<p><span>스터디 이름 </span><input type="text" name="title" value="Java 스터디 구합니다"></p>
						<p><span>리더 </span><input type="text" name="name" value="홍길동"></p>
						<p>
							<span>언어 </span>
							<select>
								<option>JAVA</option>
								<option>SQL</option>
								<option>Javascript</option>
							</select>
						</p>
						<p>
							<span>모집 기간 </span>
							<input class="date" type="text" name="date" value="2021-12-01"> ~ 
							<input class="date" type="text" name="date" value="2021-12-10">
						</p>
						<textarea>함께 자바 스터디 하실 분 구합니다.
같이 공부해요</textarea>
						<div class="btn_wrap">
							<a class="btn" href="view.jsp">뒤로가기</a>
							<input class="btn" type="submit" value="수정하기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>