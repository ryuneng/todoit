<%@page import="java.util.Date"%>
<%@page import="dao.HostDao"%>
<%@page import="dto.MeetingStatusDto"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.NumberUtils"%>
<%@page import="dto.Pagination"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Meeting"%>
<%@page import="dao.MeetingDao"%>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
<jsp:include page="/include/navbar.jsp">
    <jsp:param value="홈" name="menu"/>
</jsp:include>

<title>TODOIT</title>

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

    th, td {
        text-align: center;
    }
</style>
</head>
<body>
<%
    int currentPage = NumberUtils.toInt(request.getParameter("page"), 1);

    // 모임 라디오버튼 
    String full = request.getParameter("full");

    // 로그인한 사용자 정보 가져오기
    LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

    // 모임 조회에 필요한 맵 객체 생성
    Map<String, Object> param = new HashMap<>();
    param.put("userNo", loginUser.getNo());
    if (full != null && !full.isBlank()) {
        param.put("full", full);
    }

    MeetingDao meetingDao = new MeetingDao();

    // 전체 모임 수 조회
    int totalRows = meetingDao.getTotalRows(param);

    // 페이지네이션 객체 생성
    Pagination pagination = new Pagination(currentPage, totalRows);
    param.put("begin", pagination.getBegin());
    param.put("end", pagination.getEnd());

    // 페이지에 따른 모임 목록 조회
    List<Meeting> meetingList = meetingDao.getMeetings(param);

    HostDao hostDao = new HostDao();

    // 사용자의 모임 현황 조회
    MeetingStatusDto status = hostDao.getMeetingStatus(loginUser.getNo());
    
    // 사용자의 모임 상세 정보 조회
    List<Meeting> statusDetailList = meetingDao.getMeetingsByUserNo(loginUser.getNo());
%>

<%

%>
<div class="container">
    <div class="row">
        <div class="col-12">
            <h4>나의 개설모임</h4>
        </div>
    </div>
    <!-- 상단 메뉴 -->
    <div class="row bg-light mb-3">
        <div class="col-6 offset-3">
            <div class="d-flex justify-content-evenly mt-4 mb-3">
                <div class="text-center">
                    <div class="rounded-circle p-3 bg-white text-center mb-2 position-relative" id="notificationIcon">
                        <a href="/host/notice.jsp" class="text-dark"><i class="bi bi-alarm display-3"></i></a>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            99+
                            <span class="visually-hidden">unread messages</span>
                        </span>
                    </div>
                    <span>알림</span>
                </div>
                <div class="text-center">
                    <div class="rounded-circle p-3 bg-white text-center mb-2">
                        <a href="../meeting/form.jsp" class="text-dark"><i class="bi bi-person-plus display-3"></i></a>
                    </div>
                    <span>모임생성</span>
                </div>
                <div class="text-center">
                    <div class="rounded-circle p-3 bg-white text-center mb-2">
                        <a href="ddd.jsp" class="text-dark"><i class="bi bi-chat-dots display-3"></i></a>
                    </div>
                    <span>채팅</span>
                </div>
                <div class="text-center">
                    <div class="rounded-circle p-3 bg-white text-center mb-2">
                        <a href="/host/calendar.jsp" class="text-dark"><i class="bi bi-calendar-check display-3"></i></a>
                    </div>
                    <span>달력</span>
                </div>
            </div>
        </div>
    </div>
    <!-- 모임 상태 라디오 -->
    <div class="row mb-3">
        <div class="col-12">
            <form id="form-status" method="get" action="management.jsp">
                <div class="form-check form-check-inline mt-3">
                    <input class="form-check-input" type="radio" name="full"  value="" <%=full == null || full.isEmpty() ? "checked" : "" %> onchange="refreshList('')">
                    <label class="form-check-label" >전체</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="full"  value="N" <%="N".equals(full) ? "checked" : "" %> onchange="refreshList('N')">
                    <label class="form-check-label" >진행중 모임</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="full"  value="Y" <%="Y".equals(full) ? "checked" : "" %>  onchange="refreshList('Y')">
                    <label class="form-check-label" >마감된 모임</label>
                </div>
            </form>
        </div>
    </div>
    <!-- 모임 리스트 -->
    <div class="row">
        <div class="col-12">
            <table class="table" style="border-collapse: collapse; border: 1px solid #eee;">
                <tbody>
<%
	if (meetingList.isEmpty()) {
%>
                        <tr>
                            <td colspan="3" class="text-center">모임 정보가 없습니다.</td>
                        </tr>
<% } else {
    	for (Meeting meeting : meetingList) {
    	boolean isfull = "Y".equals(meeting.getFull());
%>
                        <tr>
                            <td><img src="/resources/images/meeting/<%=meeting.getImageName() %>" style="margin-right: 10px;" alt="..." width="120" height="100"></td>
                            <td style="text-align: start;">
                                <div>
                                    <span style="<%= isfull ? "background-color: #e66a77;" : "background-color: #6cb2e4;" %> color: white; padding: 1px 8px; border-radius: 4px; margin-right: 10px;">
                                        <%= isfull ? "마감" : "진행중" %>
                                    </span>
                                    <span><%= meeting.getTitle() %></span>
                                </div>
                                <div style="margin-top: 50px;">
                                    <span style="margin-right: 10px;">개설일: <%=DateUtils.toTextKorean(meeting.getCreatedDate()) %></span>
                                    <span>모임기간: <%=DateUtils.toTextKorean(meeting.getStartDate()) %> ~ <%=DateUtils.toTextKorean(meeting.getEndDate()) %></span>
                                </div>
                            </td>
                            <td style="vertical-align: middle;"><div class="d-flex justify-content-center"><a href="/host/managementDetail.jsp?meetingNo=<%=meeting.getNo()%>"><button class="btn btn-outline-primary btn-sm">모임관리</button></a></div></td>
                        </tr>
 <% 
 		}
 	}
 %>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 페이지네이션 -->
    <div class="row">
        <div class="col-12">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
 <%
 	if (pagination.isFirst()) {
 %>
                        <li class="page-item"><a class="page-link disabled" >이전</a></li>
<% 
	} else {
%>
                        <li class="page-item"><a class="page-link" href="management.jsp?page=<%=currentPage - 1 %>">이전</a></li>
<%
	}
%>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
                        <li class="page-item <%= num == currentPage ? "active" : "" %>"><a class="page-link" href="management.jsp?page=<%=num%>"><%=num %></a></li>
<%
	}
%>
<%
	if (pagination.isLast()) {
%>
                        <li class="page-item"><a class="page-link disabled" >다음</a></li>
<%
	} else {
%>
                        <li class="page-item"><a class="page-link" href="management.jsp?page=<%=currentPage + 1 %>">다음</a></li>
<%
}
%>
                </ul>
            </nav>
        </div>
    </div>
    <!-- 모임 현황 -->
    <div class="row mt-5">
        <div class="col-12">
            <h4>모임 현황</h4>
            <table class="table table-bordered mb-5" style="table-layout: fixed; width: 100%;">
                <thead>
                    <tr class="table-secondary">
                        <th style="width: 33.33%;">모임 수</th>
                        <th style="width: 33.33%;">결제 금액</th>
                        <th style="width: 33.33%;">참여자 수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="text-align: center;">
                            <div style="padding: 25px;"><%=status.getMeetingCnt() %></div>
                        </td>
                        <td style="text-align: center;">
                            <div style="padding: 25px;"><%=status.getTotalPrice() %></div>
                        </td>
                        <td style="text-align: center;">
                            <div style="padding: 25px;">총 <%=status.getUserCnt() %>명</div>
                        </td>
                    </tr>
                    <tr class="table-secondary">
                        <td colspan="3" style="text-align: center;">
                            <a href="#" id="showModalBtn" style="text-decoration: none; color: black;">모임 현황 자세히보기</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 모임 현황 모달 -->
<div id="myModal" class="modal" tabindex="-1">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">모임 현황</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr class="table-secondary">
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col">결제총액</th>
                            <th scope="col">총신청자수</th>
                            <th scope="col">페이지뷰</th>
                        </tr>
                    </thead>
                    <tbody>
<%
	int count = 1;
    for (Meeting meeting : statusDetailList) {
%>
                            <tr>
                                <th scope="row"><%=count++ %></th>
                                <td>
                                    <img src="/resources/images/meeting/<%=meeting.getImageName() %>" style="margin-right: 10px;" class="float-start" alt="..." width="50" height="50">
                                    <p><%=meeting.getTitle() %></p>
                                </td>
                                <td><%=meeting.getTotalPayPrice() %>원</td>
                                <td><%=meeting.getActualPeople() %>명</td>
                                <td><%=meeting.getViewCnt() %></td>
                            </tr>
<%
	}
%>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    // 모달 창 표시 함수
    document.getElementById("showModalBtn").addEventListener("click", function() {
        var myModal = new bootstrap.Modal(document.getElementById('myModal'), {
            keyboard: false
        });
        myModal.show();
    });

    // 모임 상태 변경 함수
    function refreshList(isFull) {
        location.href = "management.jsp?full=" + isFull;
    }
</script>

<jsp:include page="/include/footer.jsp">
    <jsp:param value="meeting" name="menu"/>
</jsp:include>
</body>
</html>
