<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<%
//값 받아오기
String bno 	    = ""; //게시물번호
String title    = "";	//제목
String lang     = "";	//언어
String start_date = "";	//시작날짜
String end_date   = "";	//끝날짜
String state      = ""; //모집상태
String key        = ""; //검색

String sql = "";
//where절
String str_where = "";
str_where += "where kinds = '1' ";
str_where += "and end_date > now() ";

sql += "select bno,no,kinds,title,lang,date,views,";
sql += "start_date,end_date ";
sql += "from board ";
sql += str_where;
sql += "order by bno desc ";
//(7)페이지 당 가져올 게시물 limit
sql += "limit 8;";
dbms.OpenQuery(sql);

if(login != null)
{
	login.printInfo();
}
%>
<script>
	var imgs;
	var img_count;
	var img_position = 1;
	
	window.onload = function ()
	{
		imgs = $("#items");
		img_count = imgs.children().length;
		
		$('#before_btn').click(function() {
			NextItem();
		});
		
		$('#after_btn').click(function() {
			PrevItem();
		});
	}
	
	function PrevItem()
	{
		var left = imgs.css("left").replace("px","");
    if(1<=img_position && img_position<=4){
    	imgs.css("left",left-240);
			img_position++;
		}
	}

	function NextItem()
	{
		var left = imgs.css("left").replace("px","");
		if(1<img_position){
    	imgs.css("left",+left+240);
			img_position--;
		}
	}

	function FormChwck() {
		if($('#send_email').val() == "")
		{
			alert('이메일을 입력해주세요!');
			$('#send_email').focus();
			return false;
		}
		
		if($('#title').val() == "")
		{
			alert('문의 제목을 입력해주세요!');
			$('#title').focus();
			return false;
		}
		
		if($('#body').val() == "")
		{
			alert('문의 내용을 입력해주세요!');
			$('#body').focus();
			return false;
		}
		
		if(confirm('관리자에게 메일을 보내도록 할게요!!'))
		{
			var email = $('#send_email').val();
			var title = $('#title').val();
			var body  = $('#body').val();
			
			$.ajax({
				type: "get",
				url: "sendok.jsp?send_email=" + email + "&title=" + title + "&body=" + body,
				dataType: "html",
				success: function(data) {
					data = data.trim();
					
					if(data == 01)
					{
						alert('성공적으로 전송되었습니다.');
					} else {
						alert('Opss! 전송이 안되었어요!');
					}
					
					$('#title').val('');
					$('#body').val('');
				}
			});
		}
		return false;
	}
</script>
<div class="main">
	<div class="banner">
		<div class="wrap">
			<div>
				<div class="title">
					<h2>WELCOME STUDDAY</h2>
					<p>혼자 하기 버거운 공부를 함께 하는 공간</p>
					<p>오늘도 공부하는 날 :)</p>
				</div>
				<div class="b_btn">
				<%
				if(login == null)
				{
					%>
					<a href="login.jsp" onclick="alert('로그인 해주세요!');">동료 구하기</a>
					<%
				} else
				{
					%>
					<a href="study.jsp">동료 구하기</a>
					<%
				}
				%>
				</div>
			</div>
		</div>
	</div>
	
	<div class="icons">
		<div class="wrap">
			<a class="icon" href="study.jsp?kinds=1">
				<img alt="How To" src="./img/icon_how.png">
				<p>How To</p>
			</a>
			<a class="icon" href="study.jsp?kinds=3">
				<img alt="How To" src="./img/icon_ref.png">
				<p>Ref</p>
			</a>
			<a class="icon" href="study.jsp?kinds=4">
				<img alt="How To" src="./img/icon_tip.png">
				<p>Tip</p>
			</a>
			<a class="icon" href="study.jsp?kinds=9">
				<img alt="How To" src="./img/icon_qa.png">
				<p>Q&A</p>
			</a>
			<a class="icon" href="study.jsp?kinds=0">
				<img alt="How To" src="./img/icon_notice.png">
				<p>Notice</p>
			</a>
		</div>
	</div>
	
	<div class="study_list">
		<div class="wrap">
			<div class="text">
				<h3>With Us</h3>
				<p>마음에 드는 스터디를 찾아 함께 해보세요 :)</p>
			</div>
			<div>
				<a id="before_btn" class="before_btn" href="javscript:PrevItem();"></a>
				<div class="overflow">
					<ul id="items" class="items">
						<%
						//withus의 최근 게시글 8개 불러오기
						while (dbms.GetNext())
						{
							bno      = dbms.GetValue("bno");
							title      = dbms.GetValue("title");
							lang       = dbms.GetValue("lang");
							
							%>
							<li class="item">
								<a href="view.jsp?kinds=1&page=1&key=<%= key %>&bno=<%= bno %>">
									<div class="thumb thumb<%if(lang.equals("java")){%>1<%}else if(lang.equals("sql")){%>2<%}else{%>3<%}%>"></div>
									<p><%= title %></p>
								</a>
							</li>
							<%
						}
						%>
						<li class="item"></li>
					</ul>
				</div>
				<a id="after_btn" class="after_btn" href="javscript:NextItem();"></a>
			</div>
		</div>
	</div>
	
	<div class="request">
		<div class="wrap">
			<div class="text">
				<h3>Request</h3>
				<p>언제든 문의하실 내용 있으시면 폼 보내주세요 :)</p>
			</div>
			<form class="form" name="request" action="" method="post" onsubmit="return FormChwck();">
				<p><input id="send_email" type="email" name="send_email" placeholder="이메일" value="<%if(login != null){%><%=login.getEmail()%><%}%>"></p>
				<p><input id="title" type="text" name="title" placeholder="문의 제목"></p>
				<textarea id="body" name="body" placeholder="문의 내용"></textarea>
				<p><input class="btn" type="submit" value="문의하기"></p>
			</form>
			</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>