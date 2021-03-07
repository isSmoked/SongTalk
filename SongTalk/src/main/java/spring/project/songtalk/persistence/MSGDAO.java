package spring.project.songtalk.persistence;

import java.util.List;

import spring.project.songtalk.domain.MSGVO;

public interface MSGDAO {
	
	// �޽��� ����
	public abstract int insert(MSGVO vo);
	
	// �޽��� ���
	public abstract MSGVO select(int msgBno);
	
	// �޽��� ���(����Ʈ)
	public abstract List<MSGVO> select();
	
	// �޽��� ����
	public abstract int delete(int msgBno);
}
