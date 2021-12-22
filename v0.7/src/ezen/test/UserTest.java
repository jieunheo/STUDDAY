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
			//id 중복이 아닌 경우 인서트
			dto.Insert(user);
		}else
		{
			//id 중복인 경우 빠져나옴
			System.out.println("아이디가 중복되었습니다.");
		}
		
		UserVO loginvo;
		loginvo = dto.Login("ezen100", "1234");
		if( loginvo == null)
		{
			System.out.println("로그인 실패.");
		}else
		{
			System.out.println("로그인 성공");
			loginvo.PrintInfo();
		}
		
		if(dto.IsPwCheck(user.getId(),"12345") == UserDTO.PW_OK)
		{
			System.out.println("비밀번호가 일치합니다.");
			
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
				System.out.println("업데이트 성공");
				re_info.PrintInfo();
				
			} else
			{
				System.out.println("업데이트 실패");
				re_info.PrintInfo();
			}
		} else {
			System.out.println("비밀번호가 일치하지 않습니다.");
		}
	}

}
