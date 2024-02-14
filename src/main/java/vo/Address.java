package vo;

public class Address {

	private int no;
	private String city_name;
	private String gu_name;
	private int address_no2;
	
	public Address () {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}

	public String getGu_name() {
		return gu_name;
	}

	public void setGu_name(String gu_name) {
		this.gu_name = gu_name;
	}

	public int getAddress_no2() {
		return address_no2;
	}

	public void setAddress_no2(int address_no2) {
		this.address_no2 = address_no2;
	}

	@Override
	public String toString() {
		return "Address [no=" + no + ", city_name=" + city_name + ", gu_name=" + gu_name + ", address_no2="
				+ address_no2 + "]";
	}
	
	
}
