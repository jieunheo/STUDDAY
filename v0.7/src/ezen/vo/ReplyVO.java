package ezen.vo;

public class ReplyVO
{
	private String rno;      //��۹�ȣ
	private String bno;      //�Խù���ȣ
	private String no;       //�ۼ��ڹ�ȣ
	private String nickname; //�г���
	private String rpost;    //��۳���
	private String rdate;    //�ۼ���

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
		System.out.println("��۹�ȣ :" + rno);
		System.out.println("�Խù���ȣ :" + bno);
		System.out.println("ȸ����ȣ :" + no);
		System.out.println("�г��� :" + nickname);
		System.out.println("��۳��� :" + rpost);
		System.out.println("�ۼ��� :" + rdate);
	}
}
