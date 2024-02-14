<%@page import="vo.Community"%>
<%@page import="dao.CommReplyDao"%>
<%@page import="vo.CommReply"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	/* if (loginUser == null) {
		response.sendRedirect("loginform.jsp?error=deny");
		return;
	} */
	
	int no = Integer.parseInt(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("page"));
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));
	String content = request.getParameter("content");
	
	// 댓글 작성자 정보
	User user = new User();
	// user.setNo(loginUser.getNo());
	user.setNo(loginUser.getNo());
	
	Community community = new Community();
	community.setNo(no);
	
	CommReply commReply = new CommReply();
	commReply.setContent(content);
	commReply.setCommunity(community);
	commReply.setUser(user);
	commReply.setParentsReply(replyNo);
	
	CommReplyDao replyDao = new CommReplyDao();
	replyDao.insertCommReReply(commReply);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>