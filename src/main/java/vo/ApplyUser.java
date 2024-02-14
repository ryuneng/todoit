package vo;

import java.util.Date;

public class ApplyUser {
	private int no;			   // 참여번호
	private String accepted;   // 승인여부
	private Date acceptedDate; // 승인일자
	private String refunded;   // 환불여부
	private Date appliedDate;  // 신청일자
	private User user;		   // 유저번호
	private Meeting meeting;   // 모임번호
	private String canceled;   // 취소여부
	private Date canceledDate; // 취소날짜
	
	public ApplyUser() {}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getAccepted() {
		return accepted;
	}
	public void setAccepted(String accepted) {
		this.accepted = accepted;
	}
	public Date getAcceptedDate() {
		return acceptedDate;
	}
	public void setAcceptedDate(Date acceptedDate) {
		this.acceptedDate = acceptedDate;
	}
	public String getRefunded() {
		return refunded;
	}
	public void setRefunded(String refunded) {
		this.refunded = refunded;
	}
	public Date getAppliedDate() {
		return appliedDate;
	}
	public void setAppliedDate(Date appliedDate) {
		this.appliedDate = appliedDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Meeting getMeeting() {
		return meeting;
	}
	public void setMeeting(Meeting meeting) {
		this.meeting = meeting;
	}
	public String getCanceled() {
		return canceled;
	}
	public void setCanceled(String canceled) {
		this.canceled = canceled;
	}
	public Date getCanceledDate() {
		return canceledDate;
	}
	public void setCanceledDate(Date canceledDate) {
		this.canceledDate = canceledDate;
	}

	@Override
	public String toString() {
		return "ApplyUser [no=" + no + ", accepted=" + accepted + ", acceptedDate=" + acceptedDate + ", refunded="
				+ refunded + ", appliedDate=" + appliedDate + ", user=" + user + ", meeting=" + meeting + ", canceled="
				+ canceled + ", canceledDate=" + canceledDate + "]";
	}
	
	
	
}
