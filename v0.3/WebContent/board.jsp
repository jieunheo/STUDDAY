<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="./config/dbopen.jsp"%>
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
String kinds    = request.getParameter("kinds");	//게시물종류
String strkind  = "";	//게시물종류이름
String title    = "";	//제목
String post     = "";	//내용
String lang     = "";	//언어
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜
String state      = ""; //모집상태


%>
<%@ include file="./config/dbclose.jsp"%>