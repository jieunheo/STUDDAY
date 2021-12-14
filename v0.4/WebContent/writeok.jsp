<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

//값 받아오기
String cur_page = request.getParameter("page");  //페이지번호
String key      = request.getParameter("key");   //검색
String kinds    = request.getParameter("kinds"); //게시물종류

String bno   = "";														//게시물번호
String no    = login.getNo();									//회원번호
String title = request.getParameter("title");	//제목
String post  = request.getParameter("post");	//내용
String lang  = request.getParameter("lang");	//언어
String start_date = request.getParameter("start_date");	//시작날짜
String end_date   = request.getParameter("end_date");		//끝날짜
String state      = ""; //모집상태

if(no == null)
{
	%>
	<script>
		alert('로그인해주세요.');
		window.location = 'login.jsp';
	</script>
	<%
}

if(kinds == null || title == null || post == null)
{
	%>
	<script>
		alert('비어있는 항목이 있습니다.');
		window.location = 'write.jsp';
	</script>
	<%
}

if(kinds == "" || title == "" || post == "")
{
	%>
	<script>
		alert('비어있는 항목이 있습니다.');
		window.location = 'write.jsp';
	</script>
	<%
}

//db를 다루기 위한 sql문
String sql = "";
String date_set = "";
String lang_set = "";

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
	
	sql += "insert into board (no,kinds,title,post,lang,start_date,end_date) ";
	lang_set += ",'" + lang + "' ";
	date_set += ",'" + start_date + "' ";
	date_set += ",'" + end_date + " 23:59:59' ";

} else
{
	if( !(kinds.equals("0") || kinds.equals("9")) )
	{
		sql += "insert into board (no,kinds,title,post,lang) ";
		lang_set += ",'" + lang + "' ";
	} else
	{
		sql += "insert into board (no,kinds,title,post) ";
	}
}
sql += "value (";
sql += "'" + no + "',";
sql += "'" + kinds + "',";
sql += "'" + title.replace("'","''") + "',";
sql += "'" + post.replace("'","''") + "' ";
sql += lang_set;
sql += date_set + ")";

dbms.RunSQL(sql);
System.out.println(sql);

//마지막 게시물 번호
sql = "select last_insert_id() as bno;";
dbms.OpenQuery(sql);
dbms.GetNext();
bno = dbms.GetValue("bno");
dbms.CloseQuery();
%>
<script>
	alert('글쓰기가 완료 되었습니다.');
	window.location = 'view.jsp?kinds=<%= kinds %>&page=1&bno=<%= bno %>';
</script>
<%@ include file="./include/footer.jsp" %>