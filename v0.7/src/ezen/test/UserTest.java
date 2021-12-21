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
			//id 중복이 아닌 경우 인서트
			dto.Insert(user);
		}else
		{
			//id 중복인 경우 빠져나옴
			System.out.println("아이디가 중복되었습니다.");
		}
		
		UserVO loginvo;
		loginvo = dto.Login("ezen2", "1234");
		if( loginvo == null)
		{
			System.out.println("로그인 실패.");
		}else
		{
			System.out.println("로그인 성공");
			loginvo.PrintInfo();
		}
	}

}
