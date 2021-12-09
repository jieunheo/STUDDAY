<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
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

if(kinds == null || title == null || post == null || lang == null || start_date == null || end_date == null)
{
	%>
	<script>
		alert('잘못된 접근입니다.');
		document.location = 'index.jsp';
	</script>
	<%
}

if(kinds == "" || title == "" || post == "" || lang == "" || start_date == "" || end_date == "")
{
	%>
	<script>
		alert('비어있는 항목이 있습니다.');
		document.location = 'write.jsp';
	</script>
	<%
}

/*
System.out.println(no);
System.out.println(kinds);
System.out.println(title);
System.out.println(post);
System.out.println(lang);
System.out.println(start_date);
System.out.println(end_date);
*/

//시작날짜와 끝날짜를 Date로 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

int end_time = (24*60*60*1000)-1000;
Date s_date = new Date(sdf.parse(start_date).getTime());
Date e_date = new Date(sdf.parse(end_date).getTime()+end_time);
//System.out.println(s_date);
//System.out.println(e_date);

//오늘 날짜와 비교
Date today = new Date();		//오늘날짜
if (today.getTime() > s_date.getTime())
{
	state = "모집 대기";
} else if(today.getTime() <= s_date.getTime() && today.getTime() < e_date.getTime())
{
	state = "모집 중";
} else if (today.getTime() > e_date.getTime())
{
	state = "모집 완료";
}

//db를 다루기 위한 sql문
String sql = "";

sql += "insert into board (no,kinds,title,post,lang,start_date,end_date,state) ";
sql += "value (";
sql += "'" + no + "',";
sql += "'" + kinds + "',";
sql += "'" + title + "',";
sql += "'" + post + "',";
sql += "'" + lang + "',";
sql += "'" + start_date + "',";
sql += "'" + end_date + " 23:59:59',";
sql += "'" + state + "')";
dbms.RunSQL(sql);
System.out.println(sql);

bno = dbms.GetLastID("bno");
%>
<script>
	alert('글쓰기가 완료 되었습니다.');
	document.location = 'view.jsp?bno=' + bno;
</script>
<%@ include file="./include/footer.jsp" %>