function ready()
{
	alert('준비중입니다! 조금만 기다려주세요 :)');
}

/************************************회원가입**********************************************/
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
var idok    = 0;
var nickok  = 0;
var emailok = 0;
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

/************************************회원탈퇴**********************************************/
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

/************************************슬라이드**********************************************/
function PrevItem()
{
	var left = imgs.css("left").replace("px","");
if(1<=img_position && img_position<img_count){
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

/************************************메일보내기**********************************************/
function MailCheck() {
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

/************************************댓글**********************************************/
function ReadReply(bno)
{
	$.ajax({
		type: "get",
		url: "reply.jsp?bno=" + bno,
		dataType: "html",
		success: function(data) {
			data = data.trim();
			$('#reply_wrap').html(data);
		}
	});
}

function ReplyUpload()
{
	var no  = $('#no').val();
	var bno = $('#bno').val();
	
	if(document.reply.rpost.value == "")
	{
		alert('댓글을 입력해주세요.');
		document.reply.rpost.focus();
		return false;
	}

	if(!confirm('댓글을 작성하시겠습니까?')) return false;
	var param = "";
	var value = $('#rpost').val();
	
	param += "bno=" + bno + "&no=" + no + "&rpost=" + value;
	if (bno == "" || value == "")
	{
		return;
	}
	
	$.ajax({
		type: "get",
		url: "replyupload.jsp",
		data: param,
		dataType: "html",
		success: function(data) {
			//alert("댓글이 등록되었습니다.");
			ReadReply(data);
		}
	});
	return false;
}

function ReplyDelete(myurl)
{
	if(!confirm('댓글을 삭제하시겠습니까?')) return false;
	
	$.ajax({
		type: "get",
		url: myurl,
		dataType: "html",
		success: function(data) {
			data = data.trim();
			ReadReply(data);
		}
	});
}

/************************************글쓰기 달력**********************************************/
function StartDate()
{
	$.datepicker.setDefaults($.datepicker.regional['ko']); 
	$("#start_date").datepicker({
		changeMonth: true, 
		changeYear: true,
		nextText: '다음 달',
		prevText: '이전 달', 
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: "yy-mm-dd",
		minDate: 0,
		maxDate: 30, // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
		onClose: function( selectedDate ) {    
		     //시작일(startDate) datepicker가 닫힐때
		     //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
		    $("#end_date").datepicker( "option", "minDate", selectedDate );
		}
	});
}

function EndDate()
{
	$("#end_date").datepicker({
		changeMonth: true, 
		changeYear: true,
		nextText: '다음 달',
		prevText: '이전 달', 
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dateFormat: "yy-mm-dd",
		maxDate: 30, // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
		onClose: function( selectedDate ) {    
		    // 종료일(endDate) datepicker가 닫힐때
		    // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
		    $("#start_date").datepicker( "option", "maxDate", selectedDate );
		}
	});
}