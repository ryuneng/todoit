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
<title>게시판 상세</title>
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
  
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="notice" name="menu"/>
</jsp:include>

<div class="container">
	<div class="row">
		<div class="col-12">
			<h1>공지사항 등록</h1>
         	<form class="border bg-light p-3" action="list.jsp" method="post">
           		<div class="form-group mb-3">
             		<label for="title">공지사항제목</label>
             		<input type="text" class="form-control" name="title">
           		</div>
           		<div class="form-group mb-3">
           			<label for="content">내용</label>
           			<textarea class="form-control" rows="5" name="content" placeholder="내용 작성"></textarea>
         		</div>
         		<div class="text-end">
               		<button type="submit" class="btn btn-primary">등록</button>
         			<a class="btn btn-secondary" href="list.jsp">취소</a>
         		</div>
         	</form>
       	</div>
  	</div>
</div>
</body>
</html>
