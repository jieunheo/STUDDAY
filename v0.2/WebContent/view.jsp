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
String state      = ""; //모집상태

if(bno == null || bno.equals(""))
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'withus.jsp';
	</script>
	<%
}

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date today = new Date();		//오늘날짜

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
		document.location = 'withus.jsp';
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
	
	if(lang.equals("java")) lang = "JAVA";
	else if(lang.equals("sql")) lang = "SQL";
	else if(lang.equals("js")) lang = "Javascript";

	int end_time = (24*60*60*1000)-1000;
	Date s_date = new Date(sdf.parse(start_date).getTime());
	Date e_date = new Date(sdf.parse(end_date).getTime()+end_time);
	//System.out.println(s_date);
	//System.out.println(e_date);

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
%>
<script>
	function FormCheck()
	{
		if(document.reply.rpost.value == "")
		{
			alert('댓글을 입력해주세요.');
			document.reply.rpost.focus();
			return false;
		}
		return ReplyCheck();
	}

	function ReplyCheck()
	{
		if(!confirm('댓글을 작성하시겠습니까?')) return false;
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
							<p><span>스터디 이름 </span><%= title %></p>
							<p><span>리더 </span><%= nickname %></p>
							<p><span>언어 </span><%= lang %></p>
							<p><span>모집 여부 </span><%= state %></p>
							<p><span>모집 기간 </span><%= start_date %> ~ <%= end_date %></p>
							<div class="line"></div>
							<div class="content"><%= post %></div>
							<div class="btn_wrap">
								<a class="btn" href="withus.jsp?kinds=<%= kinds %>&page=<%= cur_page %>">뒤로가기</a>
								<%
								if (login != null)
								{
									if(login.getRank().equals("A") || login.getNo().equals(no))
									{
										if(login.getNo().equals(no))
										{
											%>
											<a class="btn" href="modify.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&bno=<%= bno %>">글수정</a>
											<%
										}
										%>
										<a class="btn" href="delete.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&bno=<%= bno %>" onclick="return confirm('삭제하시겠습니까?');">글삭제</a>
									<%
									}
								}
								%>
							</div>
						</div>
						<div class="reply_wrap">
							<div class="line"></div>
							<%
							if(login != null)
							{
								%>
								<div class="reply now">
									<form name="reply" onsubmit="return FormCheck();" method="post" action="view.jsp">
										<input type="hidden" name="bno" value="<%= bno %>">
										<input type="hidden" name="kinds" value="<%= kinds %>">
										<input type="hidden" name="page" value="<%= cur_page %>">
										<input type="hidden" name="rdate" value="<%= today %>">
										<span><%= login.getNick() %></span>
										<input type="text" name="rpost" placeholder="댓글을 입력해주세요">
										<span class="date"><%= sdf.format(today) %></span>
										<input class="btn" type="submit" value="댓글달기">
									</form>
								</div>
								<%
							}
						
							sql = "";
							sql += "select rno,bno,r.no,rpost,rdate,u.nickname ";
							sql += "from reply as r ";
							sql += "inner join user as u ";
							sql += "on r.no = u.no ";
							sql += "where bno = '" + bno + "' ";
							sql += "order by rno desc ";
							dbms.OpenQuery(sql);
							while(dbms.GetNext())
							{
								String rno         = dbms.GetValue("rno");      //댓글번호
								String reply_nick  = dbms.GetValue("nickname"); //댓글 작성자 닉네임
								String rpost       = dbms.GetValue("rpost");    //댓글내용
								String rdate       = dbms.GetValue("rdate");    //댓글 작성일
								%>
								<div class="reply">
									<span><%= reply_nick %></span>
									<p><%= rpost %></p>
									<span class="date"><%= rdate.split(" ")[0] %></span>
									<a href=#>삭제</a>
								</div>
								<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>