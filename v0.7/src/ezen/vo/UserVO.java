package ezen.vo;

public class UserVO
{
	private String no;        //ȸ����ȣ
	private String id;        //���̵�
	private String pw;        //��й�ȣ
	private String nickname;  //�г���
	private String email;     //�̸���
	private String join_date; //�����Ͻ� - now()
	private String retire;    //Ż�𿩺� - N/Y
	private String jop;       //����
	private String interest;  //���ɻ�
	private String intro;     //�ڱ�Ұ�
	private String homepage;  //Ȩ������
	private String user_rank; //ȸ����� - U/A
	
	public UserVO()
	{
		//ȸ������ �� �Է����� �ʴ� ���� �ʱ�ȭ
		jop      = "";
		interest = "";
		intro    = "";
		homepage = "";
	}
	
	public UserVO(String id, String pw, String nickname, String email)
	{
		this();
		setId(id);
		setPw(pw);
		setNickname(nickname);
		setEmail(email);
	}
	
	public UserVO(String id, String pw, String nickname, String email,String jop, String interest, String intro, String homepage)
	{
		setId(id);
		setPw(pw);
		setNickname(nickname);
		setEmail(email);
		setJop(jop);
		setInterest(interest);
		setIntro(intro);
		setHomepage(homepage);
	}
	
	/* getter */
	public String getNo()        { return no;        }
	public String getId()        { return id;        }
	public String getPw()        { return pw;        }
	public String getNickname()  { return nickname;  }
	public String getEmail()     { return email;     }
	public String getJoin_date() { return join_date; }
	public String getRetire()    { return retire;    }
	public String getJop()       { return jop;       }
	public String getInterest()  { return interest;  }
	public String getIntro()     { return intro;     }
	public String getHomepage()  { return homepage;  }
	public String getUser_rank() { return user_rank; }

	/* setter */
	public void setNo(String no)               { this.no = no;               }
	public void setId(String id)               { this.id = id;               }
	public void setPw(String pw)               { this.pw = pw;               }
	public void setNickname(String nickname)   { this.nickname = nickname;   }
	public void setEmail(String email)         { this.email = email;         }
	public void setJoin_date(String join_date) { this.join_date = join_date; }
	public void setRetire(String retire)       { this.retire = retire;       }
	public void setJop(String jop)             { this.jop = jop;             }
	public void setInterest(String interest)   { this.interest = interest;   }
	public void setIntro(String intro)         { this.intro = intro;         }
	public void setHomepage(String homepage)   { this.homepage = homepage;   }
	public void setUser_rank(String user_rank) { this.user_rank = user_rank; }
	
	/* date format */
	public String GetDate(String date) {
		return date.split(" ")[0];
	}
	
	public void PrintInfo()
	{
		System.out.println("ȸ����ȣ :" + no);
		System.out.println("���̵� :" + id);
		System.out.println("�г��� :" + nickname);
		System.out.println("�̸��� :" + email);
		System.out.println("�����Ͻ� :" + GetDate(join_date));
		System.out.println("Ż�𿩺� :" + retire);
		System.out.println("���� :" + jop);
		System.out.println("���ɻ� :" + interest);
		System.out.println("�ڱ�Ұ� :" + intro);
		System.out.println("Ȩ������ :" + homepage);
		System.out.println("ȸ����� :" + user_rank);
	}
}
