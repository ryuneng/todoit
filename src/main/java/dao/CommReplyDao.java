package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.CommReply;
import vo.CommReplyDanger;
import vo.CommReplyLike;

public class CommReplyDao {

private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	public void insertCommReply(CommReply commreply) throws SQLException {
		ibatis.insert("comm-replies.insertCommReply", commreply);
	}
	
	// 대댓글 추가
	public void insertCommReReply(CommReply rereply) throws SQLException {
		ibatis.insert("comm-replies.insertCommReReply", rereply);
	}
	
	@SuppressWarnings("unchecked")
	public List<CommReply> getRepliesByCommunityNo(int commNo) throws SQLException {
		return (List<CommReply>) ibatis.queryForList("comm-replies.getRepliesByCommunityNo", commNo);
	}
	
	public void deleteCommReply(int replyNo) throws SQLException {
		ibatis.insert("comm-replies.deleteCommReply", replyNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<CommReply> getReReplies(int parentsNo) throws SQLException {
		return (List<CommReply>) ibatis.queryForList("comm-replies.getReReplies", parentsNo);
	}
	
	public void updateCommReply(CommReply commReply) throws SQLException {
		ibatis.update("comm-replies.updateCommReply", commReply);
	}
	
	// 댓글 1개 조회
	public CommReply getReplyByNo(int replyNo) throws SQLException {
		return (CommReply) ibatis.queryForObject("comm-replies.getReplyByNo", replyNo);
	}
	
	/**
	 * 댓글에 대한 댓글신고자 한쌍 조회
	 * @param replyDanger	댓글번호, 사용자번호 정보
	 * @return 댓글번호, 사용자번호 정보
	 * @throws SQLException
	 */
	public CommReplyDanger getReplyDanger(CommReplyDanger replyDanger) throws SQLException {
		return (CommReplyDanger) ibatis.queryForObject("comm-replies.getReplyDanger", replyDanger);
	}
	
	// 해당 댓글에 대한 댓글신고자 추가
	public void addReplyDanger(CommReplyDanger replyDanger) throws SQLException {
		ibatis.insert("comm-replies.addReplyDanger", replyDanger);
	}
	
	// 해당 댓글에 대한 신고수 업데이트
	public void updateReplyDangerCnt(CommReplyDanger replyDanger) throws SQLException {
		ibatis.update("comm-replies.updateReplyDangerCnt", replyDanger);
	}
	
	// 해당 댓글에 대한 좋아요 조회
	public CommReplyLike getReplyLike(CommReplyLike replyLike) throws SQLException {
		return (CommReplyLike) ibatis.queryForObject("comm-replies.getReplyLike", replyLike);
	}
	
	// 해당 댓글에 대해 좋아요 추가
	public void addReplyLike(CommReplyLike replyLike) throws SQLException {
		ibatis.insert("comm-replies.addReplyLike", replyLike);
	}
	
	// 해당 댓글에 대한 좋아요수 조회
	public int getReplyLikeCnt(int replyNo) throws SQLException {
		return (int) ibatis.queryForObject("comm-replies.getReplyLikeCnt", replyNo);
	}
	
}
