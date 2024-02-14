<%@page import="utils.DateUtils"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="dto.LoginUser"%>
<%@page import="java.util.List"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.Address"%>
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
<title>마이페이지::회원정보수정</title>
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
		AddressDao AddressDao = new AddressDao();

		// userDao객체에 userId정보를 기입해서 savedUser에 조회
		User savedUser = userdao.getUserById(userId);
		List<Address> sidoList = AddressDao.getAddressByCityName();
		List<Address> guList = AddressDao.getAddressByguName(savedUser.getAddress().getAddress_no2());
		
%>

<div class="container">
		<!-- 사이드바 시작 -->
		<div class="row pt-4 mb-3">
			<div class="col-3">
				<jsp:include page="sidebar.jsp">
					<jsp:param value="info" name="menu"/>
				</jsp:include>
			</div>
			<!-- 회원정보수정페이지 시작 -->
			<div class="col-9">
			<h1>회원정보수정</h1>


				<form class="border bg-light p-3"
				 method="post"
				 action="modify.jsp"
				 enctype="multipart/form-data">
					<div class="form-group">
						<label class="form-label">아이디</label>
						<input type="text" class="form-control" value=<%=savedUser.getId()%> name="id" disabled readonly/>
					</div>
					<div class="form-group">
						<label class="form-label">이름</label>
						<input type="text" value=<%=savedUser.getName()%> class="form-control" name="name"/>
					</div>
					<div class="form-group">
						<label class="form-label">닉네임</label>
						<input type="text" value=<%=savedUser.getNickname()%> class="form-control" name="nickname"/>
					</div>
					<div class="form-group">
						<label class="form-label">생년월일</label>
						<input type="Date" value=<%=DateUtils.toText(savedUser.getBirthDate()) %> class="form-control" name="birthdate"/>
					</div>

					<div class="form-group">
						<label>성별</label>
<!-- savedUser에 저장된 Gender값이 "M"일 경우 남자에 checked, "F"일 경우 여자에 checked -->
<%
	if (savedUser.getGender().equals("M")) {

%>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="gender" value="M" checked>
					  <label class="form-check-label" for="flexRadioDefault1">
					    남자
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="gender" value="F" >
					  <label class="form-check-label" for="flexRadioDefault2" >
					    여자
					  </label>
					</div>

<%
	} else {

%>
					<div class="form-check">
					<input class="form-check-input" type="radio" name="gender" value="M" >
					  <label class="form-check-label" for="flexRadioDefault1">
					    남자
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="gender" value="F" checked>
					  <label class="form-check-label" for="flexRadioDefault2" >
					    여자
					  </label>
					</div>
<%
	}
%>
					</div>


					<div class="form-group">
						<label class="form-label">이메일</label>
						<input type="text" value=<%=savedUser.getEmail()%> class="form-control" name="email"/>
					</div>
					<div class="form-group">
						<label class="form-label">전화번호</label>
						<input type="text" value=<%=savedUser.getTel()%> class="form-control" name="tel"/>
					</div>
					<div class="form-group">
						<label class="form-label">주소</label>
						<select class="form-select" name="cityNo" onchange="changeCityName()">
<!-- 시이름에 맞춰서 해당 시에 구이름을 출력 -->
<%
	for (Address add : sidoList) {
%>
							<option  value="<%=add.getNo()%>" <%=add.getNo() == savedUser.getAddress().getAddress_no2() ? "selected" : ""%>>
								<%=add.getCity_name()%>
							</option>
<%
	}
%>
						</select>

						<select class="form-select" name="guNo">
<%
	for (Address addgu : guList) {
%>
							<option value="<%=addgu.getNo()%>" <%=addgu.getNo() == savedUser.getAddress().getNo() ? "selected" : "" %>>
							<%=addgu.getGu_name() %>
							</option>
<%
	}
%>
						</select>
					</div>
					<div class="form-group">
						<label class="form-label">한줄소개</label>
						<input type="text" value="<%=savedUser.getContent() %>" class="form-control" name="content"/>
					</div>
					<div class="mb-3">
					  <label for="formFile" class="form-label">프로필사진</label>
					  <input type="file" value="" class="form-control" name="upfile">
					</div>
					<div class="text-end">
						<a href="info.jsp" class="btn btn-secondary">취소</a>
						<button type="submit" class="btn btn-primary">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
<script type="text/javascript">
	function changeCityName(){
		let cityNo = document.querySelector("select[name=cityNo]").value;
		let xhr = new XMLHttpRequest();


		xhr.onreadystatechange = function() {

			if (xhr.readyState == 4 && xhr.status == 200) {
				/*
				[{no:101, cityName:서울,  gu:종로구} {no:101, cityName:서울,  gu:중구} ~~]
				*/
				let text = xhr.responseText;
				let arr = JSON.parse(text);

				let content = "";
				for (let index = 0; index < arr.length; index++) {
					let item = arr[index];
					let no = item.no;
					let gu = item.gu_name;

					let option = `
						<option value=\${no}> \${gu}</option>
					`;
					content += option;
				}
				document.querySelector("select[name=guNo]").innerHTML = content;
			}
		}
		xhr.open("GET", "gulist.jsp?no=" + cityNo);
		xhr.send();
	}

</script>
</html>















