<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

//값 받아오기
String bno   = "";														//게시물번호
String no    = login.getNo();									//회원번호
String kinds  = request.getParameter("kinds");	//게시물종류
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
		document.location = 'login.jsp';
	</script>
	<%
}

if(kinds == null || title == null || post == null || lang == null)
{
	%>

	<%
}

if(kinds == "" || title == "" || post == "" || lang == "")
{
	%>
	<script>
		alert('비어있는 항목이 있습니다.');
		document.location = 'write.jsp';
	</script>
	<%
}


//db를 다루기 위한 sql문
String sql = "";

if(kinds.equals("1"))
{
	if(start_date == null || end_date == null)
	{
		%>
		<script>
		alert('잘못된 접근입니다.');
		document.location = 'index.jsp';
	</script>
	<%
	}
	
	if(start_date == "" || end_date == "")
	{
		%>
		<script>
		alert('잘못된 접근입니다.');
		document.location = 'index.jsp';
	</script>
	<%
	}

	sql += "insert into board (no,kinds,title,post,lang,start_date,end_date) ";
	sql += "value (";
	sql += "'" + no + "',";
	sql += "'" + kinds + "',";
	sql += "'" + title.replace("'","''") + "',";
	sql += "'" + post.replace("'","''") + "',";
	sql += "'" + lang + "',";
	sql += "'" + start_date + "',";
	sql += "'" + end_date + " 23:59:59')";
} else
{
	sql += "insert into board (no,kinds,title,post,lang) ";
	sql += "value (";
	sql += "'" + no + "',";
	sql += "'" + kinds + "',";
	sql += "'" + title.replace("'","''") + "',";
	sql += "'" + post.replace("'","''") + "',";
	sql += "'" + lang + "')";
}
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
	<%
	response.sendRedirect("view.jsp?kinds=" + kinds + "&bno=" + bno);
	%>
</script>
<%@ include file="./include/footer.jsp" %>