package spring.project.songtalk.persistence;

import java.util.List;

import spring.project.songtalk.domain.MSGVO;

public interface MSGDAO {
	
	// 메시지 저장
	public abstract int insert(MSGVO vo);
	
	// 메시지 출력
	public abstract MSGVO select(int msgBno);
	
	// 메시지 출력(리스트)
	public abstract List<MSGVO> select();
	
	// 메시지 삭제
	public abstract int delete(int msgBno);
	
	// 최근 메시지 가져오기
	public abstract MSGVO selectNew();
}