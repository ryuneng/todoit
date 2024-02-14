<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Address"%>
<%@page import="dto.LoginUser"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>마이페이지::회원정보</title>
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
	User saveduser = userdao.getUserById(userId);


%>
<div class="container">
	<div class="row pt-4 mb-3">
<!-- 사이드바 시작 -->
		<div class="col-3">
			<jsp:include page="sidebar.jsp">
				<jsp:param value="info" name="menu"/>
			</jsp:include>
		</div>
<!-- 유저정보 페이지 시작 -->
		<div class="col-9">
			<h1>내 정보관리</h1>
			<div class="m-3">
				<table class="table">
						<tbody>
							<tr>
						      <th>아이디</th>
						      <td><%=saveduser.getId() %></td>
						    </tr>

						    <tr>
						      <th>비밀번호</th>
						      <td>********</td>
						    </tr>
						    <tr>
						      <th>이름</th>
						      <td><%=saveduser.getName() %></td>
						    </tr>
						    <tr>
						      <th>닉네임</th>
						      <td><%=saveduser.getNickname() %></td>
						    </tr>
						    <tr>
						      <th>생년월일</th>
						      <td><%=DateUtils.toText(saveduser.getBirthDate()) %></td>
						    </tr>
<!-- 유저정보 중 성별이 "M"일 경우에 남자, "F"일 경우 여자라고 출력 -->
<%
	if(saveduser.getGender().equals("M")) {

%>
						    <tr>
						      <th>성별</th>
						      <td>남자</td>
						    </tr>
<%
	} else {

%>
							 <tr>
						      <th>성별</th>
						      <td>여자</td>
						    </tr>
<%
	}
%>

						    <tr>
						      <th>이메일</th>
						      <td><%=saveduser.getEmail() %></td>
						    </tr>
						    <tr>
						      <th>전화번호</th>
						      <td><%=saveduser.getTel() %></td>
						    </tr>
						    <tr>
						      <th>주소</th>
						      <td><%=saveduser.getAddress().getCity_name() %> <%=saveduser.getAddress().getGu_name() %></td>
						    </tr>
						    <tr>
						      <th>한줄소개</th>
						      <td><%=saveduser.getContent() %></td>
						    </tr>
						    <tr>
						      <th>가입일자</th>
						      <td><%=DateUtils.toText(saveduser.getCreateDate()) %></td>
						    </tr>
						    <tr>
						      <th>프로필사진</th>
						    	<td>
						    		<img class="img-thumbnail" style="width: 200px; height: 200px;" alt="프로필사진" src="/resources/images/user/<%=saveduser.getFilename() %>">
						    	</td>
						    </tr>
						</tbody>
					</table>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					  <a href="modifyform.jsp" class="btn btn-secondary">수정</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
</html>