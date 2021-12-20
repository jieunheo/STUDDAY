<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./include/header.jsp" %>
<%
//값 받아오기
String cur_page   = request.getParameter("page");  //페이지번호
String kinds      = request.getParameter("kinds"); //게시물종류
String key        = request.getParameter("key");   //검색어

String bno 	      = request.getParameter("bno");   //게시물번호
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

if(cur_page == null || cur_page.equals("")) cur_page = "1";
if(kinds == null    || kinds.equals(""))    kinds = "1";
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
Date today = new Date();		//오늘날짜

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
title    = dbms.GetValue("title");
post     = dbms.GetValue("post");
lang     = dbms.GetValue("lang");
date     = dbms.GetValue("date");
nickname = dbms.GetValue("nickname");

if(kinds.equals("1"))
{
	start_date = dbms.GetValue("start_date"); //시작날짜
	end_date   = dbms.GetValue("end_date");   //끝날짜
	
	//날짜의 년월일만 받아오기
	start_date = start_date.split(" ")[0];
	end_date   = end_date.split(" ")[0];
	
	//yyyy-MM-dd 형태 문자열을 날짜로 변환
	int end_time = (24*60*60*1000)-1000; //해당 날짜의 23시59분59초
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
} else if ( strfilter != 0 )
{
	switch(lang)
	{
		case "java": lang = "JAVA"; break;
		case "sql": lang = "SQL"; break;
		case "js": lang = "Javascript"; break;
	}
}

post = post.replace("\n", "<br>");
dbms.CloseQuery();

String ano   = ""; //첨부파일 번호
String fname = ""; //첨부파일 이름
if(kinds.equals("3") || kinds.equals("0"))
{
	//첨부파일 얻기
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
<script>
	window.onload = function ()
	{
		ReadReply(<%= bno %>);
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category view">
					<p>Study > <%= strkind %> > View</p>
				</div>
				<div>
					<div class="view">
						<div>
							<p><span><%= strtitle %> </span><%= title %></p>
							<p><span><%= strwriter %> </span><%= nickname %></p>
							<%
							if(strfilter != 0)
							{
								if(lang.equals("java"))lang = "Java";
								if(lang.equals("sql"))lang = "SQL";
								if(lang.equals("js"))lang = "Javascript";
								%>
								<p><span>언어 </span><%= lang %></p>
								<%
							}
							
							if(strfilter == 1)
							{
								%>
								<p><span>모집 여부 </span><%= state %></p>
								<p><span>모집 기간 </span><%= start_date %> ~ <%= end_date %></p>
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
										%>첨부파일이 없습니다.<%
									} else
									{
										%>
										<a class="down_btn" href="download.jsp?fno=<%= ano %>"><%= fname %></a>
										<%
									}
									%>
								</p>
								<%
							}
							%>
							<div class="line"></div>
							<div class="content"><%= post %></div>
							
							<div class="btn_wrap">
								<a class="btn" href="study.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>">뒤로가기</a>
								<%
								if(login != null)
								{
									if(login.getNo().equals(no) || login.getRank().equals("A"))
									{
										if(login.getNo().equals(no))
										{
											%>
											<a class="btn" href="modify.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>&bno=<%= bno %>">글수정</a>
											<%
											}
										%>
										<a class="btn" href="delete.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>&bno=<%= bno %>" onclick="return confirm('삭제하시겠습니까?');">글삭제</a>
									<%
									}
								}
								%>
							</div>
						</div>
						
						<div id="reply_wrap" class="reply_wrap"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>