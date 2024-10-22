package spring.project.songtalk.domain;

public class RoomVO {
	private String roomUser;
	private String roomTitle;
	private String roomContent;
	private int roomBno;
	private int roomCount;
	
	public RoomVO () {}

	public RoomVO(String roomUser, String roomTitle, String roomContent, int roomBno, int roomCount) {
		super();
		this.roomUser = roomUser;
		this.roomTitle = roomTitle;
		this.roomContent = roomContent;
		this.roomBno = roomBno;
		this.roomCount = roomCount;
	}

	public String getRoomUser() {
		return roomUser;
	}

	public void setRoomUser(String roomUser) {
		this.roomUser = roomUser;
	}

	public String getRoomTitle() {
		return roomTitle;
	}

	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}

	public String getRoomContent() {
		return roomContent;
	}

	public void setRoomContent(String roomContent) {
		this.roomContent = roomContent;
	}

	public int getRoomBno() {
		return roomBno;
	}

	public void setRoomBno(int roomBno) {
		this.roomBno = roomBno;
	}
	
	public int getRoomCount() {
		return roomCount;
	}
	
	public void setRoomCount(int roomCount) {
		this.roomCount = roomCount;
	}

	@Override
	public String toString() {
		return "RoomVO [roomUser=" + roomUser + ", roomTitle=" + roomTitle + ", roomContent=" + roomContent
				+ ", roomBno=" + roomBno + ", roomCount=" + roomCount + "]";
	}
	
	
}
