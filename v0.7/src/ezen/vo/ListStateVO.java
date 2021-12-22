package ezen.vo;

public class ListStateVO {
	private String kind;    //게시물종류이름
	private String writer;  //작성자표시이름
	private String title;   //글제목표시이름
	private int    filter;  //화면 필터링 - -1
	
	private String extitle; //제목예시
	private String expost;  //내용예시
	
	public ListStateVO(String kinds) {
		
		kind    = "";     //게시물종류이름
		writer  = "작성자"; //작성자표시이름
		title   = "제목";  //글제목표시이름
		filter  = -1;     //화면 필터링

		extitle = "제목을 입력해주세요."; //제목예시
		expost  = "내용을 입력해주세요."; //내용예시
		
		switch (kinds)
		{
			case "0": //공지
				kind   = "Notice";
				filter = 0;
				break;
			case "1": //스터디구하기
				kind      = "With Us";
				writer    = "리더";
				title     = "스터디이름";
				extitle   = "스터디원을 불러보세요!";     //글제목표시이름
				expost    = "어떤 스터디인지 알려주세요!!"; //글제목표시이름
				filter    = 1;
				break;
			case "2": //강의
				kind   = "Lecture";
				writer = "추천자";
				break;
			case "3": //자료실 
				kind = "Reference";
				break;
			case "4": //팁 
				kind = "Tip";
				break;
			case "5": //질문
				kind = "Q&A";
				break;
			case "9": //자유게시판
				kind   = "Talk";
				filter = 0;
				break;
		}
	}
	
	/* getter */
	public String getKind()      { return kind;      }
	public String getWriter()    { return writer;    }
	public String getTitle()     { return title;     }
	public int    getFilter()    { return filter;    }
	public String getExtitle()   { return extitle;   }
	public String getExpost()    { return expost;    }
	
	
}
