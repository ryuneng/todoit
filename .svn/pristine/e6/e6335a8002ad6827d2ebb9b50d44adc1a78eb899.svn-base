package dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Wish;

public class WishDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();

	public Wish getWish(Wish wish) throws SQLException {
		return (Wish) ibatis.queryForObject("wishes.getWish", wish);
	}
	
	public void addWish(Wish wish) throws SQLException {
		ibatis.insert("wishes.addWish", wish);
	}
	
	public void deleteWish(Wish wish) throws SQLException {
		ibatis.delete("wishes.deleteWish", wish);
	}
}
