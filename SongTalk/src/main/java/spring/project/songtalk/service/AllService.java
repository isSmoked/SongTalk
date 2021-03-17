package spring.project.songtalk.service;

import java.util.List;

import spring.project.songtalk.domain.AllVO;

public interface AllService {
	// 전체 채팅메시지 작성
	public abstract int create(AllVO vo);
	
	// 전체채팅 메시지 선택
	public abstract List<AllVO> read(int allCount);
}
