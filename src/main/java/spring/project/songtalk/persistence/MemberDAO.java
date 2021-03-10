package spring.project.songtalk.persistence;

import spring.project.songtalk.domain.MemberVO;

public interface MemberDAO {
	// ȸ������
	public abstract int insert(MemberVO vo);
	
	// �α���
	public abstract MemberVO login(MemberVO vo);
	
	// ���� ����
	public abstract int update(MemberVO vo);
	
	// ���� ����
	public abstract int delete(String userid);
	
	// ȸ�� �˻�
	public abstract MemberVO select(String userid); 
}
