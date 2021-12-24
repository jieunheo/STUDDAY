package ezen.dto;

import java.util.ArrayList;

import ezen.dbms.DBManager;
import ezen.vo.BoardVO;
import ezen.vo.ReplyVO;

public class ReplyDTO extends DBManager
{
	private ArrayList<ReplyVO> list;
	
	/* 댓글 등록 */
	public boolean Insert(ReplyVO vo)
	{
		//dbms 열기
		if(this.DBOpen() == false) return false;
		
		//insert 구문 만들기
		String sql  = "";
		sql += "insert into reply (bno,no,rpost) ";
		sql += "values (";
		sql += "'" + vo.getBno() + "',";
		sql += "'" + vo.getNo() + "',";
		sql += "'" + vo.getRpost().replace("'","''") + "') ";
		this.RunSQL(sql);	
		
		//등록된 댓글 번호를 얻는다.
		sql = "select last_insert_id() as rno ";
		this.OpenQuery(sql);
		this.GetNext();
		vo.setBno(GetLastID("rno"));
		if(GetLastID("rno") == null) return false;
		
		//dbms 닫기
		this.DBClose();		
		return true;
	}
	

	/* 댓글 삭제 */
	public boolean Delete(String rno)
	{
		//dbms 열기
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//댓글 정보를 삭제한다.
		sql = "delete from reply ";
		sql += "where rno = " + rno + " ";
		this.RunSQL(sql);

		//dbms 닫기
		this.DBClose();		
		return true;		
	}
	

	/* 댓글 정보 변경 */
	public boolean Update(ReplyVO vo)
	{
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		String sql = "";
		
		//댓글 업데이트
		sql  = "update reply ";
		sql += "set rpost = '" + vo.getRpost().replace("'","''") + "' ";
		sql += "where rno = " + vo.getRno();
		this.RunSQL(sql);
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;		
	}

	/* 댓글 정보 조회 */
	public boolean GetReply(String bno)
	{
		this.list = null;
		String sql = "";
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		//게시물의 정보를 얻는다.
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

			//게시물 VO를 생성한다.
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;
	}
	
	//목록에서 게시물 정보를 얻는다.
	public ReplyVO GetItem(int index)
	{
		if(this.list == null) return null;
		else return list.get(index);		
	}
	
	//목록을 ArrayList로 몽땅 얻는다.
	public ArrayList<ReplyVO> GetListArray()
	{
		return this.list;
	}
	
	/* 본인이 작성한 댓글인지 확인 */
	public boolean isMyReply(String rno, String no)
	{
		String sql = "";
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		//게시물의 정보를 얻는다.
		sql = "";
		sql += "select no ";
		sql += "from reply ";
		sql += "where rno = '" + rno + "' ";
		sql += "and no = '" + no + "' ";
		this.OpenQuery(sql);
		if(this.GetNext() == false)
		{
			this.CloseQuery();
			//데이터베이스 연결을 종료한다.
			this.DBClose();
			return false;
		}
		this.CloseQuery();
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;
	}
}
