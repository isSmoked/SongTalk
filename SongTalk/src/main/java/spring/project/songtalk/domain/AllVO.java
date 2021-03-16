package spring.project.songtalk.domain;

public class AllVO {
	private int allBno;
	private String allSender;
	private String allContent;
	
	public AllVO() {}
	
	public AllVO(int allBno, String allSender, String allContent) {
		super();
		this.allBno = allBno;
		this.allSender = allSender;
		this.allContent = allContent;
	}

	public int getAllBno() {
		return allBno;
	}

	public void setAllBno(int allBno) {
		this.allBno = allBno;
	}

	public String getAllSender() {
		return allSender;
	}

	public void setAllSender(String allSender) {
		this.allSender = allSender;
	}

	public String getAllContent() {
		return allContent;
	}

	public void setAllContent(String allContent) {
		this.allContent = allContent;
	}


	@Override
	public String toString() {
		return "AllVO [allBno=" + allBno + ", allSender=" + allSender + ", allContent=" + allContent
				+  "]";
	}
}
