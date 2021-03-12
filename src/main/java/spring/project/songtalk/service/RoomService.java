package spring.project.songtalk.service;

import java.util.List;

import spring.project.songtalk.domain.RoomVO;

public interface RoomService {
	// 채팅방 개설
	public abstract int create(RoomVO vo);
	
	// 채팅방 선택
	public abstract RoomVO read(int roomBno);
	
	// 채팅방 리스트
	public abstract List<RoomVO> read();
	
	// 채팅방 정보수정
	public abstract int updateInfo(int roomBno);
	
	// 채팅방 인원수정
	public abstract int updateMember(int roomBno);
	
	// 채팅방 내용수정
	public abstract int updateContent(RoomVO vo);
	
	// 채팅방 삭제
	public abstract int delete(int roomBno);
	
	// 키워드로 검색
	public abstract List<RoomVO> select(String keyword);
}