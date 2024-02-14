<%@page import="dao.CommLikeDao"%>
<%@page import="vo.CommLike"%>
<%@page import="dao.CommunityDao"%>
<%@page import="vo.Community"%>
<%@page import="dto.LoginUser"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	int no = Integer.parseInt(request.getParameter("no"));
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
	
	// 로그인된 유저가 이 커뮤니티 글에 대한 좋아요가 있는지 조회
	CommLikeDao likeDao = new CommLikeDao();
	CommLike savedLike = likeDao.getLike(like);
		
	CommunityDao commDao = new CommunityDao();
	
	// 조회된 좋아요 여부에 따라 좋아요가 없으면 저장 있으면 삭제
	if (savedLike == null) {
		// 데이터베이스에 커뮤니티 좋아요 저장
		likeDao.addLike(like);
		response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo + "&success=likeSuccess");
		
	} else if (savedLike.getUser().getNo() == user.getNo()) {
		// 데이터베이스에 커뮤니티 좋아요 삭제
		likeDao.deleteLike(like);
		response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo + "&success=deleteLike");
	} 
		
	// 좋아요 갯수 업데이트하기
	commDao.updateCommLikeByno(community);

%>