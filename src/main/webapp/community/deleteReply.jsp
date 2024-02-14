<%@page import="dao.CommReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER"); // 로그인 유저

	int replyNo = Integer.parseInt(request.getParameter("replyNo"));	
	int no = Integer.parseInt(request.getParameter("no"));	
	int pageNo = Integer.parseInt(request.getParameter("page"));	
	
	/* 	
	저장된 댓글 조회하기
	댓글 작성자와 로그인한 유저 번호가 다르면 해당 커뮤니티 글상세로 이동
	if (댓글.getUser().getNo() != loginUser.getNo()) {
		response.sendRedirect("detail.jsp?no=" + commNo);
		return;
	} 
	*/
	
	CommReplyDao replyDao = new CommReplyDao();
	replyDao.deleteCommReply(replyNo);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>