package dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Notice;

public class NoticeDao {

	private SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	public void insertnotice(Notice notice) throws SQLException {
		ibatis.insert("notice.insertNotice", notice);
	}
	// 공지사항 항목을 조회한다.
	@SuppressWarnings("unchecked")
	public List<Notice> getNotices() throws SQLException{
		return (List<Notice>) ibatis.queryForList("notice.getNotices");
	}	
	// 공지사항 목록 상세 조회
	public Notice getNoticeByNo(int no) throws SQLException {
		return (Notice) ibatis.queryForObject("notice.getNoticeByNo", no);
	}
	// 공지사항 조회수를 증가
	public void updateNotice(Notice notice) throws SQLException {
		ibatis.update("notice.updateNotice", notice);
	}
	
	

}
