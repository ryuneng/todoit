<%@page import="utils.DateUtils"%>
<%@page import="vo.Meeting"%>
<%@page import="java.util.List"%>
<%@page import="dao.HostDao"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.css" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8969454c0c7cb8ee61ed937eb735f33c&libraries=services"></script>
<jsp:include page="/include/navbar.jsp">
    <jsp:param value="홈" name="menu"/>
</jsp:include>

<title>호스트 모임관리 달력페이지</title>

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

.category-section2 {
    margin-top: 30px; 
}
  
</style>
</head>
<body>
<%
    LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
    HostDao hostDao = new HostDao();
    List<Meeting> meetingList = hostDao.getHostCalendar(loginUser.getNo());
%>

<div class="container" style="max-width: 800px">
    
    <div class="row">
        <div class="col-12 ">
            <div class="category-section2" >
                <h3 class="best meeting category mb-2">
                    <i class="bi bi-calendar-check display-3" style="margin-right: 10px;"></i>
                    모임 일정 달력
                </h3> 
            </div>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-12">
            <div id="calendar"></div>
        </div>
    </div>
</div>
    
<div id="modal-event-detail" class="modal" tabindex="-1">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">일정정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h4 id="meeting-title"></h4>
                <ul>
                    <li>모임기간 : <span id="meeting-start"></span> ~ <span id="meeting-end"></span></li>
                    <li>모임장소 : <span id="meeting-address"></span></li>
                </ul>
                <div id="modal-map" style="width:100%;height:380px;"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

</body>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
<script>
$(document).ready(function() {

    // Bootstrap 5 모달 인스턴스 생성
    const eventDetailModal = new bootstrap.Modal(document.getElementById('modal-event-detail'));

    $('#calendar').fullCalendar({
        
        header: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        defaultView: 'month',
        locale: "ko",
        events: [
            // 서버에서 전송된 모임 데이터를 이곳에 추가
<%
    for (Meeting meeting : meetingList) {
%>
            {
                id: <%=meeting.getNo() %>,
                title: '<%=meeting.getTitle() %>',
                start: '<%=DateUtils.toText(meeting.getStartDate())%>',
                color: '#f9dada',
                extendedProps: {
                    start: '<%=DateUtils.toText(meeting.getStartDate())%>',
                    end: '<%=DateUtils.toText(meeting.getEndDate())%>',
                    address: '<%=meeting.getAddress()%>',
                    // 지도에 필요한 위도와 경도 데이터 추가
                    latitude: <%=meeting.getLatitude()%>,
                    longitude: <%=meeting.getLongitude()%>
                }
            },
<%
    }
%>
        ],
        eventClick: function(info) {
            let title = info.title;
            let start = info.extendedProps.start;
            let end = info.extendedProps.end;
            let address = info.extendedProps.address;
            let latitude = info.extendedProps.latitude;
            let longitude = info.extendedProps.longitude;

            document.getElementById("meeting-title").textContent = title;
            document.getElementById("meeting-start").textContent = start;
            document.getElementById("meeting-end").textContent = end;
            document.getElementById("meeting-address").textContent = address;

            // 모달 표시
            eventDetailModal.show();

            // 모달이 표시된 후 지도 로드
            $('#modal-event-detail').on('shown.bs.modal', function () {
                var mapContainer = document.getElementById('modal-map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                // 지도를 생성합니다
                var map = new kakao.maps.Map(mapContainer, mapOption);
            });
        }
    });
});
</script>

</html>
