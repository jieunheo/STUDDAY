package ezen.test;

import ezen.dto.UserDTO;
import ezen.vo.UserVO;

public class UserTest {

	public static void main(String[] args) {
		UserVO user = new UserVO();

		user.setNo("1");
		user.setId("ezen2");
		user.setPw("1234");
		user.setNickname("yam");
		user.setEmail("ezen@naver.com");
		user.setJoin_date("2021-12-12 20:12:11");
		user.setRetire("N");
		user.setJop("");
		user.setInterest("");
		user.setIntro("");
		user.setHomepage("");
		user.setUser_rank("U");
		
		UserDTO dto = new UserDTO();
		int code = dto.IsDuplicate("id",user.getId());
		System.out.print(code);
		
		if( code == UserDTO.NOT_DUPLICATE)
		{
			//id �ߺ��� �ƴ� ��� �μ�Ʈ
			dto.Insert(user);
		}else
		{
			//id �ߺ��� ��� ��������
			System.out.println("���̵� �ߺ��Ǿ����ϴ�.");
		}
		
		UserVO loginvo;
		loginvo = dto.Login("ezen2", "1234");
		if( loginvo == null)
		{
			System.out.println("�α��� ����.");
		}else
		{
			System.out.println("�α��� ����");
			loginvo.PrintInfo();
		}
	}

}
