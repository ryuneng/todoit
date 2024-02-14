package dto;

import java.util.Date;

public class ReplyManagementDto {

	private int no;
	private String filename;
	private String nickname;
	private String content;
	private Date createdDate;
	private Date updatedDate;
	
	public ReplyManagementDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	@Override
	public String toString() {
		return "ReplyManagementDto [no=" + no + ", filename=" + filename + ", nickname=" + nickname + ", content="
				+ content + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + "]";
	}
	
}
