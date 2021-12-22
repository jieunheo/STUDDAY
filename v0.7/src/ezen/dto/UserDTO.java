package ezen.dto;

import ezen.dbms.*;
import ezen.vo.*;

public class UserDTO extends DBManager
{
	public final static int ERROR         = 0;
	public final static int DUPLICATE     = 1;
	public final static int NOT_DUPLICATE = 2;
	public final static int PW_OK         = 3;
		
	//회원 아이디 중복 검사
	//리턴값 : ERROR - 오류, DUPLICATE - 중복, NOT_DUPLICATE - 중복아님 
	public int IsDuplicate(String kind, String value)
	{
		//데이터베이스에 연결
		if(this.DBOpen() == false) 
		{
			return ERROR;
		}
		
		//id 중복검사
		String sql = "";
		sql += "select " + kind + " ";
		sql += "from user ";
		sql += "where " + kind + " = '" + value + "'";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			//ID가 중복됨
			this.CloseQuery();
			this.DBClose();
			return DUPLICATE;
		} else
		{
			if( (!kind.equals("nickname") && value.length() < 4) || (kind.equals("nickname") && value.length() < 2) )
			{ //아이디와 이메일은 4글자 이하인 경우															닉네임은 2글자 이하인 경우
				return ERROR;
			}
		}
		this.CloseQuery();
		
		//데이터베이스 연결 종료
		this.DBClose();
		return NOT_DUPLICATE;
	}
	
	public int IsPwCheck(String id, String pw)
	{
		//데이터베이스에 연결
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
			//pw가 일치하지 않으면
			this.CloseQuery();
			this.DBClose();
			return ERROR;
		}
		
		this.CloseQuery();
		this.DBClose();
		return PW_OK;
	}
	
	//회원 가입 처리
	//리턴값 : true-등록완료, false-오류
	public boolean Insert(UserVO vo)
	{
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		//user 테이블에 Insert하는 구문을 만든다.
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
		
		//등록된 아이디의 번호를 얻는다.
		sql = "select last_insert_id() as no ";
		this.OpenQuery(sql);
		this.GetNext();
		String no = this.GetValue("no");
		vo.setNo(no);
		this.CloseQuery();
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;
	}
	
	
	public UserVO Update(UserVO vo)
	{
		UserVO login = null;
		
		//데이터베이스에 연결한다.
		System.out.println("연결 준비");
		if(this.DBOpen() == false) return null;
		System.out.println("연결 완료");
		
		//no값을 이용하여 값을 확인한다.
		String sql = "";
		sql  = "select id,pw ";
		sql += "from user ";
		sql += "where no = '" + vo.getNo() + "' ";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			this.CloseQuery();
			//값이 있으면 수정
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
		//데이터베이스 연결을 종료한다.
		this.CloseQuery();
		this.DBClose();
		return login;
	}
	
	public boolean Delete(UserVO vo)
	{
		//데이터베이스에 연결한다.
		System.out.println("연결 준비");
		if(this.DBOpen() == false) return false;
		System.out.println("연결 완료");

		//no값을 이용하여 값을 확인한다.
		String sql = "";
		sql  = "select id ";
		sql += "from user ";
		sql += "where no = '" + vo.getNo() + "' ";
		sql += "and retire = 'N' ";
		this.OpenQuery(sql);
		if(this.GetNext() == true)
		{
			this.CloseQuery();
			//값이 있으면 수정
			sql  = "";
			sql += "update user set ";
			sql += "retire='Y' ";
			sql += "where no = '" + vo.getNo() + "' ";
			this.RunSQL(sql);
			
			this.DBClose();
			return true;
		}
		
		//데이터베이스 연결을 종료한다.
		this.CloseQuery();
		this.DBClose();
		return false;
	}
	
	//로그인 처리한다.
	//리턴값 : null - 로그인 실패, UserVO - 로그인 성공
	public UserVO Login(String id,String pw)
	{
		UserVO vo = null;
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return vo;
		
		//id/pw를 이용하여 로그인 정보를 가져온다.	
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
			//데이터베이스 연결을 종료한다.
			this.DBClose();
			return vo;
		}
		//로그인 사용자 VO를 생성한다.
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return vo;		
	}
}
