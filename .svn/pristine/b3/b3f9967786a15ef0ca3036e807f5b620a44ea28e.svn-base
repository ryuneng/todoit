package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.MeetingCategory;

public class MeetingCategoryDao {
	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	@SuppressWarnings("unchecked")
	public List<MeetingCategory> getAllCategories() throws SQLException {
		return (List<MeetingCategory>) ibatis.queryForList("meeting-categories.getAllCategories");
	}
}
