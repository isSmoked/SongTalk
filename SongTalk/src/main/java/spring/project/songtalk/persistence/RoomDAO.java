package spring.project.songtalk.persistence;

import java.util.List;

import spring.project.songtalk.domain.RoomVO;

public interface RoomDAO {
	// 채팅방 개설
	public abstract int insert(RoomVO vo);
	
	// 채팅방 리스트
	public abstract List<RoomVO> select();
	
	// 채팅방 선택
	public abstract RoomVO select(int roomBno);
	
	// 채팅방 정보수정
	public abstract int updateInfo(int roomBno);
	
	// 채팅방 내용갱신
	public abstract int updateContent(int roomBno);
	
	// 채팅방 인원수정
	public abstract int updateMember(int roomBno);
	
	// 채팅방 삭제
	public abstract int delete(int roomBno);
	
	// 채팅방 키워드 검색(title)
	public abstract List<RoomVO> select(String keyword);
}