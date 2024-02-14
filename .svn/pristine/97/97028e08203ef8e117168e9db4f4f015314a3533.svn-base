<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"
    pageEncoding="UTF-8"%>
<%
	String nickname = request.getParameter("nickname");

	UserDao userDao = new UserDao();
	User user = userDao.getUserBynickname(nickname);
	if(user==null) {
		out.write("none");
	}else {
		out.write("exist");
	}
%>