package ezen.mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender 
{
	public boolean MailSend(String from,String to,String id,String pw,String title,String body)
	{ //					              ë°›ëŠ” ë©”ì¼          ë³´ë‚´?Š” ë©”ì¼          ?•„?´?””             ë¹„ë?ë²ˆí˜¸               ? œëª?                       ?‚´?š©
		try
		{  
			System.out.println("send stage 01");
			
			Properties clsProp = System.getProperties();
			
			// ë©”ì¼ ?„œë²? ì£¼ì†Œ
			clsProp.put( "mail.smtp.host", "smtp.gmail.com" );
			
			// ë©”ì¼ ?„œë²? ?¬?Š¸ ë²ˆí˜¸
			clsProp.put( "mail.smtp.port", 465 );			
			
			System.out.println("send stage 02");
			
			// ?¸ì¦ì´ ?•„?š”?•˜ë©? ?•„?˜?? ê°™ì´ ?„¤? •?•œ?‹¤.
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.gmail.com");			
			
			System.out.println("send stage 03");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator(){
					public PasswordAuthentication getPasswordAuthentication()
					{
						// ?¸ì¦? ?•„?´?””/ë¹„ë?ë²ˆí˜¸ë¥? ???¥?•œ?‹¤.
						return new PasswordAuthentication( id, pw );
					}
				} );
			
			System.out.println("send stage 04");
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// ë°œì‹ ? ?´ë©”ì¼ ì£¼ì†Œë¥? ?„¤? •?•œ?‹¤.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			System.out.println("send stage 05");
			
			// ?ˆ˜?‹ ? ?´ë©”ì¼ ì£¼ì†Œë¥? ?„¤? •?•œ?‹¤.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( to ) );
			
			System.out.println("send stage 06");
			
			// ? œëª©ì„ ???¥?•œ?‹¤.
			clsMessage.setSubject( title );
			
			// ë©”ì¼ ?‚´?š©?„ ???¥?•œ?‹¤. ?†Œ?Š¤ ì½”ë“œë¥? euc-kr ë¡? ?‘?„±?•˜?—¬?„œ charset ?„ euckr ë¡? ?„¤? •?•¨.
			clsMessage.setContent( body , "text/plain;charset=euckr" );
			
			System.out.println("send stage 07");
			
			// ë©”ì¼ ? „?†¡
			Transport.send( clsMessage );
			
			System.out.println("send stage 08");
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return false;
		}		
		return true;
	}
	
	public static void main(String[] args) 
	{
		/*
		MailSender m = new MailSender();
		m.MailSend("gjekdmlwl@gmail.com", 
				"gjekdmlwl@gmail.com",
				"gjekdmlwl@gmail.com","hajin1121!",
				"? œëª?!!","?‚´?š©!!!");
		*/
		
		
		//MailSender ?´?˜?Š¤ë¥? ?•„?˜?? ê°™ì´ êµ¬ì¡°ë¥? ë³?ê²½í•˜?—¬ ê³ ì³ ?“¸ê²?!!!!!!!!!!
		/*
		MailSender send = new MailSender();
		send.setFrom("test@naver.com","ë¹„ë²ˆ");
		send.setTo("test@gmail.com");
		send.setTitle("?´ê²ƒì? ? œëª©ì…?‹ˆ?‹¤.");
		send.setBody("<a href='autho.jsp?id=121212'>?¸ì¦í•˜ê¸?</a>");
		send.sendMail();	
		*/	
	}

}
