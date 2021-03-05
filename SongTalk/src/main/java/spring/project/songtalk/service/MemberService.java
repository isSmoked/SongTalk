package spring.project.songtalk.service;

import spring.project.songtalk.domain.MemberVO;

public interface MemberService {
	// 회원가입
	public abstract int create(MemberVO vo);
	
	// 로그인
	public abstract MemberVO login(MemberVO vo);
	
	// 정보 수정
	public abstract int update(MemberVO vo);
	
	// 정보 삭제
	public abstract int delete(MemberVO vo);
}
