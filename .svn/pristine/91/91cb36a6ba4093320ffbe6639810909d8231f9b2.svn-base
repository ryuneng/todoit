<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@page import="dao.DailyCheckDao"%>
<%@page import="vo.DailyCheck"%>
<%@page import="utils.NumberUtils"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 로그인된 사용자 정보 조회
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	DailyCheckDao dailyCheckDao = new DailyCheckDao();
	dailyCheckDao.insertDailyCheck(loginUser.getNo());
	
	response.sendRedirect("dailycheck.jsp");
	
	
%>
