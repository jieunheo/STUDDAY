package ezen.vo;

public class UserVO
{
	private String no;        //회원번호
	private String id;        //아이디
	private String pw;        //비밀번호
	private String nickname;  //닉네임
	private String email;     //이메일
	private String join_date; //가입일시 - now()
	private String retire;    //탈퇴여부 - N/Y
	private String jop;       //직업
	private String interest;  //관심사
	private String intro;     //자기소개
	private String homepage;  //홈페이지
	private String user_rank; //회원등급 - U/A
	
	public UserVO()
	{
		//회원가입 시 입력하지 않는 값들 초기화
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
		System.out.println("회원번호 :" + no);
		System.out.println("아이디 :" + id);
		System.out.println("닉네임 :" + nickname);
		System.out.println("이메일 :" + email);
		System.out.println("가입일시 :" + GetDate(join_date));
		System.out.println("탈퇴여부 :" + retire);
		System.out.println("직업 :" + jop);
		System.out.println("관심사 :" + interest);
		System.out.println("자기소개 :" + intro);
		System.out.println("홈페이지 :" + homepage);
		System.out.println("회원등급 :" + user_rank);
	}
}
