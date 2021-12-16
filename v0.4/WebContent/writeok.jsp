<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//인코딩 방식
request.setCharacterEncoding("UTF-8");

//첨부파일을 위한 멀티파트
MultipartRequest multi = 
new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());

//값 받아오기
String cur_page = multi.getParameter("page");  //페이지번호
String key      = multi.getParameter("key");   //검색
String kinds    = multi.getParameter("kinds"); //게시물종류

String bno   = "";														//게시물번호
String no    = login.getNo();									//회원번호
String title = multi.getParameter("title");	//제목
String post  = multi.getParameter("post");	//내용
String lang  = multi.getParameter("lang");	//언어
String start_date = multi.getParameter("start_date");	//시작날짜
String end_date   = multi.getParameter("end_date");		//끝날짜
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

if(kinds.equals("3") || kinds.equals("0"))
{
	//첨부파일이 있으면 추가
	Enumeration files = multi.getFileNames(); //업로드된 파일명을 얻기
	if (files != null) //첨부파일이 있다면 
	{
		String fileid   = (String) files.nextElement();
		String filename = (String) multi.getFilesystemName("attach");
		if (filename != null) //attach 값이 있다면
		{
			System.out.println("파일명 : " + filename);
			
			//랜덤한 파일명 만들기
			String phyname = UUID.randomUUID().toString();   //랜덤이름 만들기
			String srcName    = uploadPath + "/" + filename; //다운로드한 파일 경로
			String targetName = uploadPath + "/" + phyname;  //바꿀 파일 경로
			//파일이름 바꾸기
			File srcFile = new File(srcName);
			File targetFile = new File(targetName); 
			srcFile.renameTo(targetFile);
			
			//첨부파일 정보 등록
			sql = "";
			sql += "insert into attach ";
			sql += "(bno,no,pname,fname) values (";
			sql += "'" + bno + "', ";
			sql += "'" + no + "', ";
			sql += "'" + phyname + "', ";
			sql += "'" + filename + "');";
			System.out.println("SQL: " + sql);
			dbms.RunSQL(sql);
		}
	}
}
%>
<script>
	alert('글쓰기가 완료 되었습니다.');
	window.location = 'view.jsp?kinds=<%= kinds %>&page=1&bno=<%= bno %>';
</script>
<%@ include file="./include/footer.jsp" %>