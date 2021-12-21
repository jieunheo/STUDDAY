package ezen.mail;

public class MailVO {
	MailSender send = null;
	
	private String from_mail;  //ë³´ë‚´?Š” ì£¼ì†Œ
	private String to_mail;    //ë°›ëŠ” ì£¼ì†Œ
	private String id;         //ë³´ë‚´?Š” ?•„?´?””
	private String pw;         //ë³´ë‚´?Š” ë¹„ë?ë²ˆí˜¸
	private String mail_title; //ë©”ì¼ ? œëª?
	private String mail_body;  //ë©”ì¼ ?‚´?š©
	
	public MailVO(){
		setFrom_mail("gjekdmlwl@gamil.com");
		setTo_mail("gjekdmlwl@naver.com");
		setId("gjekdmlwl@gmail.com");
		setPw("hajin1121!");
	}
	
	public MailVO(String title,String body){
		this();
		setMail_title(title);
		setMail_body(body);
	}
	
	public void SendMail()
	{
		send = new MailSender();
		send.MailSend(from_mail,to_mail,id,pw,mail_title,mail_body);
	}
	
	/* getter */
	public String getFrom_mail()  { return from_mail;  }
	public String getTo_mail()    { return to_mail;    }
	public String getId()         { return id;         }
	public String getPw()         { return pw;         }
	public String getMail_title() { return mail_title; }
	public String getMail_body()  { return mail_body;  }
	
	/* setter */
	public void setFrom_mail(String from_mail)   { this.from_mail = from_mail;   }
	public void setTo_mail(String to_mail)       { this.to_mail = to_mail;       }
	public void setId(String id)                 { this.id = id;                 }
	public void setPw(String pw)                 { this.pw = pw;                 }
	public void setMail_title(String mail_title) { this.mail_title = mail_title; }
	public void setMail_body(String mail_body)   { this.mail_body = mail_body;   }
	
	
}
