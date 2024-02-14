package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import ibatis.IbatisUtil;
import vo.Question;

public class QuestionDao {
	public SqlMapClient ibatis = IbatisUtil.getSqlMapClient();
	
	public void insertquestion(Question question) throws SQLException {
		ibatis.insert("question.insertQuestion", question);
	}
	
	public int getTotalRows(Map<String, Object>param) throws SQLException{
		return (Integer) ibatis.queryForObject("question.getTotalRows", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Question>getQuestion() throws SQLException {
		return (List<Question>) ibatis.queryForList("question.getQuestion");
		
	}
	
	public Question getQuestionByNo(int no) throws SQLException{
		return (Question) ibatis.queryForObject("question.getQuestionByNo", no);
		
	}
	@SuppressWarnings("unchecked")
	public List<Question> getAllQuestion() throws SQLException {
		return (List<Question>) ibatis.queryForList("question.getAllQuestion");
		
	}

}
