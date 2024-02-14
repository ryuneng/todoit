package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.CommCategory;

public class CommCategoryDao {
	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	@SuppressWarnings("unchecked")
	public List<CommCategory> getAllCategories() throws SQLException {
		return (List<CommCategory>) ibatis.queryForList("comm-categories.getAllCategories");
	}
}
