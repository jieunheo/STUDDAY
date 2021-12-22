package ezen.test;

import ezen.dto.UserDTO;
import ezen.vo.UserVO;

public class UserTest {

	public static void main(String[] args) {
		UserVO user = new UserVO();

		user.setNo("1");
		user.setId("ezen100");
		user.setPw("1234");
		user.setNickname("yam");
		user.setEmail("ezen100@naver.com");
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
		loginvo = dto.Login("ezen100", "1234");
		if( loginvo == null)
		{
			System.out.println("�α��� ����.");
		}else
		{
			System.out.println("�α��� ����");
			loginvo.PrintInfo();
		}
		
		if(dto.IsPwCheck(user.getId(),"12345") == UserDTO.PW_OK)
		{
			System.out.println("��й�ȣ�� ��ġ�մϴ�.");
			
			String no = "23";
			String id = "ezen100";
			String pw = "";
			String nickname = "yamyam";
			String email = "yamyam@naver.com";
			String join_date = "2021-12-12 20:12:11";
			String retire = "N";
			String jop = "";
			String interest = "";
			String intro = "";
			String homepage = "";
			String user_rank = "U";
			
			UserVO re_info = new UserVO(id,pw,nickname,email,jop,interest,intro,homepage);
			re_info.setNo(no);
			re_info.setJoin_date(join_date);
			re_info.setRetire(retire);
			re_info.setUser_rank(user_rank);
			
			if(dto.Update(re_info) != null)
			{
				System.out.println("������Ʈ ����");
				re_info.PrintInfo();
				
			} else
			{
				System.out.println("������Ʈ ����");
				re_info.PrintInfo();
			}
		} else {
			System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		}
	}

}
