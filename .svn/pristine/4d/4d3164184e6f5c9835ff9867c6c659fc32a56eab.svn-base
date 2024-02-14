<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDao"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세폼 </title>
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
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/bdbabb79d8.js" crossorigin="anonymous"></script>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="notice" name="menu"/>
</jsp:include>

<div class="container">
      <div class="row">
         <div class="col-12">
           <h1>공지사항 상세정보</h1>
 <%
 	int no = Integer.valueOf(request.getParameter("no"));
 	String error = request.getParameter("error");
 	
 	NoticeDao noticeDao = new NoticeDao();
 	Notice notice = noticeDao.getNoticeByNo(no);
 	
	notice.setView_cnt(notice.getView_cnt() + 1);
	noticeDao.updateNotice(notice);
	
	// 화면 : 공지사항 상세 정보를 보는 메뉴 
 	
 %>
  			<table class="table">
  				<colgroup>
  					<col width="15%">
  					<col width="35%">
  					<col width="15%">
  					<col width="35%">
  				</colgroup>
  				<tbody>
  					<tr>
  						<th>제목</th>
  						<td><%=notice.getTitle() %></td>
  						<th>번호</th>
  						<td><%=notice.getNo() %></td>
  					</tr>
  					<tr>
  						<th>등록일</th>
  						<td><%=DateUtils.toText(notice.getCreateDate()) %></td>
  						<th>조회수</th>
  						<td><%=notice.getView_cnt() %></td>
  					</tr>
  					<tr>
  						<th>내용</th>
  						<td colspan="3"><%=notice.getContent() %></td>
  					</tr>
  				</tbody>
  			</table>
            
            <div class="text-end">
            	<a href="list.jsp" class="btn btn-primary">목록</a>
            </div>
	     </div>
   	</div>
</div>
</body>
</html>
