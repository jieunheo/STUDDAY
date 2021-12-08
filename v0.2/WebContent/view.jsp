<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//값 받아오기
String bno 	 = request.getParameter("bno"); //게시물번호
String no       = "";	//작성자번호
String nickname = "";	//작성자닉네임
String kinds = "";	//게시물종류
String title = "";	//제목
String post  = "";	//내용
String lang  = "";	//언어
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜
String state      = ""; //모집상태

if(bno == null || bno == "")
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'withus.jsp';
	</script>
	<%
}

String sql = "";

sql += "select * ";
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
	state = dbms.GetValue("state");
	nickname = dbms.GetValue("nickname");
	dbms.CloseQuery();
	
	start_date = start_date.split(" ")[0];
	end_date = end_date.split(" ")[0];
}

%>
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
							<div class="content">
								<%= post %>
							</div>
							<div class="btn_wrap">
								<a class="btn" href="withus.jsp">뒤로가기</a>
								<a class="btn" href="modify.jsp">글수정</a>
								<a class="btn" href="delete.jsp">글삭제</a>
							</div>
						</div>
						<div class="comment_wrap">
							<div class="line"></div>
							<div class="comment now">
								<form name="comment">
									<span>홍선생</span>
									<input type="text" name="comment" placeholder="댓글을 입력해주세요">
									<span class="date">2021-12-03</span>
									<input class="btn" type="submit" value="댓글달기">
								</form>
							</div>
							
							<%
							for(int i=0; i<3; i++)
							{
								%>
								<div class="comment">
									<span>홍선생</span>
									<p>아주 좋아요</p>
									<span class="date">2021-12-0<%= 3-i %></span>
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