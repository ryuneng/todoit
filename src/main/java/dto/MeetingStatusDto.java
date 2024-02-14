package dto;

public class MeetingStatusDto {
	private int no;
	private int meetingCnt;
	private int totalPrice;
	private int userCnt;
	
	public MeetingStatusDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMeetingCnt() {
		return meetingCnt;
	}

	public void setMeetingCnt(int meetingCnt) {
		this.meetingCnt = meetingCnt;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(int userCnt) {
		this.userCnt = userCnt;
	}

	@Override
	public String toString() {
		return "MeetingStatusDto [no=" + no + ", meetingCnt=" + meetingCnt + ", totalPrice=" + totalPrice + ", userCnt="
				+ userCnt + "]";
	}
	
}
