package ezen.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import ezen.dbms.*;
import ezen.vo.*;

public class BoardDTO extends DBManager
{
	/* �Խù� ��� */
	public boolean Insert(BoardVO vo)
	{
		//dbms ����
		if(this.DBOpen() == false) return false;
		
		//insert ���� �����
		String sql  = "";
		sql += "insert into board (no,kinds,title,post,lang,start_date,end_date) ";
		sql += "values (";
		sql += "'" + vo.getNo() + "',";
		sql += "'" + vo.getKinds() + "',";
		sql += "'" + vo.getTitle().replace("'","''") + "',";
		sql += "'" + vo.getPost().replace("'","''") + "',";
		sql += "'" + vo.getLang() + "',";
		sql += "'" + vo.getStartDate() + "',";
		sql += "'" + vo.getEndDate() + "')";
		this.RunSQL(sql);	
		
		//��ϵ� �Խù��� ��ȣ�� ��´�.
		sql = "select last_insert_id() as bno ";
		this.OpenQuery(sql);
		this.GetNext();
		vo.setBno(GetLastID("bno"));
		if(GetLastID("bno") == null) return false;
		
		//dbms �ݱ�
		this.DBClose();		
		return true;
	}
	
	/* �Խù� ���� */
	public boolean Delete(String no)
	{
		//�Խù� ���� �� ������ ��� ������ �����Ѵ�.

		//dbms ����
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//��� ������ �����Ѵ�.
		sql = "delete from reply ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);		
				
		//÷�������� �����Ѵ�.
		sql = "delete from attach ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);

		//�Խù��� �����Ѵ�.
		sql  = "delete from board ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);

		//dbms �ݱ�
		this.DBClose();		
		return true;		
	}

	/* �Խù� ���� ���� */
	public boolean Update(BoardVO vo)
	{
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//�Խù��� ������Ʈ �Ѵ�.
		sql  = "update board ";
		sql += "set title = '" + vo.getTitle().replace("'","''") + "', ";
		sql += "post = '" + vo.getPost().replace("'","''") + "', ";
		sql += "lang = '" + vo.getLang() + "', ";
		sql += "start_date = '" + vo.getStartDate() + "', ";
		sql += "end_date = '" + vo.getEndDate() + " 23:59:59' ";
		sql += "where bno = " + vo.getBno();
		this.RunSQL(sql);
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;		
	}
	
	/* �Խù� ���� ��ȸ */
	public BoardVO Read(String bno,boolean isHit)
	{
		BoardVO vo = null;
		String sql = "";
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return vo;
		
		//��ȸ�� ����
		if(isHit == true)
		{
			sql  = "update board set views = views + 1 where bno = " + bno;
			this.RunSQL(sql);
		}
		
		//�Խù��� ������ ��´�.
		sql += "select bno,b.no,kinds,title,post,lang,date,views,";
		sql += "date(start_date) as start_date,date(end_date) as end_date, ";
		sql += "u.id,u.nickname,u.user_rank ";
		sql += "from board as b ";
		sql += "inner join user as u ";
		sql += "on b.no = u.no ";
		sql += "where bno = '" + bno + "' ";
		this.OpenQuery(sql);
		if(this.GetNext() == false)
		{
			this.CloseQuery();
			//�����ͺ��̽� ������ �����Ѵ�.
			this.DBClose();			
			return vo;			
		}
		//�Խù� VO�� �����Ѵ�.
		vo = new BoardVO();
		
		vo.setBno(bno);
		vo.setNo(this.GetValue("no"));
		vo.setNickname(this.GetValue("nickname"));
		vo.setKinds(this.GetValue("kinds"));
		vo.setTitle(this.GetValue("title"));
		vo.setPost(this.GetValue("post").replace("\n", "<br>"));
		vo.setLang(this.GetValue("lang"));
		vo.setDate(this.GetValue("date"));
		vo.setStartDate(this.GetValue("start_date"));
		vo.setEndDate(this.GetValue("end_date"));
		vo.setViews(this.GetInteger("views"));
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();			
		return vo;
	}
}
