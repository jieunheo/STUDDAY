package ezen.dto;

import java.util.ArrayList;

import ezen.dbms.DBManager;
import ezen.vo.*;

//�Խù� ��� �������� Ŭ����
public class ListDTO extends DBManager
{
	private SearchVO search = null;
	private String   where  = "";
	private ArrayList<BoardVO> list;
	
	//������ search�� �޾ƾ߸� ���� ����
	public ListDTO(SearchVO search)
	{
		this.search = search;

		where = "kinds ='"+ search.getKinds()+ "' "; //���а�[�⺻��-1]
		if(search.getKeyword().equals("") != true)
		{
			//�˻� Ű���尡 �ִ� ��� �߰�
			where += "and title like '%"+ search.getKeyword() + "%' ";
		}		
	}
	
	//��ü �Խù� ������ ��´�.
	public int GetTotal()
	{
		int total = 0;
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return 0;
		
		//��ü ������ ��´�.
		String sql;
		sql  = "select count(*) as count ";
		sql += "from board ";
		if(where.equals("") != true)
		{
			sql += "where " + where;
		}		
		
		this.OpenQuery(sql);
		this.GetNext();
		total = this.GetInteger("count");
		this.CloseQuery();		
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		
		return total;
	}	
	
	//�Խù� ����� �����´�.
	public boolean GetList(int curpage)
	{
		String sql = "";
		
		this.list = null;
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		//SQL��  limit ���� ��ȣ�� ����Ѵ�.
		int startno = (curpage - 1) * 10;
		
		//�Խù� ����� ��ȸ�Ѵ�.
		sql += "select bno,b.no,kinds,title,post,lang,date,views, \n";
		sql += "date(start_date) as start_date,date(end_date) as end_date, \n";
		sql += "(select count(*) from reply where bno = b.bno) as reply_count, \n";
		sql += "(select count(*) from attach where bno = b.bno) as attach, \n";
		sql += "u.id,u.nickname,u.user_rank \n";
		sql += "from board as b \n";
		sql += "inner join user as u \n";
		sql += "on b.no = u.no \n";
		if(where.equals("") != true)
		{
			sql += "where " + where + "\n";
		}
		sql += "order by " + search.getSortcol() + " " + search.getSortorder() + " \n";
		sql += "limit " + startno + "," + 10 + " \n";
		this.OpenQuery(sql);
		while(this.GetNext() == true)
		{
			String bno         = this.GetValue("bno");           //�Խñ۹�ȣ
			String no          = this.GetValue("no");            //ȸ����ȣ
			String nickname    = this.GetValue("nickname");      //�г���
			String kinds       = this.GetValue("kinds");         //�о�
			String title       = this.GetValue("title");         //����
			String post        = this.GetValue("post");          //����
			String lang        = this.GetValue("lang");          //���
			String date        = this.GetValue("date");          //�ۼ���
			String start_date  = this.GetValue("start_date");    //���� ��¥
			String end_date    = this.GetValue("end_date");      //�� ��¥
			int    views       = this.GetInteger("views");       //��ȸ��
			int    reply_count = this.GetInteger("reply_count"); //��� ����
			int    attach      = this.GetInteger("attach");      //÷������
			
			if( this.list == null )
			{
				this.list = new ArrayList<BoardVO>();  
			}
			BoardVO vo = new BoardVO();
			vo.setBno(bno);
			vo.setNo(no);
			vo.setNickname(nickname);
			vo.setKinds(kinds);
			vo.setTitle(title);
			vo.setPost(post);
			vo.setLang(lang);
			vo.setDate(date);
			vo.setViews(views);
			vo.setStartDate(start_date);
			vo.setEndDate(end_date);
			vo.setReplyCount(reply_count);
			vo.setAttach(attach);
			list.add(vo);
		}
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;
	}
	
	public boolean GetMainList()
	{
		String sql = "";
		
		this.list = null;
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		//�Խù� ����� ��ȸ�Ѵ�.
		sql += "select bno,no,kinds,title,lang,date,views, \n";
		sql += "start_date,end_date \n";
		sql += "from board \n";
		sql += "where kinds = '1' \n";
		sql += "and end_date > now() \n";
		sql += "order by bno desc \n";
		sql += "limit 8;";
		this.OpenQuery(sql);
		while(this.GetNext() == true)
		{
			String bno         = this.GetValue("bno");        //�Խñ۹�ȣ
			String no          = this.GetValue("no");         //ȸ����ȣ
			String kinds       = this.GetValue("kinds");      //�о�
			String title       = this.GetValue("title");      //����
			String lang        = this.GetValue("lang");       //���
			String date        = this.GetValue("date");       //�ۼ���
			String start_date  = this.GetValue("start_date"); //���� ��¥
			String end_date    = this.GetValue("end_date");   //�� ��¥
			int    views       = this.GetInteger("views");    //��ȸ��
			
			if( this.list == null )
			{
				this.list = new ArrayList<BoardVO>();  
			}
			BoardVO vo = new BoardVO();
			vo.setBno(bno);
			vo.setNo(no);
			vo.setKinds(kinds);
			vo.setTitle(title);
			vo.setLang(lang);
			vo.setDate(date);
			vo.setViews(views);
			vo.setStartDate(start_date);
			vo.setEndDate(end_date);
			list.add(vo);
		}
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;
	}
	
	//��ȸ�� ����� ������ ��´�.
	public int GetListTotal()
	{
		if(this.list == null) return 0;
		else return list.size();
	}
	
	//��Ͽ��� �Խù� ������ ��´�.
	public BoardVO GetItem(int index)
	{
		if(this.list == null) return null;
		else return list.get(index);		
	}
	
	//����� ArrayList�� ���� ��´�.
	public ArrayList<BoardVO> GetListArray()
	{
		return this.list;
	}	
}


