<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

//값 받아오기
String bno      = request.getParameter("bno");	 //게시물번호
String cur_page = request.getParameter("page");	 //페이지번호
String kinds    = request.getParameter("kinds"); //게시물종류
String key      = request.getParameter("key");	 //검색

String no     = login.getNo();									//회원번호
String title  = request.getParameter("title");	//제목
String post   = request.getParameter("post");	  //내용
String lang   = request.getParameter("lang");	  //언어
String start_date = request.getParameter("start_date");	//시작날짜
String end_date   = request.getParameter("end_date");		//끝날짜

if(no == null)
{
	%>
	<script>
		alert('로그인해주세요.');
		document.location = 'login.jsp';
	</script>
	<%
}

if(bno == null || kinds == null || title == null || post == null)
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'index.jsp';
	</script>
	<%
}

if(bno == "" || kinds == "" || title == "" || post == "")
{
	%>
	<script>
		alert('비어있는 항목이 있습니다.');
		document.location = 'index.jsp';
	</script>
	<%
}

//db를 다루기 위한 sql문
String sql = "";
String date_set = "";

sql += "update board set ";
sql += "title = '" + title.replace("'","''") + "',";
sql += "post = '" + post.replace("'","''") + "' ";
if( !(kinds.equals("9") || kinds.equals("0")) )
{
	sql += ", lang = '" + lang +"' ";
	if(kinds.equals("1"))
	{
		if(start_date == null || end_date == null)
		{
			%>
			<script>
				alert('잘못된 접근입니다.');
				window.location = 'index.jsp';
			</script>
			<%
		}
	
		if(start_date == "" || end_date == "")
		{
			%>
			<script>
				alert('잘못된 접근입니다.');
				window.location = 'index.jsp';
			</script>
			<%
		}
		
		date_set += ",start_date = '" + start_date + "'";
		date_set += ",end_date = '" + end_date + "' ";
	}
}
sql += "where bno = '" + bno + "' ";
sql += "and no = '" + login.getNo() + "'";
dbms.RunSQL(sql);
%>
<script>
	alert('글 수정이 완료 되었습니다.');
	window.location = "view.jsp?kinds=<%= kinds %>&page=<%= cur_page %>&key=<%= key %>&bno=<%= bno %>";
</script>
<%@ include file="./include/footer.jsp" %>