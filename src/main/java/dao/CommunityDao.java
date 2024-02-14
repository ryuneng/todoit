package dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Community;
import vo.Meeting;

public class CommunityDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	public void insertCommunity(Community community) throws SQLException {
		ibatis.insert("community.insertCommunity", community);
	}
	
	// 모임번호, 사용자번호로 커뮤니티 한 개 조회
	public Community getCommunity(Community community) throws SQLException {
		return (Community) ibatis.queryForObject("community.getCommunity", community);
	}
	
	@SuppressWarnings("unchecked")
	public List<Meeting> getAllMeetingsByUserNo(int userNo) throws SQLException {
		return (List<Meeting>) ibatis.queryForList("community.getAllMeetingsByUserNo", userNo);
	}
	
	public Community getCommunityByNo(int commNo) throws SQLException {
		return (Community) ibatis.queryForObject("community.getCommunityByNo", commNo);
	}
	
	public void updateCommunity(Community community) throws SQLException {
		ibatis.update("community.updateCommunity", community);
	}
	
	// 게시글 목록 반환
	@SuppressWarnings("unchecked")
	public List<Community> getCommunities(Map<String, Object> param) throws SQLException {
		return (List<Community>) ibatis.queryForList("community.getCommunities", param);
	}
	
	// 게시글 추천 목록 반환
	@SuppressWarnings("unchecked")
	public List<Community> getRecommendCommunities(String sort, int begin, int end) throws SQLException {
		Map<String, Object> param = new HashMap<>();
		param.put("sort", sort);
		param.put("begin", begin);
		param.put("end", end);
		return (List<Community>) ibatis.queryForList("community.getCommunities", param);
	}
	
	// 게시글의 전체 행 개수 반환
	public int getTotalRows(Map<String, Object> param) throws SQLException {
		return (Integer) ibatis.queryForObject(("community.getTotalRows"), param);
	}
	
	public void updateCommLikeByno (Community community) throws SQLException {
		ibatis.update("community.updateCommLikeByno", community);
	}
	
	// user 번호로 작성한 커뮤니티 목록 가져오기
	@SuppressWarnings("unchecked")
	public List<Community> getCommunitiesByUserNo (int no) throws SQLException {
		return (List<Community>) ibatis.queryForList("community.getCommunitiesByUserNo", no);
	}
}
