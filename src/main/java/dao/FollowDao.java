package dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Follow;

public class FollowDao {
	
	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	// 팔로우 추가
	public void addFollow(Follow follow) throws SQLException {
		ibatis.insert("follow.addFollow", follow);
	}
	
	// 팔로우 취소
	public void deleteFollow(Follow follow) throws SQLException {
		ibatis.delete("follow.deleteFollow", follow);
	}
	
	// 팔로워수 조회
	public int getFollowerCnt(int userNo) throws SQLException {
		return (int) ibatis.queryForObject("follow.getFollowerCnt", userNo);
	}
	
	// 팔로잉수 조회
	public int getFollowingCnt(int userNo) throws SQLException {
		return (int) ibatis.queryForObject("follow.getFollowingCnt", userNo);
	}
	
	// 팔로우 내역 조회
	public Follow getFollow(Follow follow) throws SQLException {
		return (Follow) ibatis.queryForObject("follow.getFollow", follow);
	}
	
}
