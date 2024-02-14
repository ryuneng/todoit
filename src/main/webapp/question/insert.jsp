<%@page import="vo.User"%>
<%@page import="dao.QuestionDao"%>
<%@page import="vo.Question"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Question question = new Question();
	
	question.setTitle(title);
	question.setContent(content);	
	
	QuestionDao questionDao = new QuestionDao();	
	questionDao.insertquestion(question);
	
	response.sendRedirect("list.jsp");
%>