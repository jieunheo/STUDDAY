package ezen.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardVO
{
	private String bno;         //게시물번호 - 자동증가
	private String no;          //회원번호
	private String nickname;    //작성자 닉네임 - no에서 끌어옴
	private String kinds;       //게시물종류
	private String title;       //제목
	private String post;        //내용
	private String date;        //작성일 - now()
	private String lang;        //언어
	private String start_date;  //시작날짜
	private String end_date;    //끝날짜
	
	private int    views;       //조회수 - 0
	private int    reply_count; //댓글 갯수
	private int    attach;      //첨부파일
	
	SimpleDateFormat sdf = null; //날짜 형식 포멧
	Date today = null; //오늘날짜
	
	public BoardVO ()
	{
		lang       = ""; //언어
		start_date = ""; //시작날짜
		end_date   = ""; //끝날짜
		views      = 0;  //조회수 - 0
	}
	
	public BoardVO (String no, String kinds, String title, String post)
	{
		this();
		setNo(no);
		setKinds(kinds);
		setTitle(title);
		setPost(post);
	}

	/* setter */
	public void setBno(String bno)                { this.bno = bno;                 }
	public void setNo(String no)                  { this.no = no;                   }
	public void setNickname(String nickname)      { this.nickname = nickname;       }
	public void setKinds(String kinds)            { this.kinds = kinds;             }
	public void setTitle(String title)            { this.title = title;             }
	public void setPost(String post)              { this.post = post;               }
	public void setDate(String date)              { this.date = date;               }
	public void setViews(int views)               { this.views = views;             }
	public void setLang(String lang)              { this.lang = lang;               }
	public void setStartDate(String start_date)   { this.start_date = start_date;   }
	public void setEndDate(String end_date)       { this.end_date = end_date;       }
	public void setReplyCount(int reply_count)    { this.reply_count = reply_count; }
	public void setAttach(int attach)             { this.attach = attach;           }
	
	/* getter */
	public String getBno()        { return bno;         }
	public String getNo()         { return no;          }
	public String getNickname()   { return nickname;    }
	public String getKinds()      { return kinds;       }
	public String getTitle()      { return title;       }
	public String getPost()       { return post;        }
	public String getDate()       { return date;        }
	public String getLang()       { return lang;        }
	public String getStartDate()  { return start_date;  }
	public String getEndDate()    { return end_date;    }
	public int    getViews()      { return views;       }
	public int    getReplyCount() { return reply_count; }
	public int    getAttach()     { return attach;      }
	
	public String getLangName() {
		if(lang.equals("java")) return "JAVA";
		else if(lang.equals("sql")) return "SQL";
		else if(lang.equals("js")) return "Javascript";
		return lang;
	}
	
	/* date format */
	public String GetDate(String date) {
		if(date != null) return date.split(" ")[0];
		else             return "";
	}
	
	public String GetStudyState(BoardVO vo)
	{
		//시작날짜와 끝날짜를 Date로 변환
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		today = new Date();		//오늘날짜
		
		String state      = ""; //모집상태
		
		//yyyy-MM-dd 형태 문자열을 날짜로 변환
		try
		{
			int end_time = (24*60*60*1000)-1000; //해당 날짜의 23시59분59초
			Date s_date  = new Date(sdf.parse(vo.getStartDate()).getTime());
			Date e_date  = new Date(sdf.parse(vo.getEndDate()).getTime()+end_time);
			
			//오늘 날짜와 비교
			if (today.getTime() < s_date.getTime())
			{
				state = "모집 대기";
			} else if(today.getTime() >= s_date.getTime() && today.getTime() < e_date.getTime())
			{
				state = "모집 중";
			} else if (today.getTime() > e_date.getTime())
			{
				state = "모집 완료";
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return state;
	}
	
	public void PrintInfo()
	{
		System.out.println("게시물번호 :" + bno);
		System.out.println("회원번호 :" + no);
		System.out.println("닉네임 :" + nickname);
		System.out.println("게시물종류 :" + kinds);
		System.out.println("제목 :" + title);
		System.out.println("내용 :" + post);
		System.out.println("작성일 :" + GetDate(date));
		System.out.println("언어 :" + lang);
		System.out.println("시작날짜 :" + GetDate(start_date));
		System.out.println("끝날짜 :" + GetDate(end_date));
		System.out.println("조회수 :" + views);
		System.out.println("댓글 갯수 :" + reply_count);
		System.out.println("첨부파일 :" + attach);
	}
	
}