<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 // 무효화시킨다.
  session.invalidate();
 // 재요청 응답을 보낸다.
  response.sendRedirect("/index.jsp");
 %>