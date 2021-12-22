package ezen.vo;

public class ListStateVO {
	private String kind;    //�Խù������̸�
	private String writer;  //�ۼ���ǥ���̸�
	private String title;   //������ǥ���̸�
	private int    filter;  //ȭ�� ���͸� - -1
	
	private String extitle; //���񿹽�
	private String expost;  //���뿹��
	
	public ListStateVO(String kinds) {
		
		kind    = "";     //�Խù������̸�
		writer  = "�ۼ���"; //�ۼ���ǥ���̸�
		title   = "����";  //������ǥ���̸�
		filter  = -1;     //ȭ�� ���͸�

		extitle = "������ �Է����ּ���."; //���񿹽�
		expost  = "������ �Է����ּ���."; //���뿹��
		
		switch (kinds)
		{
			case "0": //����
				kind   = "Notice";
				filter = 0;
				break;
			case "1": //���͵��ϱ�
				kind      = "With Us";
				writer    = "����";
				title     = "���͵��̸�";
				extitle   = "���͵���� �ҷ�������!";     //������ǥ���̸�
				expost    = "� ���͵����� �˷��ּ���!!"; //������ǥ���̸�
				filter    = 1;
				break;
			case "2": //����
				kind   = "Lecture";
				writer = "��õ��";
				break;
			case "3": //�ڷ�� 
				kind = "Reference";
				break;
			case "4": //�� 
				kind = "Tip";
				break;
			case "5": //����
				kind = "Q&A";
				break;
			case "9": //�����Խ���
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
