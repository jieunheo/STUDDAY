package ezen.vo;

//검색조건을 관리하기 위한 클래스
public class SearchVO 
{
	private String kinds;     //분야
	private String keyword;   //검색어
	private String sortcol;   //정렬 컬럼
	private String sortorder; //오름/내림차순
	private int    curpage;   //현재 페이지
	
	public SearchVO()
	{
		//기본값 설정
		kinds     = "1";
		keyword   = "";
		sortcol   = "bno";
		sortorder = "desc";
	}


	/* setter */
	public void setCurpage(int curpage)    {
		if(curpage == 0) curpage = 1;
		this.curpage = curpage; 
	}
	public void setCurpage(String curpage) {
		try
		{
			//문자를 숫자로 변환
			this.curpage = Integer.parseInt(curpage);
		}catch(Exception e)
		{
			//null이거나 "" 혹은 문자일 경우 1로 초기화
			this.curpage = 1;
		}
	}
	
	public void setKinds(String kinds) {
		if(kinds == null) this.kinds ="1";
		else this.kinds = kinds;
	}

	public void setKeyword(String keyword) {
		if(keyword == null) this.keyword ="";
		else this.keyword = keyword;
	}
	
	public void setSortcol(String sortcol) {
		if(sortcol == null) this.sortcol ="bno";
		else this.sortcol = sortcol;
	}

	public void setSortorder(String sortorder) {
		if(sortorder == null) this.sortorder ="desc";
		else this.sortorder = sortorder;		
	}

	/* getter */
	public String getKinds()     { return kinds;     }
	public String getKeyword()   { return keyword;   }
	public String getSortcol()   { return sortcol;   }
	public String getSortorder() { return sortorder; }
	public int    getCurpage()   { return curpage;   }

	/* 뷰 링크 구하기 */
	public String GetViewLink(String bno)
	{
		String link = "";
		link  = "kinds=" + kinds;
		link += "&key="+ keyword;
		link += "&page=" + curpage;
		link += "&oc=" + sortcol;
		link += "&ob=" + sortorder;
		link += "&bno=" + bno; //클릭한 뷰의 번호
		return link;
	}
	
	/* 페이지 링크 구하기 */
	public String GetPageLink(int pageno)
	{
		String link = "";
		link  = "kinds=" + kinds;
		link += "&key="+ keyword;
		link += "&page=" + pageno; //변하는 값이 페이지
		link += "&oc=" + sortcol;
		link += "&ob=" + sortorder;
		return link;
	}
	
	public String getKindName()
	{
		String strmenu   = "STUDY"; //메뉴표시이름
		switch (kinds)
		{
			case "0": 
				strmenu = "Notice";
				break;
			case "9":
				strmenu = "Talk";
				break;
		}
		
		return strmenu;
	}	
}
