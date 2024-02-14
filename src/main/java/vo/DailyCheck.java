package vo;

public class DailyCheck {

	private String dailycheck;
	private int no;

	public DailyCheck() {}

	public String getDailycheck() {
		return dailycheck;
	}

	public void setDailycheck(String dailycheck) {
		this.dailycheck = dailycheck;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	@Override
	public String toString() {
		return "Dailycheck [dailycheck=" + dailycheck + ", no=" + no + "]";
	}

}
