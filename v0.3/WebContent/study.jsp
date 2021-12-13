<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./include/header.jsp" %>
<%
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
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜
String state      = ""; //모집상태

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

//kinds 값 분석(0/1/2/3/4/5/9)
kinds = request.getParameter("kinds");
if (kinds == null)	kinds = "1"; //값이 없으면 1로

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
sql += "where kinds = '" + kinds + "' ";
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
sql += "select bno,b.no,kinds,title,lang,date,views,date(start_date) as start_date,date(end_date) as end_date, ";
sql += "u.id,u.nickname,u.user_rank ";
sql += "from board as b ";
sql += "inner join user as u ";
sql += "on b.no = u.no ";
sql += "where kinds = '" + kinds + "' ";
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
<script>
	window.onload = function ()
	{
		$.ajax({
			type: "get",
			url: "board.jsp?kinds=<%= kinds %>",
			dataType: "html",
			success: function(data) {
				data = data.trim();
			}
		});
	}
</script>
<div class="main">
	<div class="wrap">
		<div class="study <%if(kinds.equals("1")){%>withus<%}else{%>recture<%}%> text">
			<h3><%= strmenu %></h3>
			<%
			if(kinds.equals("0") || kinds.equals("9"))
			{
				%>
				<div class="notice">
					<%if(kinds.equals("0")){%><p>홈페이지에 관한 내용이 공지 됩니다. 확인해주세요 :)</p><%}%>
					<%if(kinds.equals("9")){%><p>우리 모두 다함께 노닥노닥 :)</p><%}%>
				</div>
				<%
			} else
			{
				%>
				<div class="tab_menu">
					<ul>
						<li><a href="study.jsp?kinds=1" <%if(kinds.equals("1")){%>class="now"<%}%>>With Us</a></li>
						<li><a href="study.jsp?kinds=2"<%if(kinds.equals("2")){%>class="now"<%}%>>Lecture</a></li>
						<li><a href="study.jsp?kinds=3"<%if(kinds.equals("3")){%>class="now"<%}%>>Reference</a></li>
						<li><a href="study.jsp?kinds=4"<%if(kinds.equals("4")){%>class="now"<%}%>>Tip</a></li>
						<li><a href="study.jsp?kinds=5"<%if(kinds.equals("5")){%>class="now"<%}%>>Q&A</a></li>
					</ul>
				</div>
				<%
			}
			%>
			<div>
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
								%>
								<th>언어</th>
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
					while (dbms.GetNext() == true)
					{
						bno        = dbms.GetValue("bno");
						no         = dbms.GetValue("no");
						nickname   = dbms.GetValue("nickname");
						kinds      = dbms.GetValue("kinds");
						title      = dbms.GetValue("title");
						lang       = dbms.GetValue("lang");
						date       = dbms.GetValue("date");
						start_date = dbms.GetValue("start_date");
						end_date   = dbms.GetValue("end_date");
						
						if(kinds.equals("1"))
						{
							int end_time = (24*60*60*1000)-1000;
							Date s_date = new Date(sdf.parse(start_date).getTime());
							Date e_date = new Date(sdf.parse(end_date).getTime()+end_time);
							//System.out.println(s_date);
							//System.out.println(e_date);
	
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
							<td><a href="view.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&bno=<%= bno %>"><%= title %></a></td>
							<%
							if(kinds.equals("1"))
							{
								%>
								<td><%= start_date %> ~ <%= end_date %></td>
								<td <% if(state.equals("모집 중")){%>class="ing"<%}%>><%= state %></td>
								<%
							} else
							{
								%>
								<td><%= lang %></td>
								<td><%= date.split(" ")[0] %></td>
								<%
							}
							%>
							<td><%= nickname %></td>
						</tr>
						<%
					}
					%>
					</tbody>
				</table>
				<%
				if(login != null)
				{
					%>
					<div class="btn_wrap">
						<a class="btn" href="write.jsp?kinds=<%= kinds %>&page=<%= cur_page %>">글쓰기</a>
					</div>
					<%
				}
				%>
				<div class="paging">
					<ul>
						<%
						//(13)이전 블럭 출력
						if( start_block >= page_cut ) //시작 페이지가 페이지 컷 기준보다 크면
						{
							%><li><a href="study.jsp?kinds=<%= kinds %>&page=<%= start_block - 1 %>">◀</a></li><%
						}
						//(3,4,11)최대 페이지 갯수만큼 페이지 표시
						for (int pageno = start_block; pageno <= end_block; pageno++)
						{
							%>
							<li>
								<a href="study.jsp?kinds=<%= kinds %>&page=<%= pageno %>" <% if (cur_page == pageno) %>class="now"<%; %>>
									<%= pageno %> 
								</a>
							</li>
							<%
						}
						//(12)다음 블럭 출력
						if( end_block < max_page) //끝 페이지가 최대 페이지보다 작으면
						{
							%><li><a href="study.jsp?kinds=<%= kinds %>&page=<%= end_block + 1 %>">▶</a></li><%
						}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>