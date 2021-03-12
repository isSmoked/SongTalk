package spring.project.songtalk.persistence;

import java.util.List;

import spring.project.songtalk.domain.RoomVO;

public interface RoomDAO {
	// ä�ù� ����
	public abstract int insert(RoomVO vo);
	
	// ä�ù� ����Ʈ
	public abstract List<RoomVO> select();
	
	// ä�ù� ����
	public abstract RoomVO select(int roomBno);
	
	// ä�ù� ��������
	public abstract int updateInfo(int roomBno);
	
	// ä�ù� ���밻��
	public abstract int updateContent(RoomVO vo);
	
	// ä�ù� �ο�����
	public abstract int updateMember(int roomBno);
	
	// ä�ù� ����
	public abstract int delete(int roomBno);
	
	// ä�ù� Ű���� �˻�(title)
	public abstract List<RoomVO> select(String keyword);
}