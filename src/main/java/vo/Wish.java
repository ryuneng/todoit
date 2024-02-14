package vo;

public class Wish {

	private Meeting meeting;
	private User user;
	
	public Wish() {}

	public Meeting getMeeting() {
		return meeting;
	}

	public void setMeeting(Meeting meeting) {
		this.meeting = meeting;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Wish [meeting=" + meeting + ", user=" + user + "]";
	}
	
	
	
}
