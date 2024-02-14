<%@page import="dto.LoginUser"%>
<%@page import="dao.CommunityDao"%>
<%@page import="vo.Meeting"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommCategoryDao"%>
<%@page import="vo.CommCategory"%>
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
<title>TODOIT::커뮤니티 등록폼</title>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="manu"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col-12">
			<h3 class="mt-3">게시글 등록폼</h3>

			<form class="border bg-light p-3" method="post" action="insert.jsp" enctype="multipart/form-data"
				onsubmit="checkContent(event)">
				<div class="form-group mb-3">
					<label class="form-label">참여한 모임 리스트</label>
					<select class="form-select" name="meetNo">
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	CommunityDao commDao = new CommunityDao();
	List<Meeting> meetingList = commDao.getAllMeetingsByUserNo(loginUser.getNo());
	
	if (meetingList.isEmpty()) {
		response.sendRedirect("list.jsp?error=insertCommFail");
	}
	
	else {
		for (Meeting meeting : meetingList) {
%>
						<option value="<%=meeting.getNo() %>"><%=meeting.getTitle() %></option>
<%
		}
	}
%>
					</select>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">카테고리</label>
					<select class="form-select" name="catNo" onchange="toggleStar()">
<%
	CommCategoryDao commCatDao = new CommCategoryDao();
	List<CommCategory> commCat = commCatDao.getAllCategories();
	
	for (CommCategory categry : commCat) {
%>
						<option value="<%=categry.getNo() %>"><%=categry.getName() %></option>
<%
	}
%>
					</select>
				</div>
				<div id="star-wrapper" class="form-group mb-3 d-none">
					<label class="form-label">평점</label>
<%
	for (int i = 1; i <= 5; i++) {
%>
					<div class="form-check form-check-inline">
  							<input class="form-check-input" type="radio" name="score" value="<%=i %>" disabled>
  							<label class="form-check-label">
<% 
		for (int j = 1; j <= i; j++) {
%>
  								<i class="fa-solid fa-star"></i>
<%
		}
%>
  							</label>
					</div>
<%
	}
%>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">제목</label>
					<input type="text" class="form-control" name="title" />
				</div>
				<div class="form-group mb-3">
					<label class="form-label">내용</label>
					<textarea rows="10" class="form-control" name="content"></textarea>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">첨부파일</label>
					<input type="file" class="form-control" name="upfile" />
				</div>
				<div class="text-end">
					<a class="btn btn-secondary" href="list.jsp">취소</a>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	function checkContent() {
		let form = event.target;
		let content = form.querySelector("textarea").value;
		if (content === "") {
			event.preventDefault();
			alert("내용을 입력하세요");
			return;
		}
	}
	
	function toggleStar() {
		
		const REVIEW_CATEGORY_NO = "100001";
		let div = document.getElementById("star-wrapper");							// 별을 포함하는 div를 선택한다.
		let scoreRadioList = document.querySelectorAll("input[name=score]");		// 모든 평점 라디오버튼을 선택한다.
		let selectedCatNo = document.querySelector("select[name=catNo]").value;		// 카테고리 셀렉터의 현재 카테고리번호를 조회한다.
		
		if (selectedCatNo === REVIEW_CATEGORY_NO) {
			div.classList.remove("d-none");	// d-none 클래스를 제거해서 div 엘리먼트가 화면에 출력되게 한다.
			for (let index = 0; scoreRadioList.length; index++) {
				let radio = scoreRadioList[index];
				radio.disabled = false;		// 라디오버튼을 하나씩 순회하면서 라디오버튼 엘리먼트의 disabled 프로퍼티값을 false로 설정해서 활성화한다.
				if (index == 4) {
					radio.checked = true;
				}
			}
			
		} else {
			div.classList.add("d-none");	// d-none 클래스를 추가해서 div 엘리먼트가 화면에 표시되지 않게한다.
			for (let index = 0; scoreRadioList.length; index++) {
				let radio = scoreRadioList[index];
				radio.disabled = true;		// 라디오버튼을 하나씩 순회하면서 라디오버튼 엘리먼트의 disabled 프로퍼티값을 true로 설정해서 비활성화한다.
			}
		}
	}
	
</script>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>