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
String key      = request.getParameter("key");   //검색

String no         = "";	//작성자번호
String nickname   = "";	//작성자닉네임
String title      = "";	//제목
String post       = "";	//내용
String lang       = "";	//언어
String date       = "";	//작성날짜
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜
String state      = ""; //모집상태

String strkind   = "";     //게시물종류이름
String strwriter = "작성자"; //작성자표시이름
String strtitle  = "제목";  //글제목표시이름
int    strfilter = -1;     //화면 필터링

String extitle   = "제목을 입력해주세요."; //제목예시
String expost    = "내용을 입력해주세요."; //내용예시

if(cur_page == null) cur_page = "1";
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
		strfilter = 1;
		extitle   = "스터디원을 불러보세요!";     //글제목표시이름
		expost    = "어떤 스터디인지 알려주세요!!"; //글제목표시이름
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

if(bno == null || bno.equals(""))
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'study.jsp';
	</script>
	<%
}

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date today = new Date(); //오늘날짜
String str_today = sdf.format(today);

String sql = "";

sql += "select bno,b.no,kinds,title,post,lang,date,views,";
sql += "date(start_date) as start_date,date(end_date) as end_date, ";
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
		window.location = 'study.jsp';
	</script>
	<%
}

no       = dbms.GetValue("no");
kinds    = dbms.GetValue("kinds");
title    = dbms.GetValue("title");
post     = dbms.GetValue("post");
lang     = dbms.GetValue("lang");
date     = dbms.GetValue("date");
nickname = dbms.GetValue("nickname");

if(strfilter == 1)
{
	start_date = dbms.GetValue("start_date");
	end_date   = dbms.GetValue("end_date");
	
	start_date = start_date.split(" ")[0];
	end_date   = end_date.split(" ")[0];
	
	int end_time = (24*60*60*1000)-1000;
	Date s_date  = new Date(sdf.parse(start_date).getTime());
	Date e_date  = new Date(sdf.parse(end_date).getTime()+end_time);

	//오늘 날짜와 비교
	if (today.getTime() < s_date.getTime())
	{
		state = "모집 대기";
	} else if(today.getTime() >= s_date.getTime() && today.getTime() < e_date.getTime())
	{
		state = "모집 중";
	} else if (today.getTime() > e_date.getTime())
	{
		state = "모집 완료";
	}
}
dbms.CloseQuery();

//첨부파일 얻기
String ano   = ""; //첨부파일 번호
String fname = ""; //첨부파일 이름
if(kinds.equals("3") || kinds.equals("0"))
{
	sql = "";
	sql += "select ano,fname ";
	sql += "from attach ";
	sql += "where bno=" + bno;
	dbms.OpenQuery(sql);
	if (dbms.GetNext() == true)
	{
		ano   = dbms.GetValue("ano");
		fname = dbms.GetValue("fname");
	}
	dbms.CloseQuery();
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
				<div class="category modify">
					<p>Study > <%= strkind %> > Modify</p>
				</div>
				<div>
					<form class="modify" name="write" method="post" action="modifyok.jsp" onsubmit="return FormCheck();" enctype="multipart/form-data">
						<input type="hidden" name="bno" value="<%= bno %>">
						<input type="hidden" name="page" value="<%= cur_page %>">
						<input type="hidden" name="kinds" value="<%= kinds %>">
						<input type="hidden" name="key" value="<%= key %>">
						<p><span><%= strtitle %> </span><input type="text" id="title" name="title" placeholder="<%= extitle %>" value="<%= title %>"></p>
						<p><span><%= strwriter %> </span><%= login.getNick() %></p>
						<%
						if(strfilter != 0)
						{
							%>
							<p>
								<span>언어 </span>
								<select name="lang">
									<option value="java" <%if(lang.equals("java")){%>selected<%}%>>JAVA</option>
									<option value="sql" <%if(lang.equals("sql")){%>selected<%}%>>SQL</option>
									<option value="js" <%if(lang.equals("js")){%>selected<%}%>>Javascript</option>
								</select>
							</p>
							<%
						}
						
						if(strfilter == 1)
						{
							%>
							<p>
								<span>모집 기간 </span>
								<input class="date" type="text" id="start_date" name="start_date" placeholder="ex)2021-12-01" value="<%= start_date %>" readonly> ~ 
								<input class="date" type="text" id="end_date" name="end_date" placeholder="ex)2021-12-10" value="<%= end_date %>" readonly>
							</p>
							<%
						} else
						{
							date = date.split(" ")[0];
							%>
							<p><span>작성일 </span><%= date %></p>
							<%
						}

						if(kinds.equals("3") || kinds.equals("0"))
						{	
							%>
							<p>
								<span>첨부파일 </span>
									<%
									if(fname.equals("")) {
										%>
										첨부파일이 없습니다.
										<%
									} else
									{
										%>
										<a href="download.jsp?fno=<%= ano %>"><%= fname %></a>
										<%
									}
									%>
							</p>
							<p><input class="attach" name="attach" type="file" style="width:95%"></p>
							<%
						}
						%>
						<textarea class="post" name="post" placeholder="<%= extitle %>"><%= post %></textarea>
						
						<div class="btn_wrap">
							<a class="btn" href="view.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>&bno=<%= bno %>">뒤로가기</a>
							<input class="btn" type="submit" value="수정하기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>