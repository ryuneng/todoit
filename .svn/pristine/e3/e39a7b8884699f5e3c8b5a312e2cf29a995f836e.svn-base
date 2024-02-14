<%@page import="vo.User"%>
<%@page import="vo.Meeting"%>
<%@page import="dto.LoginUser"%>
<%@page import="utils.NumberUtils"%>
<%@page import="dao.MeetingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	User user = new User();
	user.setNo(loginUser.getNo());

	int meetNo = Integer.valueOf(request.getParameter("meetNo"));
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);
	
	MeetingDao meetingDao = new MeetingDao();
	
	Meeting meeting = meetingDao.getMeetingByNo(meetNo);
	
 	if (meeting.getUser().getNo() != loginUser.getNo()){
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&error=deny&page=" + currentPage);
		return;
	}
	
	meetingDao.deleteMeetingByMeetingNo(meetNo);

	response.sendRedirect("list.jsp");


%>