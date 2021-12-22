package ezen.vo;

//�˻������� �����ϱ� ���� Ŭ����
public class SearchVO 
{
	private String kinds;     //�о�
	private String keyword;   //�˻���
	private String sortcol;   //���� �÷�
	private String sortorder; //����/��������
	private int    curpage;   //���� ������
	
	public SearchVO()
	{
		//�⺻�� ����
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
			//���ڸ� ���ڷ� ��ȯ
			this.curpage = Integer.parseInt(curpage);
		}catch(Exception e)
		{
			//null�̰ų� "" Ȥ�� ������ ��� 1�� �ʱ�ȭ
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

	/* �� ��ũ ���ϱ� */
	public String GetViewLink(String bno)
	{
		String link = "";
		link  = "kinds=" + kinds;
		link += "&key="+ keyword;
		link += "&page=" + curpage;
		link += "&oc=" + sortcol;
		link += "&ob=" + sortorder;
		link += "&bno=" + bno; //Ŭ���� ���� ��ȣ
		return link;
	}
	
	/* ������ ��ũ ���ϱ� */
	public String GetPageLink(int pageno)
	{
		String link = "";
		link  = "kinds=" + kinds;
		link += "&key="+ keyword;
		link += "&page=" + pageno; //���ϴ� ���� ������
		link += "&oc=" + sortcol;
		link += "&ob=" + sortorder;
		return link;
	}
	
	public String getKindName()
	{
		String strmenu   = "STUDY"; //�޴�ǥ���̸�
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
