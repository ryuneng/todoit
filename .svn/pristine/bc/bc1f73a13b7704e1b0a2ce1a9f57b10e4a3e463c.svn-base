<%@page import="dto.LoginUser"%>
<%@page import="dao.CommunityDao"%>
<%@page import="dao.CommLikeDao"%>
<%@page import="vo.CommLike"%>
<%@page import="vo.Community"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	int no = Integer.valueOf(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("page"));

	// 유저 
	User user = new User();
	user.setNo(loginUser.getNo());
	
	// 커뮤니티
	Community community = new Community();
	community.setNo(no);
	
	// 커뮤니티 좋아요에 유저번호, 커뮤니티번호 담기
	CommLike like = new CommLike();
	like.setUser(user);
	like.setCommunity(community);
	
	// 데이터베이스에 커뮤니티 좋아요 삭제
	CommLikeDao likeDao = new CommLikeDao();
	likeDao.deleteLike(like);
	
	// 좋아요 갯수 업데이트하기
	CommunityDao commDao = new CommunityDao();
	commDao.updateCommLikeByno(community);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>