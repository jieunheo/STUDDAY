<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
window.onload = function()
{
	document.join.id.focus();
	
	//아이디값 확인
	ValueCheck(id);
	//닉네임값 확인
	ValueCheck(nickname);
}

function ValueCheck(myid)
{
	$(myid).keyup(function() {
		var value = $(this).val();
		var url = "";
		
		if (value == "")
		{
			return;
		}
		
		if (myid == document.join.id)
		{
			url = "idcheck.jsp?id=";
		} else
		{
			url = "nickcheck.jsp?nick=";
		}
		
		$.ajax({
			type: "get",
			url: url + value,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				if (data == "00")
				{
					SetBackColor(myid,'');
					OutFocus(myid,'');
				} else if (data == "01")
				{
					SetBackColor(myid,'rgba(255,0,0,0.2)');
					OutFocus(myid,'rgba(255,0,0,0.2)');
				} else if (data == "02")
				{
					SetBackColor(myid,'rgba(0,0,255,0.2)');
					OutFocus(myid,'');
				}
				
				if (data == "01")
				{
					SetBackColor(myid,'rgba(255,0,0,0.2)');
				}
			},
			complete: function(data) {
				//alert('complete');
			},
			error: function(xhr, status, error) {
				//alert('error');
			}
		});
	});
}

/*
function NickCheck(myid)
{
	$(myid).keyup(function() {
		var value = $(this).val();
		
		if (value == "")
		{
			return;
		}
		
		$.ajax({
			type: "get",
			url: "nickcheck.jsp?nickname=" + value,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				if (data == "none")
				{
					SetBackColor(myid,'');
				} else if (data == "idNick")
				{
					SetBackColor(myid,'rgba(255,0,0,0.2)');
				} else if (data == "doNick")
				{
					SetBackColor(myid,'rgba(0,0,255,0.2)');
				}
			},
			complete: function(data) {
				//alert('complete');
			},
			error: function(xhr, status, error) {
				//alert('error');
			}
		});
	});
}
*/

function OutFocus(myid, color)
{
	$(myid).focusout(function() {
		SetBackColor(myid,color);
	});
}

function SetBackColor(myid,color)
{
	$(myid).css('background-color',color);
	return;
}

function FormCheck()
{
	if(document.join.id.value == "")
	{
		alert('아이디를 입력해주세요.');
		document.join.id.focus();
		return false;
	}
	
	if(document.join.pw.value == "")
	{
		alert('비밀번호를 입력해주세요.');
		document.join.pw.focus();
		return false;
	}
	
	if(document.join.pw.value != document.join.pwok.value)
	{
		alert('비밀번호가 일치하지 않습니다.');
		document.join.pw.focus();
		return false;
	}
	
	if(document.join.nickname.value == "")
	{
		alert('닉네임을 입력해주세요.');
		document.join.pw.focus();
		return false;
	}
	
	if(document.join.email.value == "")
	{
		alert('이메일을 입력해주세요.');
		document.join.email.focus();
		return false;
	}
}
</script>
<div class="main">
	<div class="wrap">
		<div class="sub_page">
			<div>
				<div class="category join">
					<p>Join</p>
				</div>
				<div>
					<form class="join" name="join" method="post" action="joinok.jap" onsubmit="return FormCheck();">
						<p><input id="id" type="text" name="id" placeholder="아이디"></p>
						<p><input id="pw" type="password" name="pw" placeholder="비밀번호"></p>
						<p><input id="pwok" type="password" name="pwok" placeholder="비밀번호확인"></p>
						<p><input id="nickname" type="text" name="nickname" placeholder="닉네임"></p>
						<p><input id="email" type="email" name="email" placeholder="hong@naver.com"></p>
						<p><input class="btn" type="submit" value="회원가입"></p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="./include/footer.jsp" %>