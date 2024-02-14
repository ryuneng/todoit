package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import dto.MeetingDto;
import ibatis.IbatisUtil;
import vo.Banner;
import vo.Meeting;

public class MainDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	/**
	 * 
	 * @return 배너이미지
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Banner> getBanners() throws SQLException {
		return (List<Banner>) ibatis.queryForList("main.getBanners");
		
	}
	
	/**
	 * 
	 * @return 베스트 모임
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getWeeklyBest(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getWeeklyBest", param);
		
	}
	
	/**
	 * 
	 * @return 스터디/자기계발 베스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getStudyCat(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getStudyCat", param);
		
	}
	
	/**
	 * 
	 * @return 문화예술 베스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getArtCat(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getArtCat", param);
		
	}
	
	/**
	 * 
	 * @return 운동/액티비티 베스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getExerciseCat(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getArtCat", param);
	}
	
	/**
	 * 
	 * @return 취미 베스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getHobbyCat(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getHobbyCat", param);
			
	}
	
	/**
	 * 
	 * @return 푸드 베스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingDto> getFoodCat(Map<String, Object> param) throws SQLException {
		return (List<MeetingDto>) ibatis.queryForList("main.getHobbyCat", param);
			
	}
	
	
}
