<%@page import="java.util.Date"%>
<%@page import="javax.naming.NoInitialContextException"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
 <%
 	String title=request.getParameter("title");
 	String content=request.getParameter("content");
 	
 	
 	Notice notice = new Notice();
 	
 	notice.setTitle(title);
 	notice.setContent(content);
 	
 	
 	NoticeDao noticeDao = new NoticeDao();
 	noticeDao.insertnotice(notice);
 	
 	response.sendRedirect("list.jsp");
 	

  %>