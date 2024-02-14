package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import dto.ApplyManagementDto;
import dto.MeetingNoticeDto;
import dto.MeetingStatusDto;
import dto.ReplyManagementDto;
import ibatis.IbatisUtil;
import vo.Meeting;

public class HostDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	/**
	 * 모임관리 현황
	 * @param userNo
	 * @return 
	 * @throws SQLException
	 */
	public MeetingStatusDto getMeetingStatus(int userNo) throws SQLException {
		return (MeetingStatusDto)ibatis.queryForObject("host.getHostStatus", userNo);
	}
	
	/**
	 * 모임관리 현황 상세
	 * @param userNo
	 * @return 
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Meeting> getHostStatusDetail(int userNo) throws SQLException {
		return (List<Meeting>) ibatis.queryForList("host.getHostStatusDetail", userNo);
	}
	
	/**
	 * 전체 알림
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingNoticeDto> getAllNotices(int userNo)throws SQLException {
		return  (List<MeetingNoticeDto>)ibatis.queryForList("host.getAllNotices", userNo);
	}
	
	/**
	 * 신청 알림
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingNoticeDto> getApplyNotices(int userNo)throws SQLException {
		return  (List<MeetingNoticeDto>)ibatis.queryForList("host.getApplyNotices", userNo);
	}
	
	/**
	 * 댓글 알림 
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingNoticeDto> getReplyNotices(int userNo)throws SQLException {
		return  (List<MeetingNoticeDto>)ibatis.queryForList("host.getReplyNotices", userNo);
	}
	
	
	/**
	 * 호스트 모임 달력 
	 * @param userNo
	 * @return 
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Meeting> getHostCalendar(int userNo) throws SQLException {
		return (List<Meeting>) ibatis.queryForList("host.getHostCalendar", userNo);
	}
	
	
	/**
	 * 모임관리 참여자
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplyManagementDto> getHostApplies(Map<String, Object> param)throws SQLException {
		return  (List<ApplyManagementDto>)ibatis.queryForList("host.getHostApplies", param);
	}
	
	/**
	 * 모임관리 댓글
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ReplyManagementDto> getHostReplies(Map<String, Object> param)throws SQLException {
		return  (List<ReplyManagementDto>)ibatis.queryForList("host.getHostReplies", param);
	}
	

}
