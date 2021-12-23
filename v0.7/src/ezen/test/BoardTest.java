package ezen.test;

import ezen.dto.BoardDTO;
import ezen.vo.BoardVO;

public class BoardTest
{

	public static void main(String[] args)
	{
		/*//insert
		BoardVO vo = new BoardVO("10","1","제목","내용");
		vo.setLang("java");
		vo.setStart_date("2021-12-22");
		vo.setEnd_date("2021-12-25");

		BoardDTO dto = new BoardDTO();
		dto.Insert(vo);
		vo.PrintInfo();
		*/
		/*//view
		BoardVO vo = null;
		BoardDTO dto = new BoardDTO();
		vo = dto.Read("313", false);
		vo.PrintInfo();
		*/
		/*//delete
		BoardDTO dto = new BoardDTO();
		dto.Delete("313");
		*/
		
		/*//update
		BoardVO vo = null;
		BoardDTO dto = new BoardDTO();
		
		vo = dto.Read("315", false);
		vo.PrintInfo();	
		vo.setTitle("315번째 제목입니다.");
		vo.setPost("315 내용이랍니다.");
		dto.Update(vo);
		vo.PrintInfo();
		*/
		

		BoardVO vo = null;
		BoardDTO dto = new BoardDTO();
		
		vo = dto.Read("315", false);
		String state = vo.GetStudyState();
		System.out.println(state);
	}

}
