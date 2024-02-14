package vo;

public class CommLike {
	
	private Community community;
	private User user;
	
	public CommLike() {};
	
	public Community getCommunity() {
		return community;
	}
	public void setCommunity(Community community) {
		this.community = community;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "CommLike [community=" + community + ", user=" + user + "]";
	}

}
