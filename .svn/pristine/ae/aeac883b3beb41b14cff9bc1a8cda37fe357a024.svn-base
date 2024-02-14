<%@page import="vo.CommReplyDanger"%>
<%@page import="vo.CommReply"%>
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
	
	// 댓글 번호로 댓글 조회
	CommReplyDao replyDao = new CommReplyDao();
	CommReply savedReply = replyDao.getReplyByNo(replyNo);
	
	// 댓글과 신고자 정보 저장
	CommReplyDanger replyDanger = new CommReplyDanger();
	replyDanger.setCommReply(savedReply);
	replyDanger.setUser(user);
	
	// 댓글 신고자 조회
	CommReplyDanger existDangerReply = replyDao.getReplyDanger(replyDanger);
	
	if (existDangerReply != null) {
		// 로그인한 사용자가 이미 댓글을 신고한 경우
		// 응답메세지로 에러메세지 같이 보내기
		response.sendRedirect("detail.jsp?no=" + commNo + "&page=" + pageNo + "&error=dangerFail");
	} else {
		// 로그인한 사용자가 댓글을 신고한 내역이 없는 경우
		// 신고 내역 저장
		replyDao.addReplyDanger(replyDanger);
		// 댓글 신고수 업데이트
		replyDao.updateReplyDangerCnt(replyDanger);
		// 원래 페이지로 돌아가기
		response.sendRedirect("detail.jsp?no=" + commNo + "&page=" + pageNo + "&success=dangerSuccess");
	}
	
%>