package ezen;

public class LoginVo
{
	private String no;   //회원번호
	private String id;   //아이디
	private String nick; //닉네임
	private String rank; //권한
	
	/* ������ */
	public LoginVo(String no, String id, String nick, String rank)
	{
		setNo(no);
		setId(id);
		setNick(nick);
		setRank(rank);
	}
	
	/* getter */
	public String getNo()   { return no;	}
	public String getId()   { return id;	}
	public String getNick() { return nick;	}
	public String getRank() { return rank;	}
	
	/* setter */
	public void setNo(String no)     { this.no = no;	 }
	public void setId(String id)     { this.id = id;	 }
	public void setNick(String nick) { this.nick = nick; }
	public void setRank(String rank) { this.rank = rank; }
	
	
	public static void main(String[] args)
	{
		
	}
}