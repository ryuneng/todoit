<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="dto.LoginUser"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session 에서 loginuser 정보조회
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	// userId에다가 로그인유저 아이디 조회
	String userId = loginUser.getId();

	// userdao 객체생성
	UserDao userdao = new UserDao();

	// userDao객체에 userId정보를 기입해서 savedUser에 조회
	User savedUser = userdao.getUserById(userId);

	/*
	요청URL
		localhost/comn/delete.jsp
	요청파라미터(요청메세지의 바디부)
		id=xxx&password=xxx&name=xxx&email=xxx&tel=xxx
	*/

		String id = request.getParameter("id");
		String password = request.getParameter("password");

		UserDao userDao = new UserDao();

		int userNo = savedUser.getNo();

		// password가 null 경우 deleteform으로 리턴
		if(password == null) {
			response.sendRedirect("deleteform.jsp?error=fail");
			return;
		}

		// savedUser에 담겨있는 비밀번호와 입력받은 비밀번호가 일치하는지 검색
		String shapassword = DigestUtils.sha256Hex(password);
		if (!savedUser.getPassword().equals(shapassword)) {
			response.sendRedirect("deleteform.jsp?error=fail");
			return;
		}

		// 유저정보삭제
		userDao.deleteUserByNo(userNo);


		// 메인페이지를 재요청
		response.sendRedirect("/user/logout.jsp");








%>