<%@page import="dao.MeetingReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String selectedReplyNos = request.getParameter("selectedReplyNos");	// 1007,1009,1011
	int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));
	
	String[] arr = selectedReplyNos.split(",");
	
	MeetingReplyDao meetingReplyDao = new MeetingReplyDao();
	
	for (String value : arr) {
		int replyNo = Integer.parseInt(value);
		meetingReplyDao.deleteMeetingReply(replyNo);
	}
	
	response.sendRedirect("/host/managementDetail.jsp?meetingNo=" + meetingNo);
%>