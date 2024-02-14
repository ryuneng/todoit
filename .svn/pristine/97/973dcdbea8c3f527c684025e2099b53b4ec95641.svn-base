<%@page import="utils.DateUtils"%>
<%@page import="dto.MeetingNoticeDto"%>
<%@page import="dto.LoginUser"%>
<%@page import="dao.HostDao"%>
<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="홈" name="menu"/>
</jsp:include>
<title>Insert title here</title>
</head>
<body>
<div class="container" style="max-width: 900px; padding-bottom: 300px;">
	<div class="row">
		<div class="col-12">
		</div>
	</div>
	<div class="row">
		<div class="col-6 mb-3">
			<h3 class="best meeting category">
    			<i class="bi bi-alarm display-3" style="margin-right: 10px;"></i>
    			최근 알림 
			</h3> 
		</div>
		
		
<%
	String cat = request.getParameter("cat");
	if (cat == null) {
		cat = "all";
	}
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	HostDao hostDao = new HostDao();
	List<MeetingNoticeDto> noticeList = null;
	if ("all".equals(cat)) {
		noticeList = hostDao.getAllNotices(loginUser.getNo());
	} else if ("apply".equals(cat)) {
		noticeList = hostDao.getApplyNotices(loginUser.getNo());
	} else if ("reply".equals(cat)) {
		noticeList = hostDao.getReplyNotices(loginUser.getNo());
	}
	
%>	
		
	    <div class="col-md-4 offset-3 mt-5 ms-auto mb-3">
	    	<form id="form-notice" method="get" action="notice.jsp">
		        <select class="form-select" name="cat" onchange="changeCat()">
		            <option value="all" <%="all".equals(cat) ? "selected" : "" %>>전체</option>
		            <option value="reply" <%="reply".equals(cat) ? "selected" : "" %>>댓글만</option>
		            <option value="apply" <%="apply".equals(cat) ? "selected" : "" %>>모임신청만</option>
		        </select>
	    	</form>
	    </div>
	</div>
	<div class="row">
<%
	if (noticeList.isEmpty()) {
%>
		<div class="col-12">
			<div class="border p-3">
				알림 내역이 존재하지 않습니다.
			</div>
		</div>		   

<%	
	} else  {
%>
		<div class="col-12">
			<div class="list-group" id="notice-list">
<%
		for (MeetingNoticeDto notice: noticeList) {
%>
				<a href="managementDetail.jsp?meetingNo=<%=notice.getNo() %>" class="list-group-item list-group-item-action" >
					<div class="d-flex w-100 justify-content-between align-items-center">
						<div class="d-flex align-items-center">
					   		<img src="/resources/images/meeting/<%=notice.getImageName() %>" class="rounded-circle me-2" alt="..." width="55px" height="55px" >
					    		<span class="visually-hidden">New alerts</span>
					  		</span>
					      	<h5 class="mb-1 me-2"><%=notice.getTitle() %></h5>
					      	<small><%=DateUtils.toTextMonthDay(notice.getDay())%></small>
					  	</div>
					    <small><i class="bi bi-three-dots-vertical"></i></small>
					</div>
<%
			if ("APPLY".equals(notice.getAlertType())) {
%>
					<p class="mb-1" style="margin-left: 65px;"><strong><%=notice.getNickname() %></strong>님이 가입신청했습니다.</p>
<%			
			} else if ("REPLY".equals(notice.getAlertType())){
%>
					<p class="mb-1" style="margin-left: 65px;"><strong><%=notice.getNickname() %></strong>님이 댓글을 작성했습니다.</p>
<%				
			}
%>
				</a>
<%
		}
	}
%>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function changeCat() {
		document.getElementById("form-notice").submit();
	}
</script>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
</html>