package dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.ApplyUser;
import vo.Wish;

public class ApplyUserDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();

	/**
	 * 모임번호, 유저번호로 이미 신청한 모임인지 조회
	 * @param applyuser 검색할 모임번호, 유저번호가 담긴 ApplyUser 객체
	 * @return 신청 내역
	 * @throws SQLException
	 */
	public ApplyUser getApplyByApplyUser(ApplyUser applyuser) throws SQLException {
		return (ApplyUser) ibatis.queryForObject("apply-users.getApplyByApplyUser", applyuser);
	}
	
	/**
	 * 신청 승인 
	 * @param no 신청 번호 
	 * @throws SQLException
	 */
	public void acceptApplies(int applyNo) throws SQLException {
		ibatis.update("apply-users.acceptApplies", applyNo);
	}
	
	/**
	 * 신청 거절 
	 * @param no 신청번호 
	 * @throws SQLException
	 */
	public void rejectApplies(int applyNo) throws SQLException {
		ibatis.update("apply-users.rejectApplies", applyNo);
	}
	
	
}