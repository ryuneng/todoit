<%@page import="dao.MeetingDao"%>
<%@page import="dao.WishDao"%>
<%@page import="vo.Wish"%>
<%@page import="vo.Meeting"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));

	User user = new User();
	user.setNo(loginUser.getNo());

	Meeting meeting = new Meeting();
	meeting.setNo(meetingNo);
	
	Wish wish = new Wish();
	wish.setUser(user);
	wish.setMeeting(meeting);

	WishDao wishDao = new WishDao();
	
	Wish savedWish = wishDao.getWish(wish);
	if (savedWish == null) {
		wishDao.addWish(wish);
		
	} else {
		wishDao.deleteWish(wish);
	}
	
	MeetingDao meetingDao = new MeetingDao();
	meetingDao.updateMeetingWishByNo(meeting);


	response.sendRedirect("/index.jsp");
%>