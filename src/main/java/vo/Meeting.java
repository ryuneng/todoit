package vo;

import java.sql.SQLException;
import java.util.Date;

public class Meeting {

	private int no;
	private String title;
	private int maxPeople;
	private int actualPeople;
	private String address;
	private int price;
	private int discountPrice;
	private Date startDate;
	private Date endDate;
	private String content;
	private int viewCnt;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private String approve;
	private MeetingCategory category;	// 카테고리 객체
	private User user;			// 유저 객체
	private String imageName;
	private int wishCnt;
	private double scoreAverage;
	private String full;
	private double latitude;
	private double longitude;
	private int totalPayPrice; // 참가자 총 결제금액
	
	public Meeting() {}
	
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
	public int getMaxPeople() {
		return maxPeople;
	}
	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}
	public int getActualPeople() {
		return actualPeople;
	}
	public void setActualPeople(int actualPeople) {
		this.actualPeople = actualPeople;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscountPrice() {
		return discountPrice;
	}
	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	public String getApprove() {
		return approve;
	}
	public void setApprove(String approve) {
		this.approve = approve;
	}
	public MeetingCategory getCategory() {
		return category;
	}
	public void setCategory(MeetingCategory category) {
		this.category = category;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public int getWishCnt() {
		return wishCnt;
	}
	public void setWishCnt(int wishCnt) {
		this.wishCnt = wishCnt;
	}
	public double getScoreAverage() {
		return scoreAverage;
	}
	public void setScoreAverage(double scoreAverage) {
		this.scoreAverage = scoreAverage;
	}
	public String getFull() {
		return full;
	}
	public void setFull(String full) {
		this.full = full;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getTotalPayPrice() {
		return totalPayPrice;
	}

	public void setTotalPayPrice(int totalPayPrice) {
		this.totalPayPrice = totalPayPrice;
	}

	@Override
	public String toString() {
		return "Meeting [no=" + no + ", title=" + title + ", maxPeople=" + maxPeople + ", actualPeople=" + actualPeople
				+ ", address=" + address + ", price=" + price + ", discountPrice=" + discountPrice + ", startDate="
				+ startDate + ", endDate=" + endDate + ", content=" + content + ", viewCnt=" + viewCnt + ", deleted="
				+ deleted + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", approve=" + approve
				+ ", category=" + category + ", user=" + user + ", imageName=" + imageName + ", wishCnt=" + wishCnt
				+ ", scoreAverage=" + scoreAverage + ", full=" + full + ", latitude=" + latitude + ", longitude="
				+ longitude + ", totalPayPrice=" + totalPayPrice + "]";
	}
	
	public String getStatus() throws SQLException {
        Date currentDate = new Date();

        if (currentDate.after(startDate) && currentDate.before(endDate)) {
        	return "진행중";
        } else {
            return "마감";
        }
	}
}
