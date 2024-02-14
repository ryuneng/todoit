<%@page import="vo.Question"%>
<%@page import="java.util.List"%>
<%@page import="dao.QuestionDao"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는질문 글등록</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script></head>
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

<div class="container">
      <div class="row">
         <div class="col-12">
           <h1>자주묻는질문 등록</h1>

           <form class="border bg-light p-3" action="insert.jsp" method="post">
             <div class="form-group">
               <label for="title">자주묻는 질문 등록</label>
               <input type="text" class="form-control" id="title" name="title">
             </div>
             <div class="form-group">
            <label for="content">답변</label>
            <textarea class="form-control" rows="5" id="content" name="content" placeholder="답변작성"></textarea>
          </div>
             <button type="submit" class="btn btn-primary">등록</button>
           	<a class="btn btn-secondary" href="">취소</a>
           </form>
        </div>
   </div>
</div>
</body>
</html>
