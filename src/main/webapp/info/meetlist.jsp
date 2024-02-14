<%@page import="vo.ApplyUser"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dto.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.NumberUtils"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Meeting"%>
<%@page import="dto.LoginUser"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.MeetingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>마이페이지::나의 참여모임 목록</title>
<style type="text/css">
.txt_line {
      width:250px;
      padding:0 5px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
  }

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
	//session 에서 loginuser 정보조회
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	String userId = loginUser.getId();
	int userNo = loginUser.getNo();

	int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);

	UserDao userDao = new UserDao();
	int totalRows = userDao.getMeetingTotalRows(userNo);


	Pagination pagination = new Pagination(currentPage, totalRows, 6);

	Map<String, Object> param = new HashMap<>();
	param.put("userNo", userNo);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());


	List<ApplyUser> userMeetingList = userDao.getMeetListByNo(param);



%>

<div class="container">
	<div class="row pt-4 mb-3">
		<div class="col-3">
			<jsp:include page="sidebar.jsp">
				<jsp:param value="meetlist" name="menu"/>
			</jsp:include>
		</div>
		<div class="col-9">
		<h1>나의 참여모임</h1>

<%
	if(userMeetingList.isEmpty()) {
%>
		<div>
			<h3 class="text-secondary">참여예정인 모임이 없습니다.</h3>
		</div>
<%
	} else {
%>


			<div class="cards" >
				<div class="row ">
<%
		for(ApplyUser applyUser : userMeetingList ) {
%>
					<div class="col-4">
						<div class="card h-100 m-1 b-1">
							<a href="/meeting/detail.jsp?meetNo=<%=applyUser.getMeeting().getNo() %>">
			            		<img src="/resources/images/meeting/meeting.jpg" class="card-img-top"/>
						 	</a>
		            		<div class="card-body">
		            			<a href="/meeting/detail.jsp?meetNo=<%=applyUser.getMeeting().getNo() %>" class="text-decoration-none ">
			              			<h5 class="fs-5 txt_line"><%=applyUser.getMeeting().getTitle() %></h5>
			              		</a>
				              	<div class="card-text">
				              		<p class="small" >
				              			<%=DateUtils.toTextKorean(applyUser.getMeeting().getStartDate()) %> ~ <%=DateUtils.toTextKorean(applyUser.getMeeting().getEndDate()) %>
				              		</p>
				              		<div class="row">
				              			<div class="col-6">
						              		<div class="small"><%=applyUser.getMeeting().getAddress() %></div>
							                <div class="small">모집현황 <%=applyUser.getMeeting().getActualPeople() %>/<%=applyUser.getMeeting().getMaxPeople() %> </div>
<%
		if (applyUser.getMeeting().getDiscountPrice() == 0) {
%>
											<div><strong class="text-danger"><%=applyUser.getMeeting().getPrice() %>원</strong></div>
<%
		} else {
%>
											<div class="text-decoration-line-through"><%=applyUser.getMeeting().getPrice() %>원</div>
											<div><strong class="text-danger"><%=applyUser.getMeeting().getDiscountPrice() %>원</strong></div>
<%
		}
%>
				              			</div>
				              			<div class="col-6 text-end">
<%
		if ("Y".equals(applyUser.getAccepted())) {
%>
						              		<span class="badge text-bg-primary">승인완료</span>
<%
		} else if("N".equals(applyUser.getAccepted())) {
%>
						              		<span class="badge text-bg-danger">승인거부</span>
<%
    	} else if ("W".equals(applyUser.getAccepted())) {
%>
											<span class="badge text-bg-secondary">승인대기중</span>
<%
    }
%>
				              			</div>
				              		</div>
				            	</div>
			            	</div>
			          	</div>
			        </div>
<%
		}
	}
%>
					<!-- 페이징처리 구간 -->
<%
	int beginPage = pagination.getBeginPage();
	int endPage = pagination.getEndPage();

	boolean isFrist = pagination.isFirst();
	boolean isLast = pagination.isLast();
%>
					<nav class="m-4">
						<ul class="pagination justify-content-center">
<%
   if (isFrist) {
%>
              				<li class="page-item disabled">
                 				 <a class="page-link">이전</a>
               				</li>
<%
   } else {
%>
               				<li class="page-item">
                 				<a class="page-link" href="meetlist.jsp?page=<%=currentPage - 1 %>">이전</a>
               				</li>
<%
   }
%>

<%
   for (int num = beginPage; num <= endPage; num++) {
%>
			               <li class="page-item <%=currentPage == num ? "active" : "" %>" >
			                  <a class="page-link" href="meetlist.jsp?page=<%=num %>"><%=num %></a>
			               </li>
<%
   }
%>

<%
   if(isLast) {
%>
			               <li class="page-item disabled">
			                  <a class="page-link">다음</a>
			               </li>
<%
   } else {
%>
			               <li class="page-item">
			                  <a class="page-link" href="meetlist.jsp?page=<%=currentPage + 1 %>">다음</a>
			               </li>
<%
   }
%>
            			</ul>
         			</nav>
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