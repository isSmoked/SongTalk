package spring.project.songtalk.domain;

public class MemberVO {
	private String memberUserid;
	private String memberPassword;
	private String memberNickname;
	private String memberEmail;
	private int memberBno;
	
	public MemberVO () {}

	public MemberVO(String memberUserid, String memberPassword, String memberNickname, String memberEmail,
			int memberBno) {
		super();
		this.memberUserid = memberUserid;
		this.memberPassword = memberPassword;
		this.memberNickname = memberNickname;
		this.memberEmail = memberEmail;
		this.memberBno = memberBno;
	}

	public String getMemberUserid() {
		return memberUserid;
	}

	public void setMemberUserid(String memberUserid) {
		this.memberUserid = memberUserid;
	}

	public String getMemberPassword() {
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public int getMemberBno() {
		return memberBno;
	}

	public void setMemberBno(int memberBno) {
		this.memberBno = memberBno;
	}

	@Override
	public String toString() {
		return "MemberVO [memberUserid=" + memberUserid + ", memberPassword=" + memberPassword + ", memberNickname="
				+ memberNickname + ", memberEmail=" + memberEmail + ", memberBno=" + memberBno + "]";
	};
	
	
}
