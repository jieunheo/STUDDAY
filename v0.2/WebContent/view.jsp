<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
	window.onload = function ()
	{
		ReadReply();
	}
</script>
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
							<p><span>스터디 이름 </span>Java 스터디 구합니다.</p>
							<p><span>리더 </span>홍선생</p>
							<p><span>언어 </span>Java</p>
							<p><span>모집 여부 </span>모집 중</p>
							<p><span>모집 기간 </span>2012-12-01 ~ 2012-12-15</p>
							<div class="line"></div>
							<div class="content">내용입니다!!</div>
							<div class="btn_wrap">
								<a class="btn" href="study.jsp">뒤로가기</a>
								<a class="btn" href="modify.jsp">글수정</a>
								<a class="btn" href="delete.jsp" onclick="return confirm('삭제하시겠습니까?');">글삭제</a>
							</div>
						</div>
						<div id="reply_wrap" class="reply_wrap">
							<div class="line"></div>
								<div class="reply now">
									<form name="reply" onsubmit="return FormCheck();" method="post" action="view.jsp">
										<span>홍선생</span>
										<input type="text" id="rpost" name="rpost" placeholder="댓글을 입력해주세요">
										<span class="date">2012-12-01</span>
										<input class="btn" type="submit" value="댓글달기">
									</form>
								</div>
							
							<div id="replyalready" class="replyalready">
								<div class="comment">
									<span>홍선생</span>
									<p>아주 좋아요</p>
									<span class="date">2021-12-03</span>
									<a href=#>삭제</a>
								</div>
								<div class="comment">
									<span>홍선생</span>
									<p>아주 좋아요</p>
									<span class="date">2021-12-03</span>
									<a href=#>삭제</a>
								</div>
								<div class="comment">
									<span>홍선생</span>
									<p>아주 좋아요</p>
									<span class="date">2021-12-03</span>
									<a href=#>삭제</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>