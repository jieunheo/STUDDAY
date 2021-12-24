package ezen.dto;

import java.util.ArrayList;

import ezen.dbms.DBManager;
import ezen.vo.BoardVO;
import ezen.vo.ReplyVO;

public class ReplyDTO extends DBManager
{
	private ArrayList<ReplyVO> list;
	
	/* ��� ��� */
	public boolean Insert(ReplyVO vo)
	{
		//dbms ����
		if(this.DBOpen() == false) return false;
		
		//insert ���� �����
		String sql  = "";
		sql += "insert into reply (bno,no,rpost) ";
		sql += "values (";
		sql += "'" + vo.getBno() + "',";
		sql += "'" + vo.getNo() + "',";
		sql += "'" + vo.getRpost().replace("'","''") + "') ";
		this.RunSQL(sql);	
		
		//��ϵ� ��� ��ȣ�� ��´�.
		sql = "select last_insert_id() as rno ";
		this.OpenQuery(sql);
		this.GetNext();
		vo.setBno(GetLastID("rno"));
		if(GetLastID("rno") == null) return false;
		
		//dbms �ݱ�
		this.DBClose();		
		return true;
	}
	

	/* ��� ���� */
	public boolean Delete(String rno)
	{
		//dbms ����
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//��� ������ �����Ѵ�.
		sql = "delete from reply ";
		sql += "where rno = " + rno + " ";
		this.RunSQL(sql);

		//dbms �ݱ�
		this.DBClose();		
		return true;		
	}
	

	/* ��� ���� ���� */
	public boolean Update(ReplyVO vo)
	{
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//��� ������Ʈ
		sql  = "update reply ";
		sql += "set rpost = '" + vo.getRpost().replace("'","''") + "' ";
		sql += "where rno = " + vo.getRno();
		this.RunSQL(sql);
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;		
	}

	/* ��� ���� ��ȸ */
	public boolean GetReply(String bno)
	{
		this.list = null;
		String sql = "";
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		//�Խù��� ������ ��´�.
		sql = "";
		sql += "select rno,bno,r.no,rpost,rdate,u.nickname ";
		sql += "from reply as r ";
		sql += "inner join user as u ";
		sql += "on r.no = u.no ";
		sql += "where bno = '" + bno + "' ";
		this.OpenQuery(sql);
		while(this.GetNext() == true)
		{
			String rno = this.GetValue("rno");
			String no = this.GetValue("no");
			String nickname = this.GetValue("nickname");
			String rpost = this.GetValue("rpost").replace("\n", "<br>");
			String rdate = this.GetValue("rdate");

			//�Խù� VO�� �����Ѵ�.
			if( this.list == null )
			{
				this.list = new ArrayList<ReplyVO>();  
			}
			ReplyVO vo = new ReplyVO();
			vo.setRno(rno);
			vo.setBno(bno);
			vo.setNo(no);
			vo.setNickname(nickname);
			vo.setRpost(rpost);
			vo.setRdate(rdate);
			list.add(vo);
		}
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;
	}
	
	//��Ͽ��� �Խù� ������ ��´�.
	public ReplyVO GetItem(int index)
	{
		if(this.list == null) return null;
		else return list.get(index);		
	}
	
	//����� ArrayList�� ���� ��´�.
	public ArrayList<ReplyVO> GetListArray()
	{
		return this.list;
	}
	
	/* ������ �ۼ��� ������� Ȯ�� */
	public boolean isMyReply(String rno, String no)
	{
		String sql = "";
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		//�Խù��� ������ ��´�.
		sql = "";
		sql += "select no ";
		sql += "from reply ";
		sql += "where rno = '" + rno + "' ";
		sql += "and no = '" + no + "' ";
		this.OpenQuery(sql);
		if(this.GetNext() == false)
		{
			this.CloseQuery();
			//�����ͺ��̽� ������ �����Ѵ�.
			this.DBClose();
			return false;
		}
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;
	}
}
