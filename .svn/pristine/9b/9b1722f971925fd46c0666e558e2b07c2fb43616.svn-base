<%@page import="utils.DateUtils"%>
<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.NoticeDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.NumberUtils"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/bdbabb79d8.js" crossorigin="anonymous"></script>
<style>
@font-face {
    font-family: 'SUIT-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
body {
   font-family: 'SUIT-Regular';
}
</style>
<title>공지사항 목록</title>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="notice" name="menu"/>
</jsp:include>

<div class="container">
	<div class="row">
		<div class="col-12">
			<h1> 공지사항 목록</h1>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	int admin = 0;
	if (loginUser != null) {
		admin = loginUser.getNo();
	}	
	NoticeDao noticeDao = new NoticeDao();
	List<Notice> noticeList = noticeDao.getNotices();
	// 공지사항 목록확인
		
%>
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>조회수</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
<%
	for(Notice notice : noticeList){
%>
					<tr>
						<td><%=notice.getNo() %></td>
						<td><a href="noticedetail.jsp?no=<%=notice.getNo()%>"><%=notice.getTitle() %></a></td>
						<style>
							a{
								text-decoration : none;
								color : black;
								
							}
						</style>
						<td><%=notice.getView_cnt() %></td>
						<td><%=DateUtils.toText(notice.getCreateDate()) %></td>
					</tr>
<%
	}
%>	
				</tbody>
			</table>
<%
	// 관리유저 번호 지정 100001번일시 새글이라는 버튼이 보임
	if(admin ==100001) {
		
%>
				      <a class="btn btn-outline-primary" href="detail.jsp">새 글</a>
		
<%
	}
%>

		</div>	
	</div>
</div>
</body>
</html>