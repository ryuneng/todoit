package vo;

public class CommReplyDanger {
	
	private CommReply commReply;
	private User user;
	
	public CommReplyDanger() {}

	public CommReply getCommReply() {
		return commReply;
	}

	public void setCommReply(CommReply commReply) {
		this.commReply = commReply;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "CommReplyDanger [commReply=" + commReply + ", user=" + user + "]";
	}
	
}
