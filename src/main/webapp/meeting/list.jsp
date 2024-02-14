<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="dto.LoginUser"%>
<%@page import="dao.WishDao"%>
<%@page import="vo.Wish"%>
<%@page import="utils.DateUtils"%>
<%@page import="vo.Meeting"%>
<%@page import="dto.Pagination"%>
<%@page import="dao.MeetingDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.NumberUtils"%>
<%@page import="vo.MeetingCategory"%>
<%@page import="java.util.List"%>
<%@page import="dao.MeetingCategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
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
<title>TODOIT :: 모임</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="meeting" name="menu"/>
</jsp:include>
<div class="container">
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("LOGIN_USER");
	// 요청파라미터값 조회
	int categoryNo = NumberUtils.toInt(request.getParameter("catNo"), 0);
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);
	int rows = NumberUtils.toInt(request.getParameter("rows"), 12);
	String sort = request.getParameter("sort");
	String opt = request.getParameter("opt");
	String keyword = request.getParameter("keyword");
	
	// 검색에 필요한 정보를 담는 Map 객체 생성
	Map<String, Object> param = new HashMap<>();
	
	if (categoryNo != 0) {						 // Map에 카테고리번호 저장
		param.put("categoryNo", categoryNo);		
	}
	param.put("rows", rows);					 // Map에 출력개수 저장
	if (sort == null) {							 // 정렬방식이 없을 경우 기본값은 date
		sort = "date";
	}
	param.put("sort", sort);					 // Map에 정렬방식 저장
	if (opt != null && !opt.isBlank()) {		 // Map에 검색옵션 저장
		param.put("opt", opt);
	}
	if (keyword != null && !keyword.isBlank()) { // Map에 검색어 저장
		param.put("keyword", keyword);
	}
	
	// meetingDao 객체 생성
	MeetingDao meetingDao = new MeetingDao();
	
	// 전체 게시글 수 조회
	int totalRows = meetingDao.getTotalRows(param);
	
	// 페이징처리 Pagination 객체 생성
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	// 전체 페이지번호에 해당하는 게시글 목록 조회하기
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<Meeting> meetingList = meetingDao.getMeetings(param);

	// 카테고리 조회
	MeetingCategoryDao meetingCategoryDao = new MeetingCategoryDao();
	List<MeetingCategory> meetingCategoryList = meetingCategoryDao.getAllCategories();
	
	// wish 관련 객체 생성
	WishDao wishDao = new WishDao();
	Wish wish = new Wish();
%>
	<!-- 상단 카테고리 영역 시작 -->
	<div class="row">
		<div class="col-12">
			<ul class="nav justify-content-center nav-underline p-3 mb-3">
			    <li class="nav-item">
			        <a class="nav-link fs-5 <%=categoryNo == 0 ? "active link-primary" : "text-black" %>" 
			        	href="list.jsp"
			        	onclick="changeCategory(event)">전체</a>
			    </li>
<%
	for (MeetingCategory meetingCategory : meetingCategoryList) {
%>
			    <li class="nav-item">
			        <a class="nav-link fs-5 link-primary <%=meetingCategory.getNo() == categoryNo ? "active" : "text-black" %>" 
			           href="list.jsp?catNo=<%=meetingCategory.getNo() %>"
			           onclick="changeCategory(event, <%=meetingCategory.getNo() %>)">
			        		<%=meetingCategory.getName() %>
			        </a>
			    </li>
<%
	}
%>
			</ul>
		</div>
	</div>
	<!-- 정렬/필터 시작 -->
	<div class="row">
		<div class="col-12">
			<div class="d-flex justify-content-end my-3">
				<select class="form-select" style="width:150px;" name="sort" onchange="changeSort()">
					<!--
						meeting.xml 파일의 getMeetings에
						<isEqual property="sort" compareValue="~~"> ~~ </isEqual> 로 조회해둠
					-->
					<option value="date" <%="date".equals(sort) ? "selected" : "" %>>최신순</option>
					<option value="like" <%="like".equals(sort) ? "selected" : "" %>>인기순</option>
					<option value="lowestPrice" <%="lowestPrice".equals(sort) ? "selected" : "" %>>낮은가격순</option>
					<option value="highestPrice" <%="highestPrice".equals(sort) ? "selected" : "" %>>높은가격순</option>
					<option value="score" <%="score".equals(sort) ? "selected" : "" %>>평점순</option>
				</select>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 리스트 시작 -->
	<div class="row p-3 mb-5">
<%
	if (meetingList.isEmpty()){
%>
	<h4 class="text-center m-5 p-5">등록된 모임이 없습니다.</h4>
<%
	} else {
		for (Meeting meeting : meetingList) {
%>
		<div class="col-3 mb-3">
			<div class="card p-3 mb-5 text-center" style="width: 18rem; height: 380px;">
				<!-- 1. 지역, 날짜 영역 -->
				<div>
					<p class="card-text text-secondary text-start fw-bold mb-0"><%=meeting.getAddress() %></p>
					<div class="card-text text-start text-secondary">
						<small style="font-size: 12px;" ><%=DateUtils.toTextKorean(meeting.getStartDate()) %></small>
						<small style="font-size: 12px;">~ <%=DateUtils.toTextKorean(meeting.getEndDate()) %></small>
					</div>
				</div>
				<!-- 2. 사진 ~ 가격 부모 영역 -->
			    <div class="card-body text-black text-start">
			    	<!-- 2-1. 사진, 제목 영역 -->
			    	<a href="detail.jsp?meetNo=<%=meeting.getNo() %>&page=<%=currentPage %>"
			    	   class="link-offset-2 link-underline link-underline-opacity-0 text-black">
					    <img alt="참여하기 대표 이미지" src="/resources/images/meeting/<%=meeting.getImageName() %>"
					         class="rounded mx-auto d-block img-thumbnail mb-3 text-center" width="200">
				    	<h6 class="card-title fw-bold" style="display: -webkit-box;
															  overflow: hidden;
															  text-overflow: ellipsis;
															  -webkit-box-orient: vertical;
															  -webkit-line-clamp: 2;">
    					<%=meeting.getTitle() %>
    					</h6>
   					</a>
   					<!-- 2-2. 별점, 가격, 찜 부모 영역 -->
			    	<div class="nav card-text justify-content-between">
			    		<!-- 2-2 좌측. 별점, 가격 영역 -->
			    		<div>
					        <small class="nav-item" style="font-size: 13px;">★★★★★ <%=meeting.getScoreAverage() %>점</small>
<%
	if (meeting.getDiscountPrice() == 0) {
%>
					        <p class="card-text fw-bold mt-1"><%=NumberUtils.toCurrency(meeting.getPrice()) %>원</p>
<%
	} else {
%>
					        <p class="text-secondary text-decoration-line-through mt-1 mb-1" style="font-size: 13px;"><%=NumberUtils.toCurrency(meeting.getPrice()) %>원</p>
					        <p class="card-text fw-bold"><%=NumberUtils.toCurrency(meeting.getDiscountPrice()) %>원</p>
<%
	}
%>
				        </div>
				        <!-- 2-2 우측. 찜 영역 -->
				        <div class="text-center">
<%
	// 로그인 유저가 없을 경우 찜 불가, 경고창 띄우기
	if (loginUser == null) {
%>
								<button class="btn" type="button" onclick="loginAlert()">
									<small class="nav-item text-danger"><i class="bi bi-heart"></i></small></button>
<%
	// 로그인 유저가 호스트일 경우 찜 불가, 경고창 띄우기
	} else if (loginUser.getNo() == meeting.getUser().getNo()) {
%>
								<button class="btn" type="button" onclick="wishAlert()">
									<small class="nav-item text-danger"><i class="bi bi-heart"></i></small></button>
<%
	// 이 외 insertWish 실행
	} else {
		UserDao userDao = new UserDao();
		User user = userDao.getUserByNo(loginUser.getNo());
		
		wish.setMeeting(meeting);
		wish.setUser(user);
		
		Wish savedWish = wishDao.getWish(wish);
		
		if (savedWish != null) {
%>
								<a class="btn" href="insertWish.jsp?meetNo=<%=meeting.getNo()%>&page=<%=currentPage%>">
									<small class="nav-item text-danger"><i class="bi bi-heart-fill"></i></small>
								</a>
<%
		} else {
%>
								<a class="btn" href="insertWish.jsp?meetNo=<%=meeting.getNo()%>&page=<%=currentPage%>">
									<small class="nav-item text-danger"><i class="bi bi-heart"></i></small>
								</a>

<%
		}
	}
%>
				        	<p class="nav-item text-secondary" style="font-size: 12px;"><%=meeting.getWishCnt() %></p>
			        	</div>
			        </div>
			    </div>
			</div>
		</div>
<%
		}
	}
%>
	</div>
	<!-- 컨텐츠 리스트 끝 -->
	<!-- 검색, 모임개설 영역 시작 -->
	<div class="d-flex justify-content-between mb-5">
		<!-- 검색 영역 시작 -->
		<form id="form-search" class="row row-cols-sm-auto justify-content-start align-items-center"
			  method="get"
			  action="list.jsp">
			<input type="hidden" name="catNo" value="<%=categoryNo != 0 ? categoryNo : "" %>" />
			<input type="hidden" name="page" value="<%=currentPage %>" />
			<input type="hidden" name="rows" value="<%=rows %>" />
			<input type="hidden" name="sort" value="<%=sort %>" />
			<div class="col-12">
				<select class="form-select" name="opt">
					<option value="">선택</option>
					<option value="title" <%="title".equals(opt) ? "selected" : "" %>>제목</option>
					<option value="writer" <%="writer".equals(opt) ? "selected" : "" %>>작성자</option>
					<option value="content" <%="content".equals(opt) ? "selected" : "" %>>내용</option>
				</select>
			</div>
			<div class="col-12">
				<input type="text" class="form-control" name="keyword" value="<%=keyword != null ? keyword : "" %>" />
			</div>
			<div class="col-12">
				<button onclick="searchMeetings()" type="submit" class="btn btn-outline-primary">검색</button>
			</div>
		</form>
		<!-- 모임개설 영역 시작 -->
<%
	if (loginUser != null) {
%>
		<a class="btn btn-outline-primary" href="form.jsp">모임개설</a>
<%
	} else {
%>
		<a class="btn btn-outline-primary disabled" aria-disabled="true">모임개설</a>
<%
	}
%>
		<!-- 모임개설 영역 끝 -->
	</div>
	<!-- 페이징처리 시작 -->
<%
	// 페이지 내비게이션 생성
	int beginPage = pagination.getBeginPage();
	int endPage = pagination.getEndPage();
	
	boolean isFirst = pagination.isFirst();
	boolean isLast = pagination.isLast();
%>
<%
	if (pagination.getTotalRows() > 0) {
%>
	<div class="row">
		<div class="col-12">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
<%
		if (isFirst) {
%>
			    <li class="page-item disabled">
			      <a class="page-link"><</a>
			    </li>
<%
		} else {
%>
			    <li class="page-item">
			    	<a class="page-link"
			    	   href="list.jsp?page=<%=currentPage - 1 %>"
			    	   onclick="goPage(<%=currentPage - 1 %>, event)">
			    	<
			    	</a>
			    </li>
<%
		}
	
		for (int num = beginPage; num <= endPage; num++) {
%>
			    <li class="page-item <%=currentPage == num ? "active" : "" %>">
			      <a class="page-link"
			         href="list.jsp?page=<%=num %>"
			         onclick="goPage(<%=num %>, event)">
			         <%=num %>
			      </a>
			    </li>
<%
		}
	
		if (isLast) {
%>
			    <li class="page-item disabled">
			      <a class="page-link">></a>
			    </li>
<%
		} else {
%>
			    <li class="page-item">
			    	<a class="page-link"
			    	   href="list.jsp?page=<%=currentPage + 1%>"
			    	   onclick="goPage(<%=currentPage + 1 %>, event)">
			    	>
			    	</a>
			    </li>
<%
		}
%>
			  </ul>
			</nav>
		</div>
	</div>
<%
	}
%>
	<!-- 페이징처리 끝 -->
</div>
<script type="text/javascript">
	// 카테고리 선택해도 정렬방식 초기화되지 않도록 해주는 함수 (+ form에 catNo도 hidden으로 전달해줘야 함)
	function changeCategory(event, categoryNo) {
		event.preventDefault();
		
		// 검색폼의 히든필드(name=page)를 1로 설정
		document.querySelector("input[name=page]").value = 1;
		
		// 히든필드(name=catNo)에 카테고리번호가 있을 때만 카테고리번호값을 넣어주고, 카테고리번호가 없을 때는 빈값(전체)으로 설정
		if (categoryNo) {
			document.querySelector("input[name=catNo]").value = categoryNo;			
		} else  {
			document.querySelector("input[name=catNo]").value = "";
		}
		
		// 검색폼의 입력값을 서버로 제출
		document.getElementById("form-search").submit();
	}

	// 정렬방식 함수
	function changeSort() {
		document.querySelector("input[name=page]").value = 1;
		let sort = document.querySelector("select[name=sort]").value;
		document.querySelector("input[name=sort]").value = sort;
		
		document.getElementById("form-search").submit();
	}
	
	// 페이지 번호 클릭 시 실행되는 이벤트핸들러 함수 (검색조건, 검색어도 함께 전달)
	function goPage(page, event) {
		event.preventDefault();
		
		document.querySelector("input[name=page]").value = page;
		document.getElementById("form-search").submit();
	}
	
	// 검색버튼 클릭 시 실행되는 함수
	function searchMeetings() {
		document.querySelector("input[name=page]").value = 1;
		document.getElementById("form-search").submit();
	}
	
	// 로그인이 필요한 경우 alert 띄우기
	function loginAlert() {
		alert('로그인이 필요한 서비스입니다.');
	}
	
	// 본인이 호스트인 모임 찜 불가 alert 띄우기
	function wishAlert() {
		alert('호스트인 모임은 찜할 수 없습니다.');
	}
</script>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="meeting" name="menu"/>
</jsp:include>
</body>
</html>