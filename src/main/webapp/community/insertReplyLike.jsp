<%@page import="vo.CommReply"%>
<%@page import="vo.CommReplyLike"%>
<%@page import="dao.CommReplyDao"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	int commNo = Integer.parseInt(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("page"));
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));
	
	User user = new User();
	user.setNo(loginUser.getNo());
	
	CommReply commReply = new CommReply();
	commReply.setNo(replyNo);
	
	// 댓글과 좋아요한 사용자 정보 저장
	CommReplyLike replyLike = new CommReplyLike();
	replyLike.setCommReply(commReply);
	replyLike.setUser(user);
	
	// 댓글에 대한 좋아요 조회
	CommReplyDao replyDao = new CommReplyDao();
	CommReplyLike existReplyLike = replyDao.getReplyLike(replyLike);
	
	if (existReplyLike != null) {
		// 로그인한 사용자가 이미 댓글을 좋아요한 경우
		// 응답메세지로 에러메세지 같이 보내기
		response.sendRedirect("detail.jsp?no=" + commNo + "&page=" + pageNo + "&error=likeFail");
	} else {
		// 로그인한 사용자가 댓글을 좋아요한 내역이 없는 경우
		// 좋아요 내역 저장
		replyDao.addReplyLike(replyLike);
		// 원래 페이지로 돌아가기
		response.sendRedirect("detail.jsp?no=" + commNo + "&page=" + pageNo);
	}
	
%>