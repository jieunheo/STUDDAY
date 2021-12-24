package ezen.vo;

public class ReplyVO
{
	private String rno;      //댓글번호
	private String bno;      //게시물번호
	private String no;       //작성자번호
	private String nickname; //닉네임
	private String rpost;    //댓글내용
	private String rdate;    //작성일

	/* setter */
	public void setRno(String rno)           { this.rno = rno;           }
	public void setBno(String bno)           { this.bno = bno;           }
	public void setNo(String no)             { this.no = no;             }
	public void setNickname(String nickname) { this.nickname = nickname; }
	public void setRpost(String rpost)       { this.rpost = rpost;       }
	public void setRdate(String rdate)       { this.rdate = rdate;       }
	
	/* getter */
	public String getRno()      { return rno;      }
	public String getBno()      { return bno;      }
	public String getNo()       { return no;       }
	public String getNickname() { return nickname; }
	public String getRpost()    { return rpost;    }
	public String getRdate()    { return rdate;    }
	
	/* PrintInfo */
	public void PrintInfo()
	{
		System.out.println("댓글번호 :" + rno);
		System.out.println("게시물번호 :" + bno);
		System.out.println("회원번호 :" + no);
		System.out.println("닉네임 :" + nickname);
		System.out.println("댓글내용 :" + rpost);
		System.out.println("작성일 :" + rdate);
	}
}
