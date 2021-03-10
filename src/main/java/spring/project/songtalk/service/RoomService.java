package spring.project.songtalk.service;

import java.util.List;

import spring.project.songtalk.domain.RoomVO;

public interface RoomService {
	// ä�ù� ����
	public abstract int create(RoomVO vo);
	
	// ä�ù� ����
	public abstract RoomVO read(int roomBno);
	
	// ä�ù� ����Ʈ
	public abstract List<RoomVO> read();
	
	// ä�ù� ��������
	public abstract int updateInfo(int roomBno);
	
	// ä�ù� �ο�����
	public abstract int updateMember(int roomBno);
	
	// ä�ù� �������
	public abstract int updateContent(int roomBno);
	
	// ä�ù� ����
	public abstract int delete(int roomBno);
}
