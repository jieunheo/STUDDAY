<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./config/dbopen.jsp" %>
<%
LoginVo login = (LoginVo)session.getAttribute("login");	//로그인정보

//페이징을 위한 변수 선언
int total    = 0;  //전체 게시물 갯수
int max_page = 0;  //최대 페이지 갯수
int cur_page = 0;  //현재 페이지 번호
int start_no = 0;  //페이지 첫 게시물 번호
int paging_list = 10; //페이지에 나올 게시물 갯수

int page_cut    = 10; //나열될 페이지 번호의 갯수
int start_block = 0;  //페이징 시작 블록 번호
int end_block   = 0;  //페이징 끝 블록 번호

//값 받아오기
String bno 	    = ""; //게시물번호
String no       = "";	//작성자번호
String nickname = "";	//작성자닉네임
String kinds    = "";	//게시물종류
String title    = "";	//제목
String post     = "";	//내용
String lang     = "";	//언어
String date     = "";	//작성일
String start_date  = ""; //시작날짜
String end_date    = ""; //끝날짜
String state       = ""; //모집상태
String key         = ""; //검색
String reply_count = ""; //댓글 갯수

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

//kinds 값 분석(0/1/2/3/4/5/9)
kinds = request.getParameter("kinds");
if (kinds == null)	kinds = "1"; //값이 없으면 1로

//key 값 분석
key = request.getParameter("key");

//where절
String str_where = "";
str_where += "where kinds = '" + kinds + "' ";
if(key != null) str_where += "and title like '%" + key + "%' ";

String strkind  = ""; //게시물종류이름
String strwriter = "작성자";  //작성자표시이름
String strtitle  = "제목";   //글제목표시이름
String strmenu   = "STUDY"; //메뉴표시이름
switch (kinds)
{
	case "0": 
		strkind = "Notice";
		strmenu = "Notice";
		break;
	case "1": 
		strkind = "With Us";
		strwriter = "리더";
		strtitle  = "스터디이름";
		break;
	case "2":
		strkind = "Lecture";
		strwriter = "추천자";
		strtitle  = "추천 강의 제목";
		break;
	case "3": strkind = "Reference"; break;
	case "4": strkind = "Tip"; break;
	case "5": strkind = "Q&A"; break;
	case "9":
		strkind = "Talk";
		strmenu = "Talk";
		break;
}

//(5)넘어온 값 page를 분석
if (request.getParameter("page") != null) //넘어온 페이지 번호
{ //비어있지 않으면 curpage에 해당 값 할당
	cur_page = Integer.parseInt(request.getParameter("page"));
} else
{ //비어있으면 1
	cur_page = 1;
}

String sql = "";
//(1)게시물 갯수 확인
sql = "";
sql += "select count(*) as count from board ";
sql += str_where;
dbms.OpenQuery(sql);
dbms.GetNext();
total = dbms.GetInteger("count");
dbms.CloseQuery();

//(6)페이지 첫 게시물 번호 계산
start_no = (cur_page - 1) * paging_list;

//(2)최대 페이지 갯수 계산
max_page = total/paging_list;
if ((total % paging_list) != 0) max_page++; //나머지가 있는 경우 +1

//게시물 목록 조회
sql = "";
sql += "select bno,b.no,kinds,title,lang,date,views,";
sql += "date(start_date) as start_date,date(end_date) as end_date, ";
sql += "(select count(*) from reply where bno = b.bno) as reply_count, ";
sql += "u.id,u.nickname,u.user_rank ";
sql += "from board as b ";
sql += "inner join user as u ";
sql += "on b.no = u.no ";
sql += str_where;
sql += "order by bno desc ";
//(7)페이지 당 가져올 게시물 limit
sql += "limit " + start_no + ", " + paging_list + ";";
dbms.OpenQuery(sql);
//(8)실행 및 consol에 SQL구문 확인 출력
System.out.println(sql);

//(9)페이징 시작 블록 번호와 끝 블록 번호 계산
start_block = ((cur_page - 1) / page_cut) * page_cut + 1;
end_block = start_block + page_cut - 1;
//(10)end_block이 maxpage보다 클 경우
if (end_block >= max_page)
{ //끝 페이지를 최대 페이지로
	end_block = max_page;
}
%>
<table id="board_table">
	<thead>
		<tr>
			<th>번호</th>
			<th><%= strtitle %></th>
			<%
			if(kinds.equals("1"))
			{
				%>
				<th>모집 기간</th>
				<th>모집 여부</th>
				<%
			} else
			{
				if( !(kinds.equals("0") || kinds.equals("9")) )
				{
					%>
					<th>언어</th>
					<%
				}
				%>
				<th>날짜</th>
				<%
			}
			%>
			<th><%= strwriter %></th>
		</tr>
	</thead>
	<tbody>
	<%
	int seqno = total - start_no; //total - ((cur_page - 1) * 10);
	if(dbms.GetNext())
	{
		do
		{
			bno         = dbms.GetValue("bno");
			no          = dbms.GetValue("no");
			nickname    = dbms.GetValue("nickname");
			kinds       = dbms.GetValue("kinds");
			title       = dbms.GetValue("title");
			lang        = dbms.GetValue("lang");
			date        = dbms.GetValue("date");
			start_date  = dbms.GetValue("start_date");
			end_date    = dbms.GetValue("end_date");
			reply_count = dbms.GetValue("reply_count");
			
			if( !(kinds.equals("0") || kinds.equals("9")) )
			{
				if(lang.equals("java"))     lang = "JAVA";
				else if(lang.equals("sql")) lang = "SQL";
				else if(lang.equals("js"))  lang = "Javascript";
			}
			
			if(kinds.equals("1"))
			{
				int end_time = (24*60*60*1000)-1000;
				Date s_date = new Date(sdf.parse(start_date).getTime());
				Date e_date = new Date(sdf.parse(end_date).getTime()+end_time);
	
				//오늘 날짜와 비교
				Date today = new Date();		//오늘날짜
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
			%>
			<tr>
				<td><%= seqno-- %></td>
				<td>
					<a href="view.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>&bno=<%= bno %>">
						<%= title %><%if(!reply_count.equals("0")){%> <span class="relpy_count">[<%= reply_count %>]</span><%}%>
					</a>
				</td>
				<%
				if(kinds.equals("1"))
				{
					%>
					<td><%= start_date %> ~ <%= end_date %></td>
					<td <% if(state.equals("모집 중")){%>class="ing"<%}%>><%= state %></td>
					<%
				} else
				{
					if(!(kinds.equals("9") || kinds.equals("0")) )
					{
						%>
						<td><%= lang %></td>
						<%
					}
					%>
					<td><%= date.split(" ")[0] %></td>
					<%
				}
				%>
				<td><%= nickname %></td>
			</tr>
			<%
		} while (dbms.GetNext() == true);
	} else {
		%>
		<tr>
			<td colspan="5">게시물이 없습니다.</td>
		</tr>
		<%
	}
	%>
	</tbody>
</table>
<div class="table_btn_wrap">
	<form class="search" name="search" method="get" action="">
		<input id="key" type="text" name="key" value="">
		<input class="btn" type="submit" value="검색">
		<%
		if(login != null)
		{
			%>
			<a class="btn" href="write.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>">글쓰기</a>
			<%
		}
		%>
	</form>
</div>
<div class="paging">
	<ul>
		<%
		//(13)이전 블럭 출력
		if( start_block >= page_cut ) //시작 페이지가 페이지 컷 기준보다 크면
		{
			%><li><a href="study.jsp?kinds=<%= kinds %>&page=<%= start_block - 1 %>&key=<%= key %>">◀</a></li><%
		}
		//(3,4,11)최대 페이지 갯수만큼 페이지 표시
		for (int pageno = start_block; pageno <= end_block; pageno++)
		{
			%>
			<li>
				<a href="study.jsp?kinds=<%= kinds %>&page=<%= pageno %>&key=<%= key %>" <% if (cur_page == pageno) %>class="now"<%; %>>
					<%= pageno %> 
				</a>
			</li>
			<%
		}
		//(12)다음 블럭 출력
		if( end_block < max_page) //끝 페이지가 최대 페이지보다 작으면
		{
			%><li><a href="study.jsp?kinds=<%= kinds %>&page=<%= end_block + 1 %>&key=<%= key %>">▶</a></li><%
		}
		%>
	</ul>
</div>
<%@ include file="./config/dbclose.jsp" %>