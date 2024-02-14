<%@page import="dto.LoginUser"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>마이페이지::회원탈퇴폼</title>
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
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>

<%

	// session 에서 loginuser 정보조회
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	// userId에다가 로그인유저 아이디 조회
	String userId = loginUser.getId();

	// userdao 객체생성
	UserDao userdao = new UserDao();

	// userDao객체에 userId정보를 기입해서 savedUser에 조회
	User savedUser = userdao.getUserById(userId);

%>

<%
	String error = request.getParameter("error");		// 아래 폼에서 비밀번호가 일치하지 않으면 재요청한다.
%>

<%
	if("fail".equals(error)) {
%>
			<div class="alert alert-danger">
				 <strong>비밀번호</strong>가 일치하지 않습니다.
			</div>

<%
	}
%>

<div class="container">
<!-- 사이드바 시작 -->
	<div class="row pt-4 mb-3">
		<div class="col-3">
			<jsp:include page="sidebar.jsp">
				<jsp:param value="delete" name="menu"/>
			</jsp:include>
		</div>
<!-- 회원탈퇴 페이지 시작 -->
		<div class="col-9">
		<h1>회원탈퇴</h1>
			<div class="row m-3">
				<form class="border bg-light p-3"
				method="post"
				action="delete.jsp">
					<div class="form-group mb-3">
						<label class="form-lavel">아이디</label>
						<input type="text" value="<%=savedUser.getId() %>" class="form-control" name="id" disabled readonly/>
					</div>
					<div class="form-group mb-3">
						<label class="form-lavel">비밀번호</label>
						<input type="password" class="form-control" name="password" />
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<button type="button" class="btn btn-danger me-md-2" data-bs-toggle="modal" data-bs-target="#exampleModal">
						  회원탈퇴
						</button>
					</div>
					<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">※주의※</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <strong>탈퇴 시 기존의 있던 기록들은 전부 사라집니다.</strong>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					        <button type="submit" class="btn btn-danger">회원탈퇴</button>
					      </div>
					    </div>
					  </div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
</html>