<%@page import="vo.MeetReplyDanger"%>
<%@page import="dao.MeetingReplyDao"%>
<%@page import="vo.MeetingReply"%>
<%@page import="vo.User"%>
<%@page import="utils.NumberUtils"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	int meetNo = NumberUtils.toInt(request.getParameter("meetNo"));
	int replyNo = NumberUtils.toInt(request.getParameter("replyNo"));
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);
	
	User user = new User();
	user.setNo(loginUser.getNo());
	
	MeetingReply savedReply = new MeetingReply();
	MeetingReplyDao meetingReplyDao = new MeetingReplyDao();
	
	// 댓글 번호로 신고될 댓글 저장
	savedReply = meetingReplyDao.getReplyByNo(replyNo);
	
	// 신고될 댓글과 신고한 유저 저장
	MeetReplyDanger meetReplyDanger = new MeetReplyDanger();
	meetReplyDanger.setMeetingReply(savedReply);
	meetReplyDanger.setUser(user);
	
	// 신고된 내역이 있는지 조회
	MeetReplyDanger existDangerReply = meetingReplyDao.getMeetReplyDanger(meetReplyDanger);
	
	if (existDangerReply != null) {
		// 댓글 작성자가 로그인한 유저일 경우 댓글 신고 불가
		// 응답메세지로 에러메세지 같이 보내기
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage + "&error=dangerFail");
	} else {
		// 신고내역이 없을 경우 신고 내역 추가
		meetingReplyDao.addMeetReplyDangerCnt(meetReplyDanger);
		// 댓글에 dangerCount 업데이트
		meetingReplyDao.updateDangerCnt(savedReply);
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage + "&error=dangerSuccess");
	}
	
%>