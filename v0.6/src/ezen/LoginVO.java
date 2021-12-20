package ezen;

public class LoginVO
{
	private String no;    //?��?��번호
	private String id;    //?��?��?��
	private String nick;  //?��?��?��
	private String rank;  //권한
	private String email; //?��메일
	
	/* ������ */
	public LoginVO(String no, String id, String nick, String rank, String email)
	{
		setNo(no);
		setId(id);
		setNick(nick);
		setRank(rank);
		setEmail(email);
	}
	
	/* getter */
	public String getNo()    { return no;	 }
	public String getId()    { return id;	 }
	public String getNick()  { return nick;	 }
	public String getRank()  { return rank;	 }
	public String getEmail() { return email; }
	
	/* setter */
	public void setNo(String no)       { this.no = no;	     }
	public void setId(String id)       { this.id = id;	     }
	public void setNick(String nick)   { this.nick = nick;   }
	public void setRank(String rank)   { this.rank = rank;   }
	public void setEmail(String email) { this.email = email; }
	
	public void printInfo ()
	{
		System.out.println(no);
		System.out.println(id);
		System.out.println(nick);
		System.out.println(rank);
		System.out.println(email);
	}
	
	public static void main(String[] args)
	{
		
	}
}