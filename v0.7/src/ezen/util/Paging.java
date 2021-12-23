package ezen.util;

import ezen.vo.*;

//�Խ��� ����¡ Ŭ����
public class Paging 
{
	//����¡�� ���� ���� ����
	private int total      = 0; //��ü �Խù� ����
	private int maxpage    = 0; //�ִ� ������ ����
	private int curpage    = 0; //���� ������ ��ȣ
	private int startBlock = 0; //����¡ ���� �� ��ȣ
	private int endBlock   = 0; //����¡ �� �� ��ȣ
	
	SearchVO search = null;

	/* �˻� ���� �޾ƿ��� */
	public Paging(SearchVO search) { this.search = search; }

	/* setter */
	public void setTotal(int total,int curpage) 
	{
		this.total   = total;
		this.curpage = curpage;

		//�ִ� ������ ������ ����Ѵ�.
		maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//����¡ ���ۺ���ȣ�� ���� ��ȣ�� ����Ѵ�.
		startBlock = ( (curpage - 1)  / 10) * 10 + 1;
		endBlock   = startBlock + 10 - 1; 	
		
		//endBlock �� �ִ� ������ ��ȣ���� ũ�� �ȵ�.
		if( endBlock > maxpage)
		{
			//��: maxpage�� 22�ε�, endBlock�� 30�̸� endBlock�� 22�� ����
			endBlock = maxpage;
		}
	}


	/* getter */
	public int getTotal()           { return total;      }
	public int getMaxpage()         { return maxpage;    }
	public int getCurpage()         { return curpage;    }
	public int getStartBlock()      { return startBlock; }
	public int getEndBlock()        { return endBlock;   }
	
	/* ���� ����¡ ��� */
	public String getPage(int page) { return search.GetPageLink(page); }
	
	/* ���� ����¡ ��� */
	public String getPrevBlock()
	{
		if( startBlock >= 10 )
		{
			return search.GetPageLink(startBlock - 1);
		}else
		{
			return null;
		}
	}
	
	/* ���� ����¡ ��� */
	public String getNextBlock()
	{
		if( endBlock < maxpage)
		{
			return search.GetPageLink(endBlock + 1);
		}else
		{
			return null;
		}
	}	
	
}
