package vo;

public class CommCategory {
	private int no;
	private String name;
	
	public CommCategory() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "CommCategory [no=" + no + ", name=" + name + "]";
	}
	
	
}
