package spring.project.songtalk.persistence;

import spring.project.songtalk.domain.MemberVO;

public interface MemberDAO {
	// 회원가입
	public abstract int insert(MemberVO vo);
	
	// 로그인
	public abstract MemberVO login(MemberVO vo);
	
	// 정보 수정
	public abstract int update(int memberBno);
	
	// 정보 삭제
	public abstract int delete(int memberBno);
}
