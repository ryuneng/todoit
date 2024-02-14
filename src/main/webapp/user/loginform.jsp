<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>bootstrap</title>
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
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="loginform" name="menu"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col-4 offset-md-4" >
			<h1>TODOIT 로그인 폼</h1>
<%
	String error = request.getParameter("error");
%>

<%
	if("fail".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>로그인실패</strong> 아이디 혹은 비밀번호가 일치하지 않습니다
			</div>
<%
	}else if("deny".equals(error)){
%>
			<div class="alert alert-danger">
				<strong>로그인 필수</strong> 로그인은 필수 사항입니다.
			</div>
<%
	}
%>
			<form class="border bg-light p-3" 
				method="post" 
				action="login.jsp"
				onsubmit = "checkForm(event)">
				<div class="form-group mb-3">
					<label class="form-label">아이디</label>
					<input type="text" class="form-control" name="id" />
				</div>
				<div class="form-group mb-3">
					<label class="form-label">비밀번호</label>
					<input type="password" class="form-control" name="password" />
				</div>
				<div class="text-end">
					<a href="registerform.jsp" class="btn btn-secondary">회원가입</a>
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	function checkForm(event) {
	
	let idInput = document.querySelector("input[name=id]");
	let passwordInput = document.querySelector("input[name=password]");
	
	let id = idInput.value.trim();
	let password = passwordInput.value.trim();
	
	if(id === "") {
		alert("아이디를 입력하세요");
		event.preventDefault();
		return;
	}
	
	if(password === "") {
		alert("비밀번호를 입력하시오");
		event.preventDefault();
		return;
	}
}
</script>
</body>
</html>
	
	
	
	
	
	
	
	
	
	