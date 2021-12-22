package ezen.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import ezen.dbms.*;
import ezen.vo.*;

public class BoardDTO extends DBManager
{
	/* 게시물 등록 */
	public boolean Insert(BoardVO vo)
	{
		//dbms 열기
		if(this.DBOpen() == false) return false;
		
		//insert 구문 만들기
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
		
		//등록된 게시물의 번호를 얻는다.
		sql = "select last_insert_id() as bno ";
		this.OpenQuery(sql);
		this.GetNext();
		vo.setBno(GetLastID("bno"));
		if(GetLastID("bno") == null) return false;
		
		//dbms 닫기
		this.DBClose();		
		return true;
	}
	
	/* 게시물 삭제 */
	public boolean Delete(String no)
	{
		//게시물 삭제 시 연관된 모든 정보를 삭제한다.

		//dbms 열기
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//댓글 정보를 삭제한다.
		sql = "delete from reply ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);		
				
		//첨부파일을 삭제한다.
		sql = "delete from attach ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);

		//게시물을 삭제한다.
		sql  = "delete from board ";
		sql += "where bno = " + no + " ";
		this.RunSQL(sql);

		//dbms 닫기
		this.DBClose();		
		return true;		
	}

	/* 게시물 정보 변경 */
	public boolean Update(BoardVO vo)
	{
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//게시물을 업데이트 한다.
		sql  = "update board ";
		sql += "set title = '" + vo.getTitle().replace("'","''") + "', ";
		sql += "post = '" + vo.getPost().replace("'","''") + "', ";
		sql += "lang = '" + vo.getLang() + "', ";
		sql += "start_date = '" + vo.getStartDate() + "', ";
		sql += "end_date = '" + vo.getEndDate() + " 23:59:59' ";
		sql += "where bno = " + vo.getBno();
		this.RunSQL(sql);
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;		
	}
	
	/* 게시물 정보 조회 */
	public BoardVO Read(String bno,boolean isHit)
	{
		BoardVO vo = null;
		String sql = "";
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return vo;
		
		//조회수 증가
		if(isHit == true)
		{
			sql  = "update board set views = views + 1 where bno = " + bno;
			this.RunSQL(sql);
		}
		
		//게시물의 정보를 얻는다.
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
			//데이터베이스 연결을 종료한다.
			this.DBClose();			
			return vo;			
		}
		//게시물 VO를 생성한다.
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();			
		return vo;
	}
}
