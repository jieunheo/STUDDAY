package ezen.test;

import java.util.ArrayList;

import ezen.dto.ReplyDTO;
import ezen.vo.ReplyVO;

public class ReplyTest {

	public static void main(String[] args)
	{
		/*
		ReplyVO vo = new ReplyVO();
		vo.setBno("334");
		vo.setNo("10");
		vo.setRpost("dto�� �̿��� ��� ���");
		
		ReplyDTO dto = new ReplyDTO();
		dto.Insert(vo);
		vo.PrintInfo();
		 */
		
		ArrayList<ReplyVO> list = null;
		ReplyDTO dto = new ReplyDTO();
		if(dto.GetReply("334"))
		{
			list = dto.GetListArray();
			
			for(int i=0; i<list.size(); i++)
			{
				ReplyVO vo = null;
				vo = list.get(i);
				vo.PrintInfo();
			}
		}
		
		/*
		ReplyVO vo = null;
		ReplyDTO dto = new ReplyDTO();
		vo = dto.Read("53");
		vo.setRpost("dto�� �̿��Ͽ� �����Ͽ����ϴ�.");
		dto.Update(vo);
		vo.PrintInfo();
		*/
		/*
		ReplyVO vo = null;
		ReplyDTO dto = new ReplyDTO();
		vo = dto.Read("53");
		if(dto.Delete(vo.getRno()))
		{
			System.out.println("���� �Ǿ����ϴ�.");
		} else
		{
			System.out.println("�������� �ʾҽ��ϴ�.");
		}
		*/
		/*
		ReplyDTO dto = new ReplyDTO();
		if(dto.isMyReply("52", "30"))
		{
			System.out.println("���� ���Դϴ�.");
		} else
		{
			System.out.println("��������?");
		}
		*/
	}

}
