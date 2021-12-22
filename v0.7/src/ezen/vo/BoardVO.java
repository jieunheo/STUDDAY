package ezen.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardVO
{
	private String bno;         //�Խù���ȣ - �ڵ�����
	private String no;          //ȸ����ȣ
	private String nickname;    //�ۼ��� �г��� - no���� �����
	private String kinds;       //�Խù�����
	private String title;       //����
	private String post;        //����
	private String date;        //�ۼ��� - now()
	private String lang;        //���
	private String start_date;  //���۳�¥
	private String end_date;    //����¥
	
	private int    views;       //��ȸ�� - 0
	private int    reply_count; //��� ����
	private int    attach;      //÷������
	
	SimpleDateFormat sdf = null; //��¥ ���� ����
	Date today = null; //���ó�¥
	
	public BoardVO ()
	{
		lang       = ""; //���
		start_date = ""; //���۳�¥
		end_date   = ""; //����¥
		views      = 0;  //��ȸ�� - 0
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
		//���۳�¥�� ����¥�� Date�� ��ȯ
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		today = new Date();		//���ó�¥
		
		String state      = ""; //��������
		
		//yyyy-MM-dd ���� ���ڿ��� ��¥�� ��ȯ
		try
		{
			int end_time = (24*60*60*1000)-1000; //�ش� ��¥�� 23��59��59��
			Date s_date  = new Date(sdf.parse(vo.getStartDate()).getTime());
			Date e_date  = new Date(sdf.parse(vo.getEndDate()).getTime()+end_time);
			
			//���� ��¥�� ��
			if (today.getTime() < s_date.getTime())
			{
				state = "���� ���";
			} else if(today.getTime() >= s_date.getTime() && today.getTime() < e_date.getTime())
			{
				state = "���� ��";
			} else if (today.getTime() > e_date.getTime())
			{
				state = "���� �Ϸ�";
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return state;
	}
	
	public void PrintInfo()
	{
		System.out.println("�Խù���ȣ :" + bno);
		System.out.println("ȸ����ȣ :" + no);
		System.out.println("�г��� :" + nickname);
		System.out.println("�Խù����� :" + kinds);
		System.out.println("���� :" + title);
		System.out.println("���� :" + post);
		System.out.println("�ۼ��� :" + GetDate(date));
		System.out.println("��� :" + lang);
		System.out.println("���۳�¥ :" + GetDate(start_date));
		System.out.println("����¥ :" + GetDate(end_date));
		System.out.println("��ȸ�� :" + views);
		System.out.println("��� ���� :" + reply_count);
		System.out.println("÷������ :" + attach);
	}
	
}