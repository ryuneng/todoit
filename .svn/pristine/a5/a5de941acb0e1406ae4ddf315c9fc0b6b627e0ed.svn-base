<%@page import="dao.FollowDao"%>
<%@page import="vo.Follow"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("LOGIN_USER");
	
	int userNo = Integer.valueOf(request.getParameter("userNo"));

	User userOwner = new User();
	User userFollower = new User();
	userOwner.setNo(userNo);
	userFollower.setNo(loginUser.getNo());
	
	Follow follow = new Follow();
	FollowDao followDao = new FollowDao();
	
	follow.setUserOwner(userOwner);
	follow.setUserFollower(userFollower);
	
	followDao.addFollow(follow);
	response.sendRedirect("profile.jsp?userNo=" + userNo);
	
%>