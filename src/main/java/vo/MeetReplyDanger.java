package vo;

public class MeetReplyDanger {

	private MeetingReply meetingReply;
	private User user;
	
	public MeetReplyDanger() {}

	public MeetingReply getMeetingReply() {
		return meetingReply;
	}

	public void setMeetingReply(MeetingReply meetingReply) {
		this.meetingReply = meetingReply;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "MeetReplyDanger [meetingReply=" + meetingReply + ", user=" + user + "]";
	}
	
	
}
