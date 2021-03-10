package spring.project.songtalk.service;

import java.util.List;

import spring.project.songtalk.domain.MSGVO;

public interface MSGService {
	// �޽��� ����
	public abstract int create(MSGVO vo);
	
	// �޽��� �������� (����)
	public abstract MSGVO read(int msgBno);
	
	// �޽��� �������� (����Ʈ)
	public abstract List<MSGVO> read();
	
	// �޽��� ����
	public abstract int delete(int msgBno);
}
