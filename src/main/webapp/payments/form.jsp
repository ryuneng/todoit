<%@page import="dao.PointDao"%>
<%@page import="utils.NumberUtils"%>
<%@page import="vo.ApplyUser"%>
<%@page import="vo.Payment"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="vo.Meeting"%>
<%@page import="dao.MeetingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
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
<title>TODOIT :: 결제하기</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="payment" name="menu"/>
</jsp:include>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	// 요청파라미터값 조회
	int meetNo = NumberUtils.toInt(request.getParameter("meetNo"), 0);
	
	// meeting 관련 객체 생성
	MeetingDao meetingDao = new MeetingDao();
	Meeting meeting = meetingDao.getMeetingByNo(meetNo);
	
	// PointDao 생성 후 보유포인트 조회
	PointDao pointDao = new PointDao();
	int point = pointDao.getPointByUserNo(loginUser.getNo());
	
%>
<div class="container" style="width: 700px">
	<div class="row">
		<div class="col-12">
			<form class="justify-content-start border-0 bg-white ms-3" method="post" action="payment.jsp?meetNo=<%=meeting.getNo() %>">
				<h4 class="fw-bold p-3 mb-3 mt-3">모임 정보</h4>
				<!-- 모임 정보의 이미지~가격 부모 영역 -->
				<div class="d-flex justify-content-start pb-3">
					<!-- 이미지 영역 -->
					<a href="/meeting/detail.jsp?meetNo=<%=meeting.getNo() %>">
						<img alt="참여하기 대표 이미지" src="/resources/images/meeting/<%=meeting.getImageName() %>"
						     class="rounded mx-auto d-block img-thumbnail" width="200">
					</a>
					<!-- 지역~가격 부모 영역 -->
					<div class="ms-5">
						<small class="text-secondary"><%=meeting.getAddress() %></small>
						<h6 class="fw-bold mt-1" style="display: -webkit-box;
														overflow: hidden;
													    text-overflow: ellipsis;
													    -webkit-box-orient: vertical;
													    -webkit-line-clamp: 1;">
							<%=meeting.getTitle() %>
						</h6>
						<small><%=DateUtils.toTextKorean(meeting.getStartDate()) %> ~ <%=DateUtils.toTextKorean(meeting.getEndDate()) %></small>
<%
	if (meeting.getDiscountPrice() == 0) {
%>
						<p class="text-primary fw-bold mt-3"><%=NumberUtils.toCurrency(meeting.getPrice()) %>원</p>
<%
	} else {
%>
						<p class="text-secondary text-decoration-line-through mt-3 mb-1" style="font-size: 13px;">
							<%=NumberUtils.toCurrency(meeting.getPrice()) %>원
						</p>
						<p class="text-primary fw-bold"><%=NumberUtils.toCurrency(meeting.getDiscountPrice()) %>원</p>
<%
	}
%>
					</div>
				</div>
				<!-- 모임정보 끝 -->
				<hr>
				<h4 class="fw-bold p-3 mb-3">안내사항</h4>
				<div class="ms-3 pb-3">
					<p>1. 집결 시간 꼭 지켜주세요.</p>
					<p>2. 불가피한 사정으로 참여하지 못할 경우, 최소 2일 전 연락주세요.</p>
					<p>3. 참여자 간에 기본적인 매너 지켜주세요!</p>
				</div>
				<hr>
				<h4 class="fw-bold p-3 mb-3">결제수단</h4>
				<div class="d-flex align-items-center ms-3 pb-4">
					<input type="radio" name="payMethod" value="카카오페이" checked>
					<img src="/resources/images/payment/kakao_pay.png" class="ms-2" style="width:8%">
					<label class="ms-2 fw-bold">카카오페이</label>
				</div>
				<hr>
				<!-- 포인트 영역 시작 -->
				<h4 class="fw-bold p-3 mb-1">포인트</h4>
				<p class="ms-3 text-secondary text-start" style="font-size: 15px">
					보유 포인트 : 
					<span id="user-current-point"><%=NumberUtils.toCurrency(point) %></span> 점
				</p>
				<div class="form-group d-flex justify-content-start mb-3 ms-3 pb-3">
					<!-- name="usedPoint"를 통해 payment.jsp로 값 넘겨주기 -->
					<input type="text" class="form-control" name="usedPoint" id="input-point" onkeyup="checkValue()" style="width: 500px"/>
					<button type="button" class="btn btn-primary ms-3" onclick="applyPoint()"> 사용</button>
				</div>
				<hr>
				<!-- 하단 참여금액, 차감포인트 영역 시작 -->
				<div class="d-flex justify-content-between p-2">
					<div>
						<p class="text-secondary fw-bold">참여금액</p>
						<p class="text-secondary fw-bold">차감 포인트</p>
					</div>
					<div class="text-end">
<%
	Payment payment = new Payment();
	if (meeting.getDiscountPrice() == 0) {
%>
						<!-- 참여금액(할인가격 없을 때) -->
						<p class="text-secondary fw-bold">
							<span id="meeting-price"><%=NumberUtils.toCurrency(meeting.getPrice()) %></span> 원
						</p>
<%
	} else {
%>
						<!-- 참여금액(할인가격 있을 때) -->
						<p class="text-secondary fw-bold">
							<span id="meeting-price"><%=NumberUtils.toCurrency(meeting.getDiscountPrice()) %></span> 원
						</p>
<%
	}
%>
						<!-- 차감포인트 -->
						<p class="text-secondary fw-bold"><span id="used-point"><%=NumberUtils.toCurrency(payment.getUsedPoint()) %></span> 점</p>
					</div>
				</div>
				<!-- 총 결제금액 영역 시작 -->
				<div class="d-flex justify-content-between p-2 mb-5">
					<p class="fs-4 fw-bold">총 결제금액</p>
<%
	if (meeting.getDiscountPrice() == 0) {
%>
					<!-- 총 결제금액(할인가격 없을 때) -->
					<p class="fs-5 text-primary fw-bold">
						<!-- 
							1. hidden을 통해 payment.jsp로 값 넘겨주기
							2. value를 통해 사용하려는 포인트가 0이어도 결제금액이 넘어가도록 해주기
						-->
						<input type="hidden" name="price" id="hidden-pay-price" value="<%=meeting.getPrice()%>">
						<span id="pay-price"><%=NumberUtils.toCurrency(meeting.getPrice()) %></span>원
					</p>
<%
	} else {
%>
					<!-- 총 결제금액(할인가격 있을 때) -->
					<p class="fs-5 text-primary fw-bold">
						<input type="hidden" name="price" id="hidden-pay-price" value="<%=meeting.getDiscountPrice()%>">
						<span id="pay-price"><%=NumberUtils.toCurrency(meeting.getDiscountPrice()) %></span>원
					</p>
<%
	}
%>
				</div>
				<!-- 동의, 결제버튼 영역 시작 -->
				<div class="text-center text-secondary mb-3" style="font-size: 15px">위 내용을 모두 확인하였으며, 결제에 동의합니다.</div>
				<div class="text-center">
					<button type="submit" class="btn btn-primary mb-5" style="width: 100%">결제</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	// input-point에 숫자만 입력 가능하도록 해주는 함수(-도 불가)
	function checkValue(event) {
		let inputPointEl = document.getElementById("input-point");
		let value = inputPointEl.value;
		
		if (!/^[0-9]*$/.test(value)) {
			inputPointEl.value = "";
		}
	}

	// 결제금액 및 포인트 계산
	function applyPoint() {
		// 엘리먼트 조회
		let userPointEl = document.getElementById("user-current-point"); // 보유포인트
		let inputPointEl = document.getElementById("input-point");	     // 사용하려는 포인트
		let meetingPriceEl = document.getElementById("meeting-price");	 // 참여금액
		let usedPointEl = document.getElementById("used-point");		 // 차감포인트 
		let payPriceEl = document.getElementById("pay-price");		     // 총 결제금액
		
		// 계산에 사용될 변수 선언 및 엘리먼트값 대입(화면에 값 표시)
		let userPoint = userPointEl.textContent.replace(/,/g, ''); 		 // 보유포인트 (.replace(/,/g, '') : 숫자 천단위 콤마 표시)
		let inputPoint = inputPointEl.value;					   		 // 사용하려는 포인트(input은 .value로 엘리먼트값 획득 가능)
		let meetingPrice = meetingPriceEl.textContent.replace(/,/g, ''); // 참여금액
		
		// 천단위 콤마 표시 없이 계산된 값 받을 변수
		userPoint = parseInt(userPoint)						// 보유포인트 정수로 변환
		let usedPoint = parseInt(inputPoint);				// 차감포인트 = 사용하려는 포인트
		let payPrice = parseInt(meetingPrice - inputPoint); // 총결제금액 = 참여금액 - 사용하려는포인트
		
		// 사용하려는 포인트가 보유포인트보다 클 경우 입력 방지
		if (usedPoint > userPoint) {
			alert("보유포인트보다 큰 값을 입력할 수 없습니다.");
			inputPointEl.value = 0;
			return;
		}
		
		// 사용하려는 포인트가 참여금액보다 클 경우 입력 방지
		if (usedPoint > meetingPrice) {
			alert("사용포인트는 모임의 참여금액보다 클 수 없습니다.");
			inputPointEl.value = 0;
			return;
		}
		
		// 차감포인트가 NaN일 경우 0으로 처리하기(input에 빈문자열인 상태로 사용 눌렀을 경우)
		if (isNaN(usedPoint)) {
			usedPoint = 0;
		}
		
		// 계산된 값 최종 대입 후 new Number().toLocaleString() 으로 숫자 천단위 콤마 표시
		usedPointEl.textContent = new Number(usedPoint).toLocaleString();   // 차감포인트
		payPriceEl.textContent = new Number(payPrice).toLocaleString();		// 총결제금액
		
		// 계산된 결제금액을 payment.jsp로 넘겨주기
		document.getElementById("hidden-pay-price").value = payPrice;
	}
	
	// 엔터 시 submit 막는 이벤트(모든 엘리먼트에 적용됨)
	document.addEventListener('keydown', function(event) {
		if (event.keyCode === 13) {
	    	event.preventDefault();
		};
	}, true);
</script>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="payment" name="menu"/>
</jsp:include>
</body>
</html>