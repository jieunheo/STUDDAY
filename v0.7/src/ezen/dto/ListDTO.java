package ezen.dto;

import java.util.ArrayList;

import ezen.dbms.DBManager;
import ezen.vo.*;

//게시물 목록 가져오기 클래스
public class ListDTO extends DBManager
{
	private SearchVO search = null;
	private String   where  = "";
	private ArrayList<BoardVO> list;
	
	//무조건 search를 받아야만 생성 가능
	public ListDTO(SearchVO search)
	{
		this.search = search;

		where = "kinds ='"+ search.getKinds()+ "' "; //구분값[기본값-1]
		if(search.getKeyword().equals("") != true)
		{
			//검색 키워드가 있는 경우 추가
			where += "and title like '%"+ search.getKeyword() + "%' ";
		}		
	}
	
	//전체 게시물 갯수를 얻는다.
	public int GetTotal()
	{
		int total = 0;
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return 0;
		
		//전체 갯수를 얻는다.
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		
		return total;
	}	
	
	//게시물 목록을 가져온다.
	public boolean GetList(int curpage)
	{
		String sql = "";
		
		this.list = null;
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		//SQL의  limit 시작 번호를 계산한다.
		int startno = (curpage - 1) * 10;
		
		//게시물 목록을 조회한다.
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
			String bno         = this.GetValue("bno");           //게시글번호
			String no          = this.GetValue("no");            //회원번호
			String nickname    = this.GetValue("nickname");      //닉네임
			String kinds       = this.GetValue("kinds");         //분야
			String title       = this.GetValue("title");         //제목
			String post        = this.GetValue("post");          //내용
			String lang        = this.GetValue("lang");          //언어
			String date        = this.GetValue("date");          //작성일
			String start_date  = this.GetValue("start_date");    //시작 날짜
			String end_date    = this.GetValue("end_date");      //끝 날짜
			int    views       = this.GetInteger("views");       //조회수
			int    reply_count = this.GetInteger("reply_count"); //댓글 갯수
			int    attach      = this.GetInteger("attach");      //첨부파일
			
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;
	}
	
	public boolean GetMainList()
	{
		String sql = "";
		
		this.list = null;
		
		//데이터베이스에 연결한다.
		if(this.DBOpen() == false) return false;
		
		//게시물 목록을 조회한다.
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
			String bno         = this.GetValue("bno");        //게시글번호
			String no          = this.GetValue("no");         //회원번호
			String kinds       = this.GetValue("kinds");      //분야
			String title       = this.GetValue("title");      //제목
			String lang        = this.GetValue("lang");       //언어
			String date        = this.GetValue("date");       //작성일
			String start_date  = this.GetValue("start_date"); //시작 날짜
			String end_date    = this.GetValue("end_date");   //끝 날짜
			int    views       = this.GetInteger("views");    //조회수
			
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
		
		//데이터베이스 연결을 종료한다.
		this.DBClose();
		return true;
	}
	
	//조회된 목록의 갯수를 얻는다.
	public int GetListTotal()
	{
		if(this.list == null) return 0;
		else return list.size();
	}
	
	//목록에서 게시물 정보를 얻는다.
	public BoardVO GetItem(int index)
	{
		if(this.list == null) return null;
		else return list.get(index);		
	}
	
	//목록을 ArrayList로 몽땅 얻는다.
	public ArrayList<BoardVO> GetListArray()
	{
		return this.list;
	}	
}


