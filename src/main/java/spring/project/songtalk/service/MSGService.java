package spring.project.songtalk.service;

import java.util.List;

import spring.project.songtalk.domain.MSGVO;

public interface MSGService {
	// 메시지 저장
	public abstract int create(MSGVO vo);
	
	// 메시지 가져오기 (한줄)
	public abstract MSGVO read(int msgBno);
	
	// 메시지 가져오기 (리스트)
	public abstract List<MSGVO> read();
	
	// 메시지 삭제
	public abstract int delete(int msgBno);
}
