package spring.project.songtalk.persistence;

import spring.project.songtalk.domain.MemberVO;

public interface MemberDAO {
	// ȸ������
	public abstract int insert(MemberVO vo);
	
	// �α���
	public abstract MemberVO login(MemberVO vo);
	
	// ���� ����
	public abstract int update(int memberBno);
	
	// ���� ����
	public abstract int delete(int memberBno);
}
