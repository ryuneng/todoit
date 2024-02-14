<%@page import="vo.User"%>
<%@page import="vo.Community"%>
<%@page import="vo.CommReply"%>
<%@page import="dao.CommReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("page"));
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));
	String content = request.getParameter("content");
	
	// 저장되어 있는 댓글 조회
	CommReplyDao replyDao = new CommReplyDao();
	CommReply savedReply = replyDao.getReplyByNo(replyNo);
		
	savedReply.setContent(content);
	
	replyDao.updateCommReply(savedReply);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>