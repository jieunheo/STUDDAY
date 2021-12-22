package ezen.dto;

import ezen.dbms.*;
import ezen.vo.*;

public class UserDTO extends DBManager
{
	public final static int ERROR         = 0;
	public final static int DUPLICATE     = 1;
	public final static int NOT_DUPLICATE = 2;
	public final static int PW_OK         = 3;
		
	//ȸ�� ���̵� �ߺ� �˻�
	//���ϰ� : ERROR - ����, DUPLICATE - �ߺ�, NOT_DUPLICATE - �ߺ��ƴ� 
	public int IsDuplicate(String kind, String value)
	{
		//�����ͺ��̽��� ����
		if(this.DBOpen() == false) 
		{
			return ERROR;
		}
		
		//id �ߺ��˻�
		String sql = "";
		sql += "select " + kind + " ";
		sql += "from user ";
		sql += "where " + kind + " = '" + value + "'";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			//ID�� �ߺ���
			this.CloseQuery();
			this.DBClose();
			return DUPLICATE;
		} else
		{
			if( (!kind.equals("nickname") && value.length() < 4) || (kind.equals("nickname") && value.length() < 2) )
			{ //���̵�� �̸����� 4���� ������ ���															�г����� 2���� ������ ���
				return ERROR;
			}
		}
		this.CloseQuery();
		
		//�����ͺ��̽� ���� ����
		this.DBClose();
		return NOT_DUPLICATE;
	}
	
	public int IsPwCheck(String id, String pw)
	{
		//�����ͺ��̽��� ����
		if(this.DBOpen() == false) 
		{
			return ERROR;
		}
		
		String sql = "";
		sql += "select id,pw from user ";
		sql += "where id='" + id + "' ";
		sql += "and pw= md5('" + pw + "') ";
		this.OpenQuery(sql);
		if(this.GetNext() == false)
		{
			//pw�� ��ġ���� ������
			this.CloseQuery();
			this.DBClose();
			return ERROR;
		}
		
		this.CloseQuery();
		this.DBClose();
		return PW_OK;
	}
	
	//ȸ�� ���� ó��
	//���ϰ� : true-��ϿϷ�, false-����
	public boolean Insert(UserVO vo)
	{
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return false;
		
		//user ���̺� Insert�ϴ� ������ �����.
		String sql = "";
		sql  = "";
		sql += "insert into user (id, pw, nickname, email, jop, interest, intro, page) ";
		sql += "values (";
		sql += "'" + vo.getId() + "',";
		sql += "md5('" + vo.getPw() + "'),";
		sql += "'" + vo.getNickname() + "',";
		sql += "'" + vo.getEmail() + "',";
		sql += "'" + vo.getJop() + "',";
		sql += "'" + vo.getInterest() + "',";
		sql += "'" + vo.getIntro() + "',";
		sql += "'" + vo.getHomepage() + "')";
		this.RunSQL(sql);
		
		//��ϵ� ���̵��� ��ȣ�� ��´�.
		sql = "select last_insert_id() as no ";
		this.OpenQuery(sql);
		this.GetNext();
		String no = this.GetValue("no");
		vo.setNo(no);
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return true;
	}
	
	
	public UserVO Update(UserVO vo)
	{
		UserVO login = null;
		
		//�����ͺ��̽��� �����Ѵ�.
		System.out.println("���� �غ�");
		if(this.DBOpen() == false) return null;
		System.out.println("���� �Ϸ�");
		
		//no���� �̿��Ͽ� ���� Ȯ���Ѵ�.
		String sql = "";
		sql  = "select id,pw ";
		sql += "from user ";
		sql += "where no = '" + vo.getNo() + "' ";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			this.CloseQuery();
			//���� ������ ����
			sql  = "";
			sql += "update user set ";
			if(!(vo.getPw() == null || vo.getPw().equals("")))
			{
				sql += "pw=md5('" + vo.getPw() + "'), ";
			}
			sql += "nickname='" + vo.getNickname() + "', ";
			sql += "email='" + vo.getEmail() + "', ";
			sql += "jop='" + vo.getJop() + "', ";
			sql += "interest='" + vo.getInterest() + "', ";
			sql += "intro='" + vo.getIntro() + "', ";
			sql += "page='" + vo.getHomepage() + "' ";
			sql += "where no = '" + vo.getNo() + "' ";
			sql += "and retire = 'N' ";
			this.RunSQL(sql);
			
			login = vo;
			
			this.DBClose();
			return login;
		}
		//�����ͺ��̽� ������ �����Ѵ�.
		this.CloseQuery();
		this.DBClose();
		return login;
	}
	
	public boolean Delete(UserVO vo)
	{
		//�����ͺ��̽��� �����Ѵ�.
		System.out.println("���� �غ�");
		if(this.DBOpen() == false) return false;
		System.out.println("���� �Ϸ�");

		//no���� �̿��Ͽ� ���� Ȯ���Ѵ�.
		String sql = "";
		sql  = "select id ";
		sql += "from user ";
		sql += "where no = '" + vo.getNo() + "' ";
		sql += "and retire = 'N' ";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			this.CloseQuery();
			//���� ������ ����
			sql  = "";
			sql += "update user set ";
			sql += "retire='Y' ";
			sql += "where no = '" + vo.getNo() + "' ";
			this.RunSQL(sql);
			
			this.DBClose();
			return true;
		}
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.CloseQuery();
		this.DBClose();
		return false;
	}
	
	//�α��� ó���Ѵ�.
	//���ϰ� : null - �α��� ����, UserVO - �α��� ����
	public UserVO Login(String id,String pw)
	{
		UserVO vo = null;
		
		//�����ͺ��̽��� �����Ѵ�.
		if(this.DBOpen() == false) return vo;
		
		//id/pw�� �̿��Ͽ� �α��� ������ �����´�.	
		String sql = "";
		sql  = "select no,nickname,email,join_date,jop,interest,intro,page,retire,user_rank ";
		sql += "from user ";
		sql += "where id = '" + id + "' ";
		sql += "and pw = md5('" + pw + "') ";
		sql += "and retire = 'N' ";
		this.OpenQuery(sql);
		if(this.GetNext() == false)
		{
			this.CloseQuery();
			//�����ͺ��̽� ������ �����Ѵ�.
			this.DBClose();
			return vo;
		}
		//�α��� ����� VO�� �����Ѵ�.
		vo = new UserVO();
		vo.setNo(this.GetValue("no"));
		vo.setId(id);
		vo.setNickname(this.GetValue("nickname"));
		vo.setEmail(this.GetValue("email"));
		vo.setJoin_date(this.GetValue("join_date"));
		vo.setRetire(this.GetValue("retire"));
		vo.setJop(this.GetValue("jop"));
		vo.setInterest(this.GetValue("interest"));
		vo.setIntro(this.GetValue("intro"));
		vo.setHomepage(this.GetValue("page"));
		vo.setUser_rank(this.GetValue("user_rank"));
		
		this.CloseQuery();
		
		//�����ͺ��̽� ������ �����Ѵ�.
		this.DBClose();
		return vo;		
	}
}
