<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
if(login == null)
{
	%>
	<script>
		alert('로그인 후 작성이 가능합니다.');
		document.location = 'withus.jsp';
	</script>
	<%
} else
{
%>
<script>
window.onload = function()
{
	document.write.title.focus();
	
	/*
	$(start_date).keyup(function ()
	{
		var value = $(this).val();
		
		if (value == "")
		{
			return;
		}
		
		$.ajax({
			type: "get",
			url: "datecheck.jsp?value=" + value,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				$('#start_date').html(data);
			},
			complete: function(data) {
				//alert('complete');
			},
			error: function(xhr, status, error) {
				//alert('error');
			}
		});
	});
	*/
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
						<input type="hidden" name="kinds" value="1">
						<p><span>스터디 이름 </span><input type="text" name="title" placeholder="스터디원을 불러보세요!"></p>
						<p><span>리더 </span><%= login.getNick() %></p>
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
							<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01"> ~ 
							<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10">
						</p>
						<textarea class="post" name="post" placeholder="어떤 스터디인지 알려주세요!!"></textarea>
						<div class="btn_wrap">
							<a class="btn" href="withus.jsp">뒤로가기</a>
							<input class="btn" type="submit" value="글쓰기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%}%>
<%@ include file="./include/footer.jsp" %>