package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Address;

public class AddressDao {
	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	@SuppressWarnings("unchecked")
	public List<Address> getAddressByCityName() throws SQLException {
		return (List<Address>) ibatis.queryForList("address.getAddressByCityName");
	}
	
	@SuppressWarnings("unchecked")
	public List<Address> getAddressByguName(int address_no2) throws SQLException {
		return (List<Address>) ibatis.queryForList("address.getAddressByguName", address_no2);
	}
	
}



