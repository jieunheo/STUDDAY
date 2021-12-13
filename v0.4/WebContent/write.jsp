<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
window.onload = function()
{
	document.write.title.focus();
}

function OnFocus(value)
{
	value.focus();
}

function FormCheck()
{
	if(document.write.title.value == "")
	{
		alert('제목을 입력해주세요.');
		OnFocus(document.write.title);
		return false;
	}
	
	if(document.write.start_date.value == "")
	{
		alert('스터디 시작 날짜를 입력해주세요.');
		OnFocus(document.write.start_date);
		return false;
	}
	
	if(document.write.end_date.value == "")
	{
		alert('스터디 끝 날짜를 입력해주세요.');
		OnFocus(document.write.end_date);
		return false;
	}
	
	if(document.write.post.value == "")
	{
		alert('스터디 설명을 입력해주세요.');
		OnFocus(document.write.post);
		return false;
	}
}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category write">
					<p>Study > With Us > Write</p>
				</div>
				<div>
					<form class="write" name="write" method="post" action="writeok.jsp" onsubmit="return FormCheck();">
						<p><span>스터디 이름 </span><input type="text" id="title" name="title" placeholder="스터디원을 불러보세요!"></p>
						<p><span>리더 </span>홍선생</p>
						<p>
							<span>언어 </span>
							<select name="lang">
								<option value="java">JAVA</option>
								<option value="sql">SQL</option>
								<option value="js">Javascript</option>
							</select>
						</p>
						<p>
							<span>모집 기간 </span>
							<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01" readonly> ~ 
							<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10" readonly>
						</p>
						<textarea class="post" name="post" placeholder="어떤 스터디인지 알려주세요!!"></textarea>
						<div class="btn_wrap">
							<a class="btn" href="study.jsp">뒤로가기</a>
							<input class="btn" type="submit" value="글쓰기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>