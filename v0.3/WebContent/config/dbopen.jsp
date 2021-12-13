<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@ page import="ezen.*" %>
<%
//업로드 할 폴더 경로
String uploadPath = "C:\\hje\\WorkSpace\\Studday\\WebContent\\upload";

//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;

//DB 열기
DBManager dbms = new DBManager();
dbms.DBOpen();
%>