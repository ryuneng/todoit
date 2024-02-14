package vo;

public class Follow {
	
	private User userOwner;
	private User userFollower;
	
	public Follow() {}

	public User getUserOwner() {
		return userOwner;
	}

	public void setUserOwner(User userOwner) {
		this.userOwner = userOwner;
	}

	public User getUserFollower() {
		return userFollower;
	}

	public void setUserFollower(User userFollower) {
		this.userFollower = userFollower;
	}

	@Override
	public String toString() {
		return "Follow [userOwner=" + userOwner + ", userFollower=" + userFollower + "]";
	}
		
}
