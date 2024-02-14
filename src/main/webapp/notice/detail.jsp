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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/bdbabb79d8.js" crossorigin="anonymous"></script>
  
  
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="menu"/>
</jsp:include>

<div class="container">
      <div class="row">
         <div class="col-12">
           <h1>공지사항 글쓰기</h1>
           

  
           <form action="insert.jsp" method="post">
             <div class="form-group">
               <label for="title">제목</label>
               <input type="text" class="form-control" name="title">
             </div>
             <div class="form-group">
	            <label for="content">내용</label>
	            <textarea class="form-control" rows="5" name="content"
	             name="content" placeholder="내용 작성"></textarea>
	         
	          </div>
	          
	             

	           <button type="submit" class="btn btn-default">목록</button>
	           <button type="submit" class="btn btn-default">등록</button>
           </form>
        </div>
  
   </div>
</div>
</body>
</html>
