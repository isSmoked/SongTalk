package spring.project.songtalk.service;

import spring.project.songtalk.domain.MemberVO;

public interface MemberService {
	// ȸ������
	public abstract int create(MemberVO vo);
	
	// �α���
	public abstract MemberVO login(MemberVO vo);
	
	// ���� ����
	public abstract int update(MemberVO vo);
	
	// ���� ����
	public abstract int delete(MemberVO vo);
}
