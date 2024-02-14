<%@page import="vo.ApplyUser"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dao.ApplyUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true"
    pageEncoding="UTF-8"%>
<%
	int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));
	int applyNo = Integer.parseInt(request.getParameter("applyNo"));
	String action = request.getParameter("action");
	
	ApplyUserDao dao = new ApplyUserDao();
	
    if ("accept".equals(action)) {
        // accept 작업 처리
        dao.acceptApplies(applyNo);
    } else if ("reject".equals(action)) {
        // reject 작업 처리
        dao.rejectApplies(applyNo);
    } 
    
    response.sendRedirect("managementDetail.jsp?meetingNo=" + meetingNo);
%>