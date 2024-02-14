<%@page import="vo.ApplyUser"%>
<%@page import="dao.ApplyUserDao"%>
<%@page import="vo.MeetingReplyLike"%>
<%@page import="dao.UserDao"%>
<%@page import="utils.NumberUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="dao.MeetingReplyDao"%>
<%@page import="vo.MeetingReply"%>
<%@page import="vo.User"%>
<%@page import="dao.WishDao"%>
<%@page import="vo.Wish"%>
<%@page import="utils.StringUtils"%>
<%@page import="utils.DateUtils"%>
<%@page import="dao.MeetingDao"%>
<%@page import="vo.Meeting"%>
<%@page import="dto.LoginUser"%>
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
<title>TODOIT::모임상세</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="meeting" name="menu"/>
</jsp:include>
<div class="container">
	<div class="row">
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("LOGIN_USER");

	int meetNo = Integer.valueOf(request.getParameter("meetNo"));
	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);
	String error = request.getParameter("error");
	String alert = request.getParameter("alert");
	
	// 본인이 작성한 모임글이 아닐 경우 수정/삭제 
	if("deny".equals(error)) {
%>
		<div class="alert alert-danger">
			다른 사용자가 주최한 모임은 수정/삭제할 수 없습니다.
		</div>
<%
	}
	if("denyReply".equals(error)) {
%>
		<div class="alert alert-danger">
			다른 사용자가 작성한 댓글은 수정/삭제할 수 없습니다.
		</div>
<%
	}
	if("dangerFail".equals(error)) {
%>
<script type="text/javascript">
	alert('이미 신고한 댓글은 신고할 수 없습니다.');
</script>
<%
	}
	if("dangerSuccess".equals(error)) {
%>
<script type="text/javascript">
	alert('댓글이 신고되었습니다.');
</script>
<%
	}
	if("wishAdd".equals(alert)) {
%>
<script type="text/javascript">
	alert('해당 모임이 찜 되었습니다.');
</script>
<%
	}
	if("wishDelete".equals(alert)) {
%>
<script type="text/javascript">
	alert('찜이 취소 되었습니다.');
</script>
<%
	}
	
	// 작성자가 아니면 수정, 삭제 버튼 보이지 않게 한다
	MeetingDao meetingDao = new MeetingDao();
	Meeting meeting = meetingDao.getMeetingByNo(meetNo);

	if (loginUser != null && loginUser.getNo() == meeting.getUser().getNo()) {
%>
		<div class="text-end mb-2">
			<a class="btn btn-warning" href="modifyForm.jsp?meetNo=<%=meetNo %>&page=<%=currentPage %>" >수정</a>
			<a class="btn btn-danger"  href="delete.jsp?meetNo=<%=meetNo %>&page=<%=currentPage%>">삭제</a>
		</div>
<%
	}
	meeting.setViewCnt(meeting.getViewCnt() + 1);
	meetingDao.updateMeetingByNo(meeting);
%>
		<h4 class="mt-3" ><%=StringUtils.withBr(meeting.getTitle())%></h4>
		<div class="text-end" >조회수 : <%=meeting.getViewCnt() %></div>
	</div>
	<!-- 모임 상세 내용 획득 후 표현하기 -->
	<div class="row mb-3">
		<div class="col-12 mb-3">
			<table class="table table-bordered table " >
				<colgroup>
					<col width="30%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<tbody class="align-middle">
					<tr>
						<td rowspan="5"><img alt="meeting 대표 이미지" src="/resources/images/meeting/<%=meeting.getImageName() %>"
									class="img-thumbnail"/></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><%=meeting.getCategory().getName() %></td>
<%
	if (meeting.getActualPeople() == meeting.getMaxPeople()) {
%>
						<th>인원수</th>
						<td ><span class="text-decoration-line-through">
							<%=meeting.getActualPeople() %> / <%=meeting.getMaxPeople() %> 명</span>
										<strong style="color:red;">마감</strong></td>
<%
	} else {
%>
						<th>인원수</th>
						<td ><%=meeting.getActualPeople() %> / <%=meeting.getMaxPeople() %> 명</td>
<%
	}
%>
					</tr>
					<tr>
						<th>지역</th>
						<td><%=meeting.getAddress() %></td>
<%
	if (meeting.getPrice() == meeting.getDiscountPrice() || meeting.getDiscountPrice() == 0) {
%>
						<th>모임 가격</th>
						<td><%=meeting.getPrice() %>원</td>
<%
	} else if (meeting.getPrice() > meeting.getDiscountPrice()) {
%>
						<th>모임 가격</th>
						<td><span class="text-decoration-line-through"><%=meeting.getPrice() %></span>
							<span style="color:red; bold"><%=meeting.getDiscountPrice() %></span> 원</td>
<%
	}
%>
					</tr>
					<tr>
						<th>일정</th>
						<td><%=DateUtils.toText(meeting.getStartDate()) %> ~ <%=DateUtils.toText(meeting.getEndDate()) %></td>
						<th>모임 평점</th>
						<td><%=meeting.getScoreAverage() %></td>
					</tr>
					<tr>
						<th colspan="1">호스트</th>
						<td colspan="3">
							<div class="d-flex justify-content-start">
								<a href="/user/profile.jsp?userNo=<%=meeting.getUser().getNo() %>">
									<img class="m-1" alt="호스트 이미지" src="/resources/images/user/<%=meeting.getUser().getFilename() %>"
											style="width:50px"/>
								</a>
								<div class="ms-3 mt-1">
									<div><%=meeting.getUser().getNickname() %> 님</div>
									<div><%=StringUtils.withBr(meeting.getUser().getContent()) %></div>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		<hr>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
		<!-- 찜, 참여신청, 문의 버튼 -->
			<div class="bg-light p-3 mb-3 ">
				<%=StringUtils.withBr(meeting.getContent()) %>
			</div>
			<div id="map" style="width: 100%; height:400px;" data-lat="<%=meeting.getLatitude() %>" data-lon="<%=meeting.getLongitude() %>">
			
			</div>
			<div class="text-center mt-3">
<%
	// 로그인 유저가 없을 경우 로그인 alert 
	if (loginUser == null) {
%>
				<button class="btn btn-outline-success" type="button" onclick="loginAlert()">
					찜 <span class="badge text-bg-success"><%=meeting.getWishCnt() %></span></button>
<%
	// 로그인유저가 호스트인 경우 찜 불가 alert
	} else if (loginUser.getNo() == meeting.getUser().getNo()) {
%>
				<button class="btn btn-outline-success" type="button" onclick="wishAlert()">
					찜 <span class="badge text-bg-success"><%=meeting.getWishCnt() %></span></button>
<%
	// 일반사용자인 경우
	} else {
		UserDao userDao = new UserDao();
		User user = userDao.getUserByNo(loginUser.getNo());
		
		WishDao wishDao = new WishDao();
		Wish wish = new Wish();
		wish.setMeeting(meeting);
		wish.setUser(user);
		
		Wish savedWish = wishDao.getWish(wish);
		
		// 이미 찜을 한 적이 있으면 찜 버튼 outline 없이 색 채워서 표시
		if (savedWish != null) {
%>
				<a class="btn btn-success " href="insertWish.jsp?meetNo=<%=meetNo%>&page=<%=currentPage%>">
					찜 <span class="badge text-bg-success"><%=meeting.getWishCnt() %></span></a>
<%			
		// 찜한 적 없으면 찜 버튼 outline버튼으로 표시
		} else {
%>
				<a class="btn btn-outline-success" href="insertWish.jsp?meetNo=<%=meetNo%>&page=<%=currentPage%>">
					찜 <span class="badge text-bg-success"><%=meeting.getWishCnt() %></span></a>
					
<%
			
		}
	}

	//참여하기 버튼 alert 부분
	if (loginUser == null) {
%>
				<!-- 로그인 안 했으면 로그인 alert 보내기 -->
				<button class="btn btn-primary" type="button" onclick="loginAlert()">참여 신청 <i class="bi bi-credit-card"></i></button>
<%
	// 로그인한 경우
	} else {
		// 신청내역 존재하는지 확인하는 savedApply 획득
		ApplyUserDao applyUserDao = new ApplyUserDao();

		User user = new User();
		user.setNo(loginUser.getNo());
		
		ApplyUser applyUser = new ApplyUser();
		applyUser.setMeeting(meeting);
		applyUser.setUser(user);
		
		ApplyUser savedApply = applyUserDao.getApplyByApplyUser(applyUser);
		
		// 로그인 유저가 호스트면 host면 참여 신청 불가 alert
		if(meeting.getUser().getNo() == loginUser.getNo()) {
%>
				<button class="btn btn-primary" type="button" onclick="applyAlert('host')">참여 신청 <i class="bi bi-credit-card"></i></button>
<%
		// 신청내역이 있으면 이미 신청했다는 alert
		} else if (savedApply != null) {
%>	
				<button class="btn btn-primary" type="button" onclick="applyAlert('exist')">참여 신청 <i class="bi bi-credit-card"></i></button>
<%
		// 모임이 다 찼을경우 마감 alert
		} else if(meeting.getActualPeople() == meeting.getMaxPeople()) {
%>
				<button class="btn btn-primary" type="button" onclick="applyAlert('full')">참여 신청 <i class="bi bi-credit-card"></i></button>
<%
		// 참여 신청 링크
		} else {
%>
				<a class="btn btn-primary " href="/payments/form.jsp?meetNo=<%=meeting.getNo() %>">
					참여 신청 <i class="bi bi-credit-card"></i>
				</a>
<%
		}
	}
%>
				<a class="btn btn-warning" >문의 <i class="bi bi-question-circle"></i></a>
			</div>
			<div class="text-end" >
				<!-- 공유, 목록버튼 -->
				<a id="kakaotalk-sharing-btn" href="javascript:shareMessage()">
				  <button class="btn btn-warning" >공유
				  	<img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
   						 alt="카카오톡 공유 보내기 버튼" height="25px"/>
   					</button>
				</a>
				<a class="btn btn-secondary"  href="list.jsp?page=<%=currentPage %>">목록</a>
			</div>
		</div>
	</div>

	<div class="row mb-3">
		<div class="col-12 mb-3">
		<hr>
			<h5>댓글</h5>
			<form class="border bg-light p-3 mb-3"
				method="post"
				action="insertReply.jsp"
				onsubmit="checkContent(event)">
				<input type="hidden" name="meetNo" value="<%=meeting.getNo() %>">
				<input type="hidden" name="page" value="<%=currentPage %>">
				<div class="row">
					<div class="col-sm-11">
						<textarea rows="2" class="form-control" name="content" placeholder="댓글을 입력하세요."></textarea>
					</div>
<%
	// 로그인하지 않은 경우 댓글 작성 불가, loginAlert() 보내기
	if(loginUser == null) {
%>
					<div class="col-sm-1 ">
						<button type="button" class="btn btn-outline-primary" onclick="loginAlert()">등록</button>
					</div>
<%
	// 로그인한 경우 등록버튼 활성화
	} else {
%>
					<div class="col-sm-1 ">
						<button type="submit" class="btn btn-outline-primary">등록</button>
					</div>
<%
	}
%>
				</div>
			</form>
		</div>
	</div>
			
	<div class="row">
		<div class="col-12">
<%
	MeetingReplyDao meetingReplyDao = new MeetingReplyDao();
	
	// 댓글 리스트 가져오기
	List<MeetingReply> meetReplyList = meetingReplyDao.getMeetingReplies(meeting.getNo());
	
	// 댓글 하나씩 나타내는 for문
	for(MeetingReply meetingReply : meetReplyList) {
		// 버튼 표시 기본값 false로 설정하길
		boolean showDelBtn = false;
		boolean showModifyBtn = false;
		boolean showDangerBtn = false;
%>
			<div class="card mb-3">
				<div class="card-header">
					<span style="font-weight:bold"><%=meetingReply.getUser().getNickname() %></span>
					<small><%=DateUtils.toText(meetingReply.getUpdatedDate()) %></small>
<%
		if (loginUser == null) {
			// 로그인하지 않은 사용자일 경우 로그인요청 알림을 보낸다.
%>
					<button class="btn btn-outline-danger btn-sm float-end " type="button" onclick="loginAlert()">🚨</button>
<% 
		} else if (loginUser.getNo() == meetingReply.getUser().getNo()) {
			// 로그인한 사용자가 댓글 작성자인 경우
			showDelBtn = true;
			showModifyBtn = true;
		} else if(loginUser.getNo() == 100001 || loginUser.getNo() == meeting.getUser().getNo()) {
			// 로그인한 사용자가 관리자일 경우
			// 로그인한 사용자가 모임 호스트인 경우
			showDelBtn = true;
		} else if (loginUser.getNo() != meetingReply.getUser().getNo()) {
			// 로그인한 사용자가 일반 사용자일 경우
			showDangerBtn = true;
		}
		
		if (showDelBtn) {
%>
					<!-- 삭제버튼이 true인 경우 삭제버튼 보이게 -->
					<a href="deleteReply.jsp?meetNo=<%=meeting.getNo() %>&replyNo=<%=meetingReply.getNo() %>&page=<%=currentPage%>"
						class="btn btn-danger btn-sm float-end ms-1"><i class="bi bi-trash"></i>
					</a>
<%
		}
		if (showModifyBtn) {
%>
					<!-- 수정버튼이 true인 경우 수정버튼 보이게 -->
					<button type="button" onclick="toggleReplyUpdateForm(<%=meetingReply.getNo() %>)"
						class="btn btn-warning btn-sm float-end "><i class="bi bi-eraser"></i>
					</button>
<%
		}
		if (showDangerBtn) {
%>
					<!-- 신고버튼이 true인 경우 신고버튼 보이게 -->
					<a href="insertReplyDangerCnt.jsp?meetNo=<%=meeting.getNo() %>&page=<%=currentPage%>&replyNo=<%=meetingReply.getNo() %>"
						class="btn btn-outline-danger btn-sm float-end">🚨
					</a>
<%
		}
%>
				</div>
				<div class="card-body ">
<%		// 신고된 댓글인 경우
		if(meetingReply.getDangerCount() >= 5) {%>
					<p class="card-text">신고된 댓글입니다.</p>
<%		} else {%>
					<p class="card-text ">
						<%=StringUtils.withBr(meetingReply.getContent()) %>
					</p>
<%
		// 댓글 좋아요부분 시작. 로그인하지 않은 경우 loginAlert()
		if (loginUser == null) {
%>
					<button class="btn" type="button" onclick="loginAlert()" style="text-decoration:none;color:red;padding:0;">
					<i class="fa-regular fa-heart"></i>
					</button>
					<span><%=meetingReplyDao.getLikes(meetingReply.getNo())%></span>
<%
		// 로그인한 유저인 경우
		} else {
			UserDao userDao = new UserDao();
			User user = userDao.getUserByNo(loginUser.getNo());
			
			// 댓글 좋아요 내역 조회
			MeetingReplyLike meetReplyLike = new MeetingReplyLike();
			meetReplyLike.setMeetingReply(meetingReply);
			meetReplyLike.setUser(user);
			MeetingReplyLike savedMeetReplyLike = meetingReplyDao.getLike(meetReplyLike);
			
			// 댓글 좋아요한 내역이 있다면 하트가 채워진 하트로 표시
			if (savedMeetReplyLike != null) {
%>
					<a href="insertReplyLike.jsp?meetNo=<%=meetNo %>&page=<%=currentPage%>&replyNo=<%=meetingReply.getNo()%>"
						style="text-decoration:none;color:red;">
					<i class="fa-solid fa-heart"></i></a>
<%
			// 댓글 좋아요 내역이 없을 경우 빈 하트로 표시
			} else {
%>
					<a href="insertReplyLike.jsp?meetNo=<%=meetNo %>&page=<%=currentPage%>&replyNo=<%=meetingReply.getNo()%>"
						style="text-decoration:none;color:red;">
					<i class="fa-regular fa-heart"></i></a>
<%
			}
%>					<!-- 좋아요수 표시 -->
					<span><%=meetingReplyDao.getLikes(meetingReply.getNo())%></span>
<%
		}
%>
<%
		}
%>
					<!-- 댓글 수정폼 -->
					<form class="border bg-light p-3 mb-3 d-none"
						id="form-update-reply-<%=meetingReply.getNo() %>"
						method="post"
						action="modifyReply.jsp"
						onsubmit="checkContent(event)">
						<input type="hidden" name="meetNo" value="<%=meeting.getNo() %>">
						<input type="hidden" name="replyNo" value="<%=meetingReply.getNo() %>">
						<div class="row mb-3">

							<div class="col-sm-11">
								<textarea rows="2" class="form-control" name="content"><%=StringUtils.withBr(meetingReply.getContent()) %></textarea>
							</div>
							<div class="col-sm-1 ">
								<button type="submit" class="btn btn-outline-primary" >수정</button>
							</div>
						</div>
					</form>
<%
		List<MeetingReply> meetReReplyList = meetingReplyDao.getReReplies(meetingReply.getNo());

		// 대댓글 리스트 조회
		for (MeetingReply meetingReReply : meetReReplyList) {
%>
					<!-- 대댓글 작성자 나타내는 부분 -->
					<div class="card mt-3">
						<div class="card-header">
							<span style="font-weight:bold"><%=meetingReReply.getUser().getNickname() %></span>
							<small><%=DateUtils.toText(meetingReReply.getUpdatedDate()) %></small>
<%
			// 대댓글 수정 삭제 신고버튼 기본값 false로 설정
			boolean showDelBtnRe = false;
			boolean showModifyBtnRe = false;
			boolean showDangerBtnRe = false;
			
			if (loginUser == null) {
%>
							<!-- 로그인하지 않은 사용자일 경우 로그인요청 알림을 보낸다. -->
							<button class="btn btn-outline-danger btn-sm float-end " type="button" onclick="loginAlert()">🚨</button>
<%				
			} else if (loginUser.getNo() == meetingReReply.getUser().getNo()) {
				// 로그인한 사용자가 대댓글 작성자인 경우
				showDelBtnRe = true;
				showModifyBtnRe = true;
			} else if(loginUser.getNo() == 100001 || loginUser.getNo() == meeting.getUser().getNo()) {
				// 로그인한 사용자가 관리자일 경우
				// 로그인한 사용자가 모임 호스트인 경우
				showDelBtnRe = true;
			} else if (loginUser.getNo() != meetingReReply.getUser().getNo()) {
				// 로그인한 사용자가 일반 사용자일 경우
				showDangerBtnRe = true;
			}
			if (showDelBtnRe) {
%>
							<a href="deleteReply.jsp?meetNo=<%=meeting.getNo() %>&page=<%=currentPage%>&replyNo=<%=meetingReReply.getNo() %>"
								class="btn btn-danger btn-sm float-end ms-1"><i class="bi bi-trash"></i>
							</a>
<%
			}
			if (showModifyBtnRe) {
%>								
							<button type="button" onclick="toggleReplyUpdateForm(<%=meetingReReply.getNo() %>)"
								class="btn btn-warning btn-sm float-end "><i class="bi bi-eraser"></i>
							</button>
<%
			}
			if (showDangerBtnRe) {
%>
							<a href="insertReplyDangerCnt.jsp?meetNo=<%=meeting.getNo() %>&page=<%=currentPage%>&replyNo=<%=meetingReReply.getNo() %>"
								class="btn btn-outline-danger btn-sm float-end " 
								>🚨
							</a>
<%
}
%>
						</div>
						<!-- 대댓글 내용부분 -->
						<div class="card-body">
<%			if(meetingReReply.getDangerCount() >= 5) { %>
							<p class="card-text">신고된 댓글입니다.</p>
<%			} else {%>
							<p class="card-text">
							<%=StringUtils.withBr(meetingReReply.getContent())%>
							</p>
<%
				// 대댓글 좋아요 부분
				if (loginUser == null) {
%>
							<button class="btn" type="button" onclick="loginAlert()" style="text-decoration:none;color:red;padding:0;">
								<i class="fa-regular fa-heart"></i>
								</button>
							<span><%=meetingReplyDao.getLikes(meetingReReply.getNo())%></span>
<%
				} else {
					UserDao userDao = new UserDao();
					User user = userDao.getUserByNo(loginUser.getNo());
					
					MeetingReplyLike meetReReplyLike = new MeetingReplyLike();
					meetReReplyLike.setMeetingReply(meetingReReply);
					meetReReplyLike.setUser(user);
					MeetingReplyLike savedMeetReReplyLike = meetingReplyDao.getLike(meetReReplyLike);
					if (savedMeetReReplyLike != null) {
%>
							<a href="insertReplyLike.jsp?meetNo=<%=meetNo %>&page=<%=currentPage%>&replyNo=<%=meetingReReply.getNo()%>"
								style="text-decoration:none;color:red;">
							<i class="fa-solid fa-heart"></i></a>
<%
					} else {
%>
							<a href="insertReplyLike.jsp?meetNo=<%=meetNo %>&page=<%=currentPage%>&replyNo=<%=meetingReReply.getNo()%>"
								style="text-decoration:none;color:red;">
							<i class="fa-regular fa-heart"></i></a>
<%
					}
%>
							<span><%=meetingReplyDao.getLikes(meetingReReply.getNo())%></span>
<%
				}
			}
%>
							<!-- 대댓글 수정폼 toggle로 눌렀을 때 나타나게 표현 -->
							<form class="border bg-light p-3 my-2 d-none"
								id="form-update-reply-<%=meetingReReply.getNo() %>"
								method="post"
								action="modifyReply.jsp"
								onsubmit="checkContent(event)">
								<input type="hidden" name="meetNo" value="<%=meeting.getNo() %>">
								<input type="hidden" name="replyNo" value="<%=meetingReReply.getNo() %>">
								<div class="row me-1">
									<div class="col-11">
										<textarea rows="2" class="form-control" name="content"><%=StringUtils.withBr(meetingReReply.getContent()) %></textarea>
									</div>
<%
	if(loginUser == null) {
%>
									<div class="col-sm-1 ">
										<button type="button" class="btn btn-outline-primary" onclick="loginAlert()">수정</button>
									</div>
<%
	} else {
%>
									<div class="col-1 ">
										<button type="submit" class="btn btn-outline-primary" >수정</button>
									</div>
<%
	}
%>
								</div>
							</form>
						</div>
					</div>
<%
		}
%>
					<!-- 대댓글 입력폼 -->
					<form class="border bg-light p-3 mt-3"
						method="post"
						action="insertReReply.jsp"
						onsubmit="checkContent(event)">
						<input type="hidden" name="meetNo" value="<%=meeting.getNo() %>">
						<input type="hidden" name="partentsReply" value="<%=meetingReply.getNo() %>">
						<input type="hidden" name="page" value="<%=currentPage %>">
						<div class="row me-1">
							<div class="col-sm-11">
								<textarea rows="2" class="form-control" name="content" placeholder="댓글을 입력하세요."></textarea>
							</div>
<%
	if(loginUser == null) {
%>
							<div class="col-sm-1 ">
								<button type="button" class="btn btn-outline-primary" onclick="loginAlert()">수정</button>
							</div>
<%
	} else {
%>
							<div class="col-sm-1 ">
								<button type="submit" class="btn btn-outline-primary" >등록</button>
							</div>
<%
	}
%>
						</div>
					</form>
				</div>
			</div>
<%
	}
%>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-12">
			<h5>다른 모임 추천</h5>
			<div class="row mb-3 p-2 justify-content-between">
<%
	List<Meeting> meetingList = meetingDao.getRecommendMeetings("like", 1, 4);
	for (Meeting recommendMeeting : meetingList) {
%>
				<div class="card col-3 m-1" style="width: 23%;" >
					<div class="card-header ">
						<a href="detail.jsp?meetNo=<%=recommendMeeting.getNo() %>&page=<%=currentPage %>" style="text-decoration-line:none;">
							<img src="/resources/images/meeting/<%=recommendMeeting.getImageName() %>" class="img-fluid" alt="모임대표 이미지"
								style="height: 100%;">
						</a>
					</div>
					<div class="card-body">
						<a href="detail.jsp?meetNo=<%=recommendMeeting.getNo() %>&page=<%=currentPage %>" style="text-decoration-line:none;">
							<strong class="text-black"><%=StringUtils.withBr(recommendMeeting.getContent()) %></strong>
						</a>
					</div>
				</div>
<%
	}
%>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8969454c0c7cb8ee61ed937eb735f33c&libraries=services"></script>
<script type="text/javascript" src="https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js"
integrity="sha384-6MFdIr0zOira1CHQkedUqJVql0YtcZA1P0nbPrQYJXVJZUkTk/oX4U9GhUIs3/z8" crossorigin="anonymous"></script>
<script>
  Kakao.init('8969454c0c7cb8ee61ed937eb735f33c'); // 사용하려는 앱의 JavaScript 키 입력
</script>
<script>

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var lat = container.getAttribute("data-lat")
	var lon = container.getAttribute("data-lon")
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(lat, lon), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	 //지도 생성 및 객체 리턴
	var map = new kakao.maps.Map(container, options);
	 
	 // 마커가 표시될 위치
	var markerPosition  = new kakao.maps.LatLng(lat, lon);
	 
	// 마커 생성
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	
	// 댓글수정폼 toggle
	function toggleReplyUpdateForm(replyNo) {
		document.getElementById("form-update-reply-" + replyNo).classList.toggle('d-none');
	}
	
	function loginAlert() {
		alert('로그인이 필요한 서비스입니다.');
	}
	
	function wishAlert() {
		alert('호스트인 모임은 찜할 수 없습니다.');
	}
	
	// 댓글 내용이 없을 경우 alert
	function checkContent(event) {
		let form = event.target;
		let content = form.querySelector("textarea").value;
		if (content === "") {
			event.preventDefault();
			alert("내용을 입력하세요");
			return;
		}
	}
	
	// 참여신청 관련 alert
	function applyAlert(alertType) {
		if (alertType === 'full'){
			alert('참여가능 인원이 마감되었습니다.');
		}
		if (alertType === 'exist'){
			alert('이미 참여신청한 모임입니다.');
		}
		if (alertType === 'host'){
			alert('호스트인 모임은 참여신청할 수 없습니다.');
		}
	}
	
	// 카카오 공유하기
	function shareMessage() {
		Kakao.Share.sendDefault({
			objectType: 'feed',
			content: {
				title: '<%=StringUtils.escape( meeting.getTitle())%>',
				description: '<%=StringUtils.escape( meeting.getContent())%>',
				imageUrl:
					'https://ifh.cc/g/00wCVh.jpg',
				link: {
					// [내 애플리케이션] > [플랫폼] 에서 등록한 사이트 도메인과 일치해야 함
					mobileWebUrl: 'http://localhost/meeting/detail.jsp?meetNo=<%=meeting.getNo()%>',
					webUrl: 'http://localhost/meeting/detail.jsp?meetNo=<%=meeting.getNo()%>',
				},
			},
			social: {
				likeCount: <%=meeting.getWishCnt()%>,
				viewCount: <%=meeting.getViewCnt()%>,
			},
			buttons: [
				{
				title: '웹으로 보기',
				link: {
					mobileWebUrl: 'http://localhost/meeting/detail.jsp?meetNo=<%=meeting.getNo()%>',
					webUrl: 'http://localhost/meeting/detail.jsp?meetNo=<%=meeting.getNo()%>',
				},
			},
	     ],
	   });
	}

</script>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>