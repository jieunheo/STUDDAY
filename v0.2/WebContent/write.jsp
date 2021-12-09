<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
String cur_page = request.getParameter("page");  //페이지번호
String kinds    = request.getParameter("kinds"); //게시물종류

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

<!-- 날짜 값을 받아오기 위한 달력 -->
<link rel="stylesheet" href="./css/date.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script>
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
	
	$.datepicker.setDefaults($.datepicker.regional['ko']); 
	$("#start_date").datepicker({
		changeMonth: true, 
		changeYear: true,
		nextText: '다음 달',
		prevText: '이전 달', 
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: "yy-mm-dd",
		minDate: 0,
		maxDate: 30, // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
		onClose: function( selectedDate ) {    
		     //시작일(startDate) datepicker가 닫힐때
		     //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
		    $("#end_date").datepicker( "option", "minDate", selectedDate );
		}
	});
	
	$("#end_date").datepicker({
		changeMonth: true, 
		changeYear: true,
		nextText: '다음 달',
		prevText: '이전 달', 
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: "yy-mm-dd",
		maxDate: 30, // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
		onClose: function( selectedDate ) {    
		    // 종료일(endDate) datepicker가 닫힐때
		    // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
		    $("#start_date").datepicker( "option", "maxDate", selectedDate );
		}
	});
}

// 특수문자 정규식 변수(공백 미포함)
var replaceChar = /[@\#$*\()\=+_'\;<>\/\`:\"\\\[\]|{}]/gi;

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
						<input type="hidden" name="kinds" value="<%= kinds %>">
						<p><span>스터디 이름 </span><input type="text" id="title" name="title" placeholder="스터디원을 불러보세요!"></p>
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
							<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01" readonly> ~ 
							<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10" readonly>
						</p>
						<textarea class="post" name="post" placeholder="어떤 스터디인지 알려주세요!!"></textarea>
						<div class="btn_wrap">
							<a class="btn" href="withus.jsp?kinds=<%= kinds %>&page=<%= cur_page %>">뒤로가기</a>
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