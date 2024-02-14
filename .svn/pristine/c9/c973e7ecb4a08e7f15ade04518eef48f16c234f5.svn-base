package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.CommReply;
import vo.MeetReplyDanger;
import vo.MeetingReply;
import vo.MeetingReplyLike;

public class MeetingReplyDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();

	/**
	 * 모임 신규 댓글 저장
	 * @param meetingReply 저장할 댓글
	 * @throws SQLException
	 */
	public void insertMeetingReply(MeetingReply meetingReply) throws SQLException {
		ibatis.insert("meeting-replies.insertMeetingReply", meetingReply);
	}
	
	/**
	 * 모임 신규 대댓글 저장
	 * @param meetingReply 저장할 대댓글
	 * @throws SQLException
	 */
	public void insertMeetingReReply(MeetingReply meetingReply) throws SQLException {
		ibatis.insert("meeting-replies.insertMeetingReReply", meetingReply);
	}
	
	/**
	 * 해당 모임에 대한 전체 모임 댓글 조회(부모댓글만 조회)
	 * @param no 모임 번호
	 * @return 댓글 리스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingReply> getMeetingReplies(int no) throws SQLException {
		return (List<MeetingReply>) ibatis.queryForList("meeting-replies.getMeetingReplies", no);
	}
	
	/**
	 * 해당 댓글에 대한 전체 대댓글 조회
	 * @param no 댓글 번호
	 * @return 대댓글 리스트
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<MeetingReply> getReReplies(int no) throws SQLException {
		return (List<MeetingReply>) ibatis.queryForList("meeting-replies.getReReplies", no);
	}
	
	/**
	 * 댓글 삭제
	 * @param no 삭제할 댓글 번호
	 * @throws SQLException
	 */
	public void deleteMeetingReply(int no) throws SQLException {
		ibatis.update("meeting-replies.deleteMeetingReply", no);
	}
	
	/**
	 * 댓글 수정
	 * @param meetingReply 수정할 댓글 정보
	 * @throws SQLException
	 */
	public void updateMeetingByNo(MeetingReply meetingReply) throws SQLException {
		ibatis.update("meeting-replies.updateMeetingByNo", meetingReply);
	}
	
	/**
	 * 번호에 해당하는 댓글 1개 조회
	 * @param no 조회할 댓글 번호
	 * @return 조회된 댓글 정보
	 * @throws SQLException
	 */
	public MeetingReply getReplyByNo(int no) throws SQLException {
		return (MeetingReply) ibatis.queryForObject("meeting-replies.getReplyByNo", no);
	}
	
	/**
	 * 신고된 댓글 번호, 신고한 유저 번호로 댓글 신고 내역 저장
	 * @param meetReplyDanger 신고 내역에 추가될 댓글, 유저 정보
	 * @throws SQLException
	 */
	public void addMeetReplyDangerCnt(MeetReplyDanger meetReplyDanger) throws SQLException {
		ibatis.insert("meeting-replies.addMeetReplyDangerCnt", meetReplyDanger);
	}

	/**
	 * 댓글에 신고 횟수 업데이트
	 * @param meetingReply 신고 횟수 업데이트할 댓글
	 * @throws SQLException
	 */
	public void updateDangerCnt(MeetingReply meetingReply) throws SQLException {
		ibatis.update("meeting-replies.updateDangerCnt", meetingReply);
	}
	
	/**
	 * 해당 댓글에 신고 내역이 있는지 조회
	 * @param meetReplyDanger 조회할 댓글과 유저 정보
	 * @return 댓글 신고 내역
	 * @throws SQLException
	 */
	public MeetReplyDanger getMeetReplyDanger(MeetReplyDanger meetReplyDanger) throws SQLException {
		return (MeetReplyDanger) ibatis.queryForObject("meeting-replies.getMeetReplyDanger", meetReplyDanger);
	}
	
	/**
	 * 댓글 좋아요 추가
	 * @param meetReplyLike 좋아요 추가할 댓글 및 유저 정보
	 * @throws SQLException
	 */
	public void addReplyLike(MeetingReplyLike meetingReplyLike) throws SQLException {
		ibatis.insert("meet-reply-like.addReplyLike", meetingReplyLike);
	}
	
	/**
	 * 댓글 좋아요 삭제
	 * @param meetReplyLike 좋아요 삭제할 댓글 및 유저 정보
	 * @throws SQLException
	 */
	public void deleteReplyLike(MeetingReplyLike meetingReplyLike) throws SQLException {
		ibatis.delete("meet-reply-like.deleteReplyLike", meetingReplyLike);
	}
	
	/**
	 * 해당 댓글번호와 유저번호로 저장된 좋아요 정보 조회
	 * @param meetReplyLike 조회할 댓글 번호 및 유저 정보
	 * @return 조호된 댓글 좋아요 정보
	 * @throws SQLException
	 */
	public MeetingReplyLike getLike(MeetingReplyLike meetingReplyLike) throws SQLException {
		return (MeetingReplyLike) ibatis.queryForObject("meet-reply-like.getLike", meetingReplyLike);
	}
	
	/**
	 * 댓글 좋아요 개수 조회
	 * @param replyNo 좋아요 개수 조회할 댓글번호
	 * @return 좋아요 개수
	 * @throws SQLException
	 */
	public int getLikes(int replyNo) throws SQLException {
		return (int) ibatis.queryForObject("meet-reply-like.getLikes", replyNo);
	}
	
}
