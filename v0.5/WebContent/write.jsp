<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./include/header.jsp" %>
<!-- 날짜 값을 받아오기 위한 달력 -->
<link rel="stylesheet" href="./css/date.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<%
String cur_page = request.getParameter("page");  //페이지번호
String kinds    = request.getParameter("kinds"); //게시물종류
String key      = request.getParameter("key");   //검색

String strkind   = "";     //게시물종류이름
String strwriter = "작성자"; //작성자표시이름
String strtitle  = "제목";  //글제목표시이름
int    strfilter = -1;     //화면 필터링

String extitle   = "제목을 입력해주세요."; //제목예시
String expost    = "내용을 입력해주세요."; //내용예시

switch (kinds)
{
	case "0":
		strkind = "Notice";
		strfilter = 0;
		break;
	case "1": 
		strkind = "With Us";
		strwriter = "리더";
		strtitle  = "스터디이름";
		extitle   = "스터디원을 불러보세요!";     //글제목표시이름
		expost    = "어떤 스터디인지 알려주세요!!"; //글제목표시이름
		strfilter = 1;
		break;
	case "2":
		strkind = "Lecture";
		strwriter = "추천자";
		break;
	case "3": strkind = "Reference"; break;
	case "4": strkind = "Tip"; break;
	case "5": strkind = "Q&A"; break;
	case "9":
		strkind = "Talk";
		strfilter = 0;
		break;
}

//권한검사
if(login == null)
{
	%>
	<script>
		alert('로그인 후 작성이 가능합니다.');
		window.location = 'study.jsp';
	</script>
	<%
}

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date today = new Date(); //오늘날짜
String str_today = sdf.format(today);
%>
<script>
	//특수문자 정규식 변수(공백 미포함)
	var replaceChar = /[@\#$*\()\=+_'\;<>\/\`:\"\\\[\]|{}]/gi;
	
	window.onload = function()
	{
		document.write.title.focus();
		
		$("#title").on("focusout", function() {
	    var x = $(this).val();
	    if (x.length > 0) {
		    if (x.match(replaceChar)) {
		        x = x.replace(replaceChar, "");
		    }
		    $(this).val(x);
	    }
	  }).on("keyup", function() {
			$(this).val($(this).val().replace(replaceChar, ""));
		});
		
		//달력
		StartDate();
		EndDate();
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
					<p>Study > <%= strkind %> > Write</p>
				</div>
				<div>
					<form class="write" name="write" method="post" action="writeok.jsp" enctype="multipart/form-data" onsubmit="return FormCheck();">
						<input type="hidden" name="kinds" value="<%= kinds %>">
						<input type="hidden" name="page" value="<%= cur_page %>">
						<input type="hidden" name="key" value="<%= key %>">
						<p><span><%= strtitle %> </span><input type="text" id="title" name="title" placeholder="<%= extitle %>"></p>
						<p><span><%= strwriter %> </span><%= login.getNick() %></p>
						<%
						if(strfilter != 0)
						{
							%>
							<p>
								<span>언어 </span>
								<select name="lang">
									<option value="java">JAVA</option>
									<option value="sql">SQL</option>
									<option value="js">Javascript</option>
								</select>
							</p>
							<%
						}
						%>
						<p>
							<%
							if(strfilter == 1)
							{
								%>
								<span>모집 기간 </span>
								<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01" readonly> ~ 
								<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10" readonly>
								<%
							} else
							{
								%>
								<span>작성일 </span><%= str_today %>
								<%
							}
							%>
						</p>
						<%
						if(kinds.equals("3") || kinds.equals("0"))
						{	
							%>
							<p><span>첨부파일 </span><input name="attach" type="file"></p>
							<%
						}
						%>
						<textarea class="post" name="post" placeholder="<%= extitle %>"></textarea>
						
						<div class="btn_wrap">
							<a class="btn" href="study.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>">뒤로가기</a>
							<input class="btn" type="submit" value="글쓰기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>