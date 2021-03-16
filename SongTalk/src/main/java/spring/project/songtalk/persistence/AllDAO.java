package spring.project.songtalk.persistence;

import java.util.List;

import spring.project.songtalk.domain.AllVO;

public interface AllDAO {
	// 전체채팅 메시지 작성
	public abstract int insert(AllVO vo);
	
	// 전체채팅 메시지 선택
	public abstract List<AllVO> select();
}
