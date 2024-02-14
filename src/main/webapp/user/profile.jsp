<%@page import="vo.Community"%>
<%@page import="dao.CommunityDao"%>
<%@page import="dao.FollowDao"%>
<%@page import="vo.Follow"%>
<%@page import="dto.LoginUser"%>
<%@page import="vo.Meeting"%>
<%@page import="java.util.List"%>
<%@page import="dao.MeetingDao"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
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
<title>TODOIT:프로필 상세</title>
</head>
<body class="position-relative">
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("LOGIN_USER");

	int userNo = Integer.parseInt(request.getParameter("userNo"));

	UserDao userDao = new UserDao();
	User user = userDao.getUserByNo(userNo);
%>
<div class="container mb-5">
	<div class="row mb-3">
	
		<div class="col-2 justify-content-center">
			<div class="mb-3">
				<img src="/resources/images/user/<%=user.getFilename() %>" class="rounded-3 mx-auto d-block" height="120px" width="120px">
			</div>
			<div class="d-grid gap-2 col-12 mx-auto">
<%
	if (loginUser == null) {
		// 로그인하지 않은 사용자일 경우
%>
				<button class="btn btn-outline-primary btn-sm" onclick="loginAlert()">팔로우</button>		
<%
	} else if (userNo == loginUser.getNo()) {
		// 팔로우하려는 사람이 본인일 경우
%>
				<a href="/info/infohome.jsp" class="btn btn-outline-primary btn-sm">마이페이지</a>
<%
	} else if (userNo != loginUser.getNo()) {
		
		User userOwner = new User();
		User userFollower = new User();
		userOwner.setNo(userNo);
		userFollower.setNo(loginUser.getNo());
		
		Follow follow = new Follow();
		follow.setUserOwner(userOwner);
		follow.setUserFollower(userFollower);
	
		FollowDao followDao = new FollowDao();
				
		Follow savedFollow = followDao.getFollow(follow);
		// 팔로우한 경우
		if (savedFollow != null) {
%>
				<a href="deleteFollow.jsp?userNo=<%=userNo %>" class="btn btn-outline-primary btn-sm">팔로우 취소</a>			
<%
		} else {
		// 팔로우 하지 않은 경우
%>
				<a href="addFollow.jsp?userNo=<%=userNo %>" class="btn btn-outline-primary btn-sm">팔로우</a>
<%
		}
	}
%>
			</div>
		</div>
		
		<div class="col-10">
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="90%">
				</colgroup>
				<tbody>
					<tr>
						<th>닉네임</th><td><%=user.getNickname() %></td>
					</tr>
					<tr>
						<th>자기소개</th>
<%
	if (user.getContent() == null) {
%>
						<td>안녕하세요. <%=user.getNickname() %> 입니다.</td>
<%
	} else {
%>
						<td><%=user.getContent() %></td>
<%
	}
%>
					</tr>
					<tr class="align-middle">
						<th>팔로잉</th>
<%
	FollowDao followDao = new FollowDao();
	int followingCnt = followDao.getFollowingCnt(userNo);
%>
						<td><%=followingCnt %> 명</td>
					</tr>
					<tr>
						<th>팔로워</th>
<%
	int followerCnt = followDao.getFollowerCnt(userNo);
%>
						<td><%=followerCnt %> 명</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
	
	<!-- 내가 개설한 모임 리스트 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card ">
				<div class="card-header"><strong><%=user.getNickname() %></strong> 님이 개설한 모임</div>
				<div class="card-body">
					<table class="table table-bordered">
						<colgroup>
							<col width="10%">
							<col width="50%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<thead>
					        <tr>
					        	<th>모임 사진</th>
					            <th>모임 이름</th>
					            <th>인원수</th>
					            <th>찜</th>
					        </tr>
					    </thead>
					    <tbody>
<%
	MeetingDao meetingDao = new MeetingDao();
	List<Meeting> meetingList = meetingDao.getMeetingsByUserNo(userNo);
	
	if (meetingList.isEmpty()) {
%>
					    	<tr class="align-middle">
					    		<td colspan="4" class="text-center"><%=user.getNickname() %> 님이 개설한 모임이 없습니다.</td>
					    	</tr>
<%
	} else {
		for (Meeting meeting : meetingList) {
%>
					    	<tr class="align-middle">
					    		<td><img class="mx-auto d-block" src="/resources/images/meeting/<%=meeting.getImageName() %>" height="70px" /></td>
					    		<td><%=meeting.getTitle() %></td>
					    		<td><%=meeting.getActualPeople()%> / <%=meeting.getMaxPeople() %></td>
					    		<td><%=meeting.getWishCnt()%></td>
					    	</tr>
<%
		}
	}
%>
					    </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 내가 작성한 후기 리스트 -->
	<div class="row mb-3">
		<div class="col-12">
			<div class="card ">
				<div class="card-header"><strong><%=user.getNickname() %></strong> 님이 작성한 후기</div>
				<div class="card-body">
					<table class="table table-bordered">
						<colgroup>
							<col width="10%">
							<col width="70%">
							<col width="20%">
						</colgroup>
						<thead>
					        <tr>
					        	<th>후기 사진</th>
					            <th>후기 제목</th>
					            <th>좋아요</th>
					        </tr>
					    </thead>
					    <tbody>
<%
	CommunityDao commDao = new CommunityDao();
	List<Community> commList = commDao.getCommunitiesByUserNo(userNo);

	if (commList.isEmpty()) {
%>
					    	<tr class="align-middle">
					    		<td colspan="4" class="text-center"><%=user.getNickname() %> 님이 작성한 후기가 없습니다.</td>
					    	</tr>
<%
	} else {
		for (Community community : commList) {
%>
					    	<tr class="align-middle">
					    		<td><img class="mx-auto d-block " src="/resources/images/community/<%=community.getImageName() %>" height="70px" /></td>
					    		<td><%=community.getTitle() %></td>
					    		<td><%=community.getLikeCnt() %></td>
					    	</tr>
<%
		}
	}
%>
					    </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function loginAlert() {
		alert('로그인이 필요한 서비스입니다.');
	}
</script>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>