/* 로드시 */
window.onload = function()
{
	
}

function ready()
{
	alert('준비중입니다! 조금만 기다려주세요 :)');
}


/* 아이디/닉네임/이메일 중복 확인 */
function ValueCheck(myid){
	/* 키보드 눌렀다 떼는 순간 */
	$(myid).keyup(function() {
		/* 입력된 값 */
		var value = $(this).val();
		var kind = "";
		
		if (value == "")
		{
			return;
		}
		
		if (myid == document.join.id)
		{
			kind = "id";
		} else if (myid == document.join.nickname)
		{
			kind = "nickname";
		} else
		{
			kind = "email";
		}
		
		$.ajax({
			type: "get",
			url: "usercheck.jsp?kind=" + kind + "&value=" + value,
			dataType: "html",
			success: function(data) {
				data = data.trim();
				
				if (data == "00")
				{
					/* 아무것도 입력하지 않거나 4글자 미만인 경우 */
					SetBackColor(myid,'');
					OutFocus(myid,'rgba(255,0,0,0.2)');
				} else if (data == "01")
				{
					/* 이미 사용중인 아이디인 경우 */
					SetBackColor(myid,'rgba(255,0,0,0.2)');
					OutFocus(myid,'rgba(255,0,0,0.2)');
				} else if (data == "02")
				{
					/* 사용 가능한 아이디인 경우 */
					SetBackColor(myid,'rgba(0,0,255,0.2)');
					OutFocus(myid,'');
				}
			}
		});
	});
}

/* 포커스가 사라질 때 */
function OutFocus(myid, color)
{
	$(myid).focusout(function() {
		SetBackColor(myid,color);
	});
	
	if(color == '')
	{
		if(myid == document.join.id) idok = 1;
		else if(myid == document.join.nickname) nickok = 1;
		else emailok = 1;
	} else
	{
		if(myid == "id") idok = 0;
		else if(myid == "nickname") nickok = 0;
		else emailok = 0;
	}
}

/* 배경색 바꾸기 */
function SetBackColor(myid,color)
{
	$(myid).css('background-color',color);
	return;
}

/* 회원 탈퇴 */
function Secession()
{
	if(!confirm('정말 탈퇴하시겠습니까?')) return false;
	
	$.ajax({
		type: "get",
		url: "secession.jsp?no=<%= no %>",
		dataType: "html",
		success: function(data) {
			alert('탈퇴되었습니다.');
			window.location = "index.jsp";
		}
	});
}