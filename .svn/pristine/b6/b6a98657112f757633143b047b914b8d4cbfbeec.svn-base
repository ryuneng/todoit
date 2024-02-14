<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.custom-navbar {
    background-color: #BDBDBD;
    padding: 3px 0; /* 높이 조절을 위한 패딩 추가 */
}

.custom-navbar .nav-link {
    color: #424242;
    font-size: 14px; /* 링크 텍스트 크기 조절 */
}
</style>

<%
String menu = request.getParameter("menu");
LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
%>

<!-- 상단 네비게이션 바 -->
<nav class="navbar navbar-expand-sm custom-navbar bottom p-0" data-bs-theme="dark">
   <div class="container-fluid">
      <ul class="navbar-nav ms-auto">
<% 
	if (loginUser == null) {
%>
          <li class="nav-item">
            <a class="nav-link <%= "register".equals(menu) ? "active" : "" %>" href="/user/registerform.jsp">회원가입</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%= "login".equals(menu) ? "active" : "" %>" href="/user/loginform.jsp">로그인</a>
          </li>
<%
	} else {
%>
          <li class="nav-item">
            <a class="nav-link <%= "user".equals(menu) ? "active" : "" %>" href="/info/infohome.jsp">마이페이지</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/user/logout.jsp">로그아웃</a>
          </li>
<%
	}
%>
          <li class="nav-item">
            <a class="nav-link <%= "notice".equals(menu) ? "active" : "" %>" href="/notice/list.jsp">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link <%= "question".equals(menu) ? "active" : "" %>" href="/question/list.jsp">자주묻는질문</a>
          </li>
      </ul>
   </div>
</nav>

<!-- 로고 및 하단 네비게이션 바 -->
<nav class="navbar navbar-expand-sm bg-light mb-3">
   <div class="container-fluid">
      <a href="/index.jsp">
         <img src="/resources/images/logo.png" alt="로고" style="float: left; margin-left: 110px; max-width: 210px; height: auto;">
      </a>
      <ul class="nav justify-content-end" style="padding-right: 100px;">
         <li class="nav-item">
            <a class="nav-link text-dark" href="/meeting/list.jsp" style="font-size: 22px; margin-right: 30px;">참여하기</a>
         </li>
         <li class="nav-item">
            <a class="nav-link text-dark" href="/community/list.jsp" style="font-size: 22px; margin-right: 30px;">커뮤니티</a>
         </li>
         <li class="nav-item">
            <a class="nav-link text-dark" href="/dailycheck/dailycheck.jsp" style="font-size: 22px; margin-right: 30px;">출석체크</a>
         </li>
      </ul>
   </div>
</nav>
