<%@page import="utils.NumberUtils"%>
<%@page import="vo.MeetingReply"%>
<%@page import="vo.MeetingReplyLike"%>
<%@page import="dao.MeetingReplyDao"%>
<%@page import="dto.LoginUser"%>
<%@page import="vo.Meeting"%>
<%@page import="vo.User"%>
<%@page import="dao.WishDao"%>
<%@page import="dao.MeetingDao"%>
<%@page import="vo.Wish"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	// 요청파라미터값 조회
	int meetNo = Integer.valueOf(request.getParameter("meetNo"));
	int replyNo = Integer.valueOf(request.getParameter("replyNo"));
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);

	User user = new User();
	user.setNo(loginUser.getNo());

	MeetingReplyDao meetingReplyDao = new MeetingReplyDao();

	// 좋아요 적용할 댓글 획득
	MeetingReply meetingReply = meetingReplyDao.getReplyByNo(replyNo);
	
	// 댓글 좋아요 객체 생성
	MeetingReplyLike meetingReplyLike = new MeetingReplyLike();
	
	meetingReplyLike.setMeetingReply(meetingReply);
	meetingReplyLike.setUser(user);

	// 좋아요 반영시킬 해당 댓글, 유저로 내역 존재하는지 조회
	MeetingReplyLike savedReplyLike = meetingReplyDao.getLike(meetingReplyLike);
	if (savedReplyLike != null) {
		// 좋아요 내역 있으면 딜리트
		meetingReplyDao.deleteReplyLike(meetingReplyLike);
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage+ "&replyNo=" + replyNo);
	} else {
		// 좋아요 내역 없으면 추가
		meetingReplyDao.addReplyLike(meetingReplyLike);
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage + "&replyNo=" + replyNo);
	}
	
	
%>