package vo;

import java.util.Date;

public class Notice {

	private int no;
	private String title;
	private String content;
	private Date createDate;
	private int view_cnt;
	
	public Notice() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}

	@Override
	public String toString() {
		return "Notice [no=" + no + ", title=" + title + ", content=" + content + ", createDate=" + createDate
				+ ", view_cnt=" + view_cnt + "]";
	}

	
}


