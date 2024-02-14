<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="dto.LoginUser"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");


	UserDao userDao = new UserDao();

	//사용자 정보조회
	User savedUser = userDao.getUserById(id);


	// 아이디에 해당하는 사용자 정보가 존재하는지 체크
	if (savedUser == null) {
		response.sendRedirect("loginform.jsp?error=fail");
		return;
	
	}
	// 비밀번호 일치하는지 체크
	String shaPassword = DigestUtils.sha256Hex(password);
	if (!savedUser.getPassword().equals(shaPassword)){
		response.sendRedirect("loginform.jsp?error=fail");
		return;
	}

	LoginUser loginUser = new LoginUser();
	loginUser.setNo(savedUser.getNo());
	loginUser.setId(savedUser.getId());
	loginUser.setName(savedUser.getName());
	
	
	
	
	session.setAttribute("LOGIN_USER", loginUser);

	response.sendRedirect("/index.jsp");
	
%>