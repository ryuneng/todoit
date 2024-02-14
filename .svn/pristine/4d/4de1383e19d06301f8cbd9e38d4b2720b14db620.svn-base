package dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.CommLike;

public class CommLikeDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();

	public CommLike getLike(CommLike commLike) throws SQLException {
		return (CommLike) ibatis.queryForObject("comm-likes.getLike", commLike);
	}
	
	public void addLike(CommLike commLike) throws SQLException {
		ibatis.insert("comm-likes.addLike", commLike);
	}
	
	public void deleteLike(CommLike commLike) throws SQLException {
		ibatis.delete("comm-likes.deleteLike", commLike);
	}
	
}
