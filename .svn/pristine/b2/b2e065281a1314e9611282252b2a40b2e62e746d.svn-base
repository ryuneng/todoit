<%@page import="utils.NumberUtils"%>
<%@page import="vo.Meeting"%>
<%@page import="dao.MeetingDao"%>
<%@page import="vo.MeetingReply"%>
<%@page import="vo.User"%>
<%@page import="dao.MeetingReplyDao"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	User user = new User();
	user.setNo(loginUser.getNo());
	
	int meetNo = Integer.valueOf(request.getParameter("meetNo"));
	int replyNo = Integer.valueOf(request.getParameter("replyNo"));
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);

	MeetingReplyDao meetingReplyDao = new MeetingReplyDao();
	MeetingDao meetingDao = new MeetingDao();
	
	// 모임 호스트 조회를 위해서 모임 조회하기
	Meeting meeting = meetingDao.getMeetingByNo(meetNo);
	
	// 삭제할 모임 조회
	MeetingReply meetingReply = meetingReplyDao.getReplyByNo(replyNo);
	
	if (loginUser.getNo() == 100001 || loginUser.getNo() == meeting.getUser().getNo()) {
		// 로그인 유저가 관리자거나 모임 호스트일 경우
		meetingReplyDao.deleteMeetingReply(replyNo);
		response.sendRedirect("detail.jsp?meetNo=" + meetNo);
	} else if (meetingReply.getUser().getNo() == loginUser.getNo()) {
		// 로그인 유저가 댓글 작성자일 경우
		meetingReplyDao.deleteMeetingReply(replyNo);
		response.sendRedirect("detail.jsp?meetNo=" + meetNo);
	} else {
		// 본인 댓글 외 삭제 불가
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage + "&error=denyReply");
	}
	
	
%>