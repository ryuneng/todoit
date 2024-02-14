package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.PointHistory;

public class PointDao {
	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	/**
	 * 참여번호로 포인트 히스토리 생성에 필요한 orderNo 조회
	 * @param applyNo 참여번호
	 * @return 해당 참여번호에 맞는 결제 주문번호
	 * @throws SQLException
	 */
	public int getOrderNoByApplyNo(int applyNo) throws SQLException {
		return (int) ibatis.queryForObject("points.getOrderNoByApplyNo", applyNo);
	}
	
	/**
	 * 포인트 히스토리 생성
	 * @param pointHistory 포인트 히스토리 정보
	 * @throws SQLException
	 */
	public void insertPointsHistory(PointHistory pointHistory) throws SQLException {
		ibatis.insert("points.insertPointsHistory", pointHistory);
	}
	
	public PointHistory getPointHistoryByUserNo(int userNo) throws SQLException {
		return (PointHistory)ibatis.queryForObject("");
	}
	
	/**
	 * 유저번호로 유저 보유포인트 조회
	 * @param userNo 유저번호
	 * @return 해당 유저의 보유포인트
	 * @throws SQLException
	 */
	// * 메소드 타입 = payments.xml의 resultClass 타입
	// * userNo 타입 = payments.xml의 parameterClass 타입
	public int getPointByUserNo(int userNo) throws SQLException {
		return (int) ibatis.queryForObject("points.getPointByUserNo", userNo);
	}
	
	/**
	 * 유저번호로 해당 유저의 포인트 히스토리 전체조회
	 * @param userNo 유저 번호
	 * @return 해당 유저의 포인트 히스토리
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<PointHistory> getPointsHistory(int userNo) throws SQLException {
		return (List<PointHistory>) ibatis.queryForList("points.getPointsHistory", userNo);
	}

}
