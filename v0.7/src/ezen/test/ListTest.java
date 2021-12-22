package ezen.test;

import ezen.dto.ListDTO;
import ezen.vo.BoardVO;
import ezen.vo.SearchVO;

public class ListTest
{
	public static void main(String[] args)
	{
		SearchVO search = new SearchVO();
		
		search.setKinds("1");
		//search.setKeyword("10");
		search.setCurpage(1);
		
		ListDTO dto = new ListDTO(search);
		int total = dto.GetTotal();
		System.out.println("ÀüÃ¼ °¹¼ö :" + total);
		
		dto.GetList(1);
		int size = dto.GetListTotal();
		for(int i=0; i < size; i++)
		{
			BoardVO vo = dto.GetItem(i);
			vo.PrintInfo();
			System.out.println("**************************");
		}
	}
}
