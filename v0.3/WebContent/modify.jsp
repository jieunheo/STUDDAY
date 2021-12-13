<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./include/header.jsp" %>
<%
//값 받아오기
String bno 	    = request.getParameter("bno");   //게시물번호
String cur_page = request.getParameter("page");  //페이지번호
String kinds    = request.getParameter("kinds"); //게시물종류
String no       = "";	//작성자번호
String nickname = "";	//작성자닉네임
String title = "";	//제목
String post  = "";	//내용
String lang  = "";	//언어
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜

if(login == null)
{
	%>
	<script>
		alert('로그인 후 작성이 가능합니다.');
		document.location = 'study.jsp';
	</script>
	<%
}

if(bno == null || bno == "")
{
	%>
	<script>
	alert('잘못된 접근입니다.');
	document.location = 'study.jsp';
	</script>
	<%
}

String strkind  = ""; //게시물종류이름
String strwriter = "작성자"; //작성자표시이름
String strtitle  = "제목";  //글제목표시이름
switch (kinds)
{
	case "0": strkind = "Notice"; break;
	case "1": 
		strkind = "With Us";
		strwriter = "리더";
		strtitle  = "스터디이름";
		break;
	case "2":
		strkind = "Lecture";
		strwriter = "추천자";
		break;
	case "3": strkind = "Reference"; break;
	case "4": strkind = "Tip"; break;
	case "5": strkind = "Q&A"; break;
	case "9": strkind = "Talk"; break;
}

String sql = "";

sql += "select bno,b.no,kinds,title,post,lang,date,views,date(start_date) as start_date,date(end_date) as end_date, ";
sql += "u.id,u.nickname,u.user_rank ";
sql += "from board as b ";
sql += "inner join user as u ";
sql += "on b.no = u.no ";
sql += "where bno = '" + bno + "' ";
dbms.OpenQuery(sql);
if(dbms.GetNext() == false)
{
	dbms.CloseQuery();
	%>
	<script>
		alert('없는 게시물입니다.');
		document.location = 'study.jsp';
	</script>
	<%
} else
{
	no = dbms.GetValue("no");
	kinds = dbms.GetValue("kinds");
	title = dbms.GetValue("title");
	post = dbms.GetValue("post");
	lang = dbms.GetValue("lang");
	start_date = dbms.GetValue("start_date");
	end_date = dbms.GetValue("end_date");
	nickname = dbms.GetValue("nickname");
	dbms.CloseQuery();
	
	start_date = start_date.split(" ")[0];
	end_date = end_date.split(" ")[0];

	//게시글 내용 정리
	post = post.replace("<", "&lt;");
	post = post.replace(">", "&gt;");
	post = post.replace("\n", "<br>");
	
	//시작날짜와 끝날짜를 Date로 변환
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	int end_time = (24*60*60*1000)-1000;
	Date s_date = new Date(sdf.parse(start_date).getTime());
	Date e_date = new Date(sdf.parse(end_date).getTime()+end_time);
}
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
				<div class="category modify">
					<p>Study > With Us > Modify</p>
				</div>
				<div>
					<form class="modify" name="write" method="post" action="modifyok.jsp">
						<input type="hidden" name="bno" value="<%= bno %>">
						<input type="hidden" name="kinds" value="<%= kinds %>">
						<input type="hidden" name="page" value="<%= cur_page %>">
						<p><span><%= strtitle %> </span><input type="text" id="title" name="title" placeholder="스터디원을 불러보세요!" value="<%= title %>"></p>
						<p><span><%= strwriter %> </span><%= nickname %></p>
						<p>
							<span>언어 </span>
							<select name="lang">
								<option value="java" <%if(lang.equals("java"))%>selected<%; %>>JAVA</option>
								<option value="sql" <%if(lang.equals("sql"))%>selected<%; %>>SQL</option>
								<option value="js" <%if(lang.equals("js"))%>selected<%; %>>Javascript</option>
							</select>
						</p>
						<p>
							<span>모집 기간 </span>
							<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01" value="<%= start_date %>" readonly> ~ 
							<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10" value="<%= end_date %>" readonly>
						</p>
						<textarea class="post" name="post" placeholder="어떤 스터디인지 알려주세요!!"><%= post %></textarea>
						<div class="btn_wrap">
							<a class="btn" href="view.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&bno=<%= bno %>">뒤로가기</a>
							<input class="btn" type="submit" value="수정하기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>