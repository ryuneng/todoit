package dto;

import java.util.Date;

public class MeetingNoticeDto {
	private int no;
	private String imageName;
	private String title;
	private Date day;
	private String alertType;
	private String nickname;
	
	public MeetingNoticeDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getDay() {
		return day;
	}

	public void setDay(Date day) {
		this.day = day;
	}

	public String getAlertType() {
		return alertType;
	}

	public void setAlertType(String alertType) {
		this.alertType = alertType;
	}

	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	@Override
	public String toString() {
		return "MeetingNoticeDto [no=" + no + ", imageName=" + imageName + ", title=" + title + ", day=" + day
				+ ", alertType=" + alertType + "]";
	}

}

/*
<select id="gethostnotice" parameterClass="int" resultClass="dto.MeetingNoticeDto">
select 
	m.meeting_no 			as no,
	m.image_name 			as imageName, 
	m.meeting_title 		as title, 
	a.apply_applied_date 	as day, 
	'APPLY' 				as alertType
from meeting m, apply_users a
where m.user_no = 100001
and meeting_approve = 'N'
and m.meeting_no = a.meeting_no
union
select
	m.meeting_no,
	m.image_name,
	m.meeting_title,
	mr.meeting_reply_created_date, 
	'REPLY'
from meeting m, meeting_replies mr
where m.user_no = 100001
and meeting_approve = 'N'
and m.meeting_no = mr.meeting_no
</select>
*/