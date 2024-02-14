<%@page import="vo.Community"%>
<%@page import="dao.CommunityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER"); // 로그인 유저
	
	int no = Integer.parseInt(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("page"));
	
	CommunityDao commDao = new CommunityDao();
	Community savedCommunity = commDao.getCommunityByNo(no);
	
/* 	
	커뮤니티 작성자와 로그인한 유저 번호가 다르면 해당 커뮤니티 글상세로 이동
	if (savedCommunity.getUser().getNo() != loginUser.getNo()) {
		response.sendRedirect("detail.jsp?commNo=" + commNo);
		return;
	} 
*/

	savedCommunity.setDeleted("Y");
	commDao.updateCommunity(savedCommunity);
	
	response.sendRedirect("list.jsp?page=" + pageNo);
	
%>