package vo;

import java.util.Date;

public class Community {

	private int no;
	private String title;
	private String content;
	private int viewCnt;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private CommCategory category;
	private Meeting meeting;
	private User user;
	private int likeCnt;
	private int score;
	private String imageName;

	public Community() {}

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

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

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

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public CommCategory getCategory() {
		return category;
	}

	public void setCategory(CommCategory category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Community [no=" + no + ", title=" + title + ", content=" + content + ", viewCnt=" + viewCnt
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", deleted=" + deleted
				+ ", category=" + category + ", meeting=" + meeting + ", user=" + user + ", likeCnt=" + likeCnt
				+ ", score=" + score + ", imageName=" + imageName + "]";
	}

}
