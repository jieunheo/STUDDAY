<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="./config/dbopen.jsp" %>
<%
//첨부파일 번호 받아오기
String ano = request.getParameter("fno");
if (ano == null) //없으면 메인으로
{
	response.sendRedirect("index.jsp");
	return;
}

String sql = "";

//파일 이름 검색
sql += "select pname,fname ";
sql += "from attach ";
sql += "where ano=" + ano;
dbms.OpenQuery(sql);

String pname = ""; //첨부파일 번호
String fname = ""; //첨부파일 이름
if (dbms.GetNext() == false)
{
	response.sendRedirect("index.jsp");
	return;
}
pname = dbms.GetValue("pname");
fname = dbms.GetValue("fname");

dbms.CloseQuery();

//파일 경로
String fullname    = uploadPath + "\\" + pname;

//파일 이름 한글 인코딩 - 크롬
//fname = new String(fname.getBytes("UTF-8"), "ISO-8859-1");
fname = URLEncoder.encode(fname, "UTF-8");

response.setContentType("application/octet-stream"); //읽어들일 방식   
response.setHeader("Content-Disposition","attachment; filename=" + fname + "");
//																															다운할 때의 파일 이름 

//파일 받아서 브라우저로 뿌리기
File file = new File(fullname); //파일경로
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096]; //읽어들일 바이트 크기
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>

<%@ include file="./config/dbclose.jsp" %>