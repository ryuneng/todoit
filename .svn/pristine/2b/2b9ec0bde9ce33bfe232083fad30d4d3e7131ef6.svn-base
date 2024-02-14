package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.DailyCheck;

public class DailyCheckDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	//신규 출석체크를 저장한다.
	public void insertDailyCheck(int userNo) throws SQLException{
		ibatis.insert("dailycheck.insertDailycheck", userNo);
		
	}
	
	//지정된 사용자번호로 오늘 출석체크 정보가 있는지 조회해서 반환한다.
	public DailyCheck getDailycheckByUserNo(int userNo) throws SQLException {
		return (DailyCheck) ibatis.queryForObject("dailycheck.getDailycheckByUserNo", userNo);
	}
	
	//지정된 사용자번호로 이번 달 출석체크 정보가 있는지 조회해서 전부 반환한다.
	@SuppressWarnings("unchecked")
	public List<DailyCheck> getDailychecks(int userNo) throws SQLException {
		return (List<DailyCheck>) ibatis.queryForList("dailycheck.getDailychecks", userNo);
	}
	
}
 