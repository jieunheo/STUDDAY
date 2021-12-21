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
	{ //					              받는 메일          보내?�� 메일          ?��?��?��             비�?번호               ?���?                       ?��?��
		try
		{  
			System.out.println("send stage 01");
			
			Properties clsProp = System.getProperties();
			
			// 메일 ?���? 주소
			clsProp.put( "mail.smtp.host", "smtp.gmail.com" );
			
			// 메일 ?���? ?��?�� 번호
			clsProp.put( "mail.smtp.port", 465 );			
			
			System.out.println("send stage 02");
			
			// ?��증이 ?��?��?���? ?��?��?? 같이 ?��?��?��?��.
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.gmail.com");			
			
			System.out.println("send stage 03");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator(){
					public PasswordAuthentication getPasswordAuthentication()
					{
						// ?���? ?��?��?��/비�?번호�? ???��?��?��.
						return new PasswordAuthentication( id, pw );
					}
				} );
			
			System.out.println("send stage 04");
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// 발신?�� ?��메일 주소�? ?��?��?��?��.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			System.out.println("send stage 05");
			
			// ?��?��?�� ?��메일 주소�? ?��?��?��?��.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( to ) );
			
			System.out.println("send stage 06");
			
			// ?��목을 ???��?��?��.
			clsMessage.setSubject( title );
			
			// 메일 ?��?��?�� ???��?��?��. ?��?�� 코드�? euc-kr �? ?��?��?��?��?�� charset ?�� euckr �? ?��?��?��.
			clsMessage.setContent( body , "text/plain;charset=euckr" );
			
			System.out.println("send stage 07");
			
			// 메일 ?��?��
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
				"?���?!!","?��?��!!!");
		*/
		
		
		//MailSender ?��?��?���? ?��?��?? 같이 구조�? �?경하?�� 고쳐 ?���?!!!!!!!!!!
		/*
		MailSender send = new MailSender();
		send.setFrom("test@naver.com","비번");
		send.setTo("test@gmail.com");
		send.setTitle("?��것�? ?��목입?��?��.");
		send.setBody("<a href='autho.jsp?id=121212'>?��증하�?</a>");
		send.sendMail();	
		*/	
	}

}
