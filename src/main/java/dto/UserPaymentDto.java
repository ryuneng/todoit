package dto;

import java.util.Date;

public class UserPaymentDto {

	// 결제정보
	private int orderNo;		 // 주문번호
	private int price;			 // 결제금액
	private String method;		 // 결제수단
	private Date payDate;		 // 결제일자
	private int usedPoint;		 // 사용포인트
	private String payCompleted; // 결제완료여부
	
	// 모임정보
	private int meetNo;			 // 모임번호
	private String Title;		 // 모임제목
	private String imageName;	 // 모임 이미지 파일명
	
	public UserPaymentDto() {}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public int getUsedPoint() {
		return usedPoint;
	}

	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}

	public String getPayCompleted() {
		return payCompleted;
	}

	public void setPayCompleted(String payCompleted) {
		this.payCompleted = payCompleted;
	}

	public int getMeetNo() {
		return meetNo;
	}

	public void setMeetNo(int meetNo) {
		this.meetNo = meetNo;
	}

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	@Override
	public String toString() {
		return "UserPaymentDto [orderNo=" + orderNo + ", price=" + price + ", method=" + method + ", payDate=" + payDate
				+ ", usedPoint=" + usedPoint + ", payCompleted=" + payCompleted + ", meetNo=" + meetNo + ", Title="
				+ Title + ", imageName=" + imageName + "]";
	}
	
}
