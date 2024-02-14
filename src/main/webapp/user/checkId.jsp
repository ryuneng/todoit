<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page contentType="text/plain; chartset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%
 String id = request.getParameter("id");

UserDao userDao = new UserDao();
User user = userDao.getUserById(id);

if(user==null) {
	out.write("none");
}else {
		out.write("exist");
		
}
%>