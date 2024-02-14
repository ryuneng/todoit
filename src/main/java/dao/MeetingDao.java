package dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Meeting;
import vo.User;

public class MeetingDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	/**
	 * 신규 모임 저장
	 * @param meeting 신규로 저장할 모임 정보
	 * @throws SQLException
	 */
	public void insertMeeting(Meeting meeting) throws SQLException {
		ibatis.insert("meeting.insertMeeting", meeting);
	}
	
	/**
	 * 모임 번호로 해당하는 모임 조회
	 * @param no 조회할 모임 번호
	 * @return 조회된 모임
	 * @throws SQLException
	 */
	public Meeting getMeetingByNo(int no) throws SQLException {
		return (Meeting)ibatis.queryForObject("meeting.getMeetingByNo", no);
	}
	
	/**
	 * 호스트의 유저 번호로 개설한 모임 전체 리스트 조회
	 * @param userNo 호스트의 유저 번호
	 * @return 개설한 모임 리스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Meeting> getMeetingsByUserNo(int userNo) throws SQLException {
		return (List<Meeting>) ibatis.queryForList("meeting.getMeetingsByUserNo", userNo);
	}
	
	/**
	 * 모임 삭제
	 * @param no 삭제할 모임 번호
	 * @throws SQLException
	 */
	public void deleteMeetingByMeetingNo(int no) throws SQLException {
		ibatis.delete("meeting.deleteMeetingByMeetingNo", no);
	}
	
	// 게시글의 전체 행 개수 반환
	public int getTotalRows(Map<String, Object> param) throws SQLException {
		return (Integer) ibatis.queryForObject(("meeting.getTotalRows"), param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Meeting> getRecommendMeetings(String sort, int begin, int end) throws SQLException {
		Map<String, Object> param = new HashMap<>();
		param.put("sort", sort);
		param.put("begin", begin);
		param.put("end", end);
		
		return (List<Meeting>) ibatis.queryForList("meeting.getMeetings", param);
	}
	
	// 게시글 목록 반환
	@SuppressWarnings("unchecked")
	public List<Meeting> getMeetings(Map<String, Object> param) throws SQLException {
		return (List<Meeting>) ibatis.queryForList("meeting.getMeetings", param);
	}
	
	/**
	 * 모임 찜 개수 업데이트
	 * @param meeting 모임 찜 개수를 반영할 모임
	 * @throws SQLException
	 */
	public void updateMeetingWishByNo(Meeting meeting) throws SQLException {
		ibatis.update("meeting.updateMeetingWishByNo", meeting);
	}
	
	// 모임 수정
	/**
	 * 모임 수정
	 * @param meeting 수정할 모임 정보
	 * @throws SQLException
	 */
	public void updateMeetingByNo(Meeting meeting) throws SQLException {
		ibatis.update("meeting.updateMeetingByNo", meeting);
	}
	
	/**
	 * 모임 평점 업데이트
	 * @param meeting 모임 평점을 반영할 모임
	 * @throws SQLException
	 */
	public void updateMeetingScoreByNo(Meeting meeting) throws SQLException {
		ibatis.update("meeting.updateMeetingScoreByNo", meeting);
	}
}
