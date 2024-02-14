<%@page import="utils.NumberUtils"%>
<%@page import="dao.MeetingDao"%>
<%@page import="vo.Meeting"%>
<%@page import="vo.ApplyUser"%>
<%@page import="vo.Payment"%>
<%@page import="dao.PaymentDao"%>
<%@page import="dto.LoginUser"%>
<%@page import="utils.DateUtils"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
<title>TODOIT :: 결제완료</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="payment" name="menu"/>
</jsp:include>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	// 요청파라미터값 조회
	int applyNo = Integer.parseInt(request.getParameter("applyNo"));
	
	// 참여번호로 참여정보 및 결제정보 1건 조회
	PaymentDao paymentDao = new PaymentDao();
	ApplyUser applyUser = paymentDao.getApplyUserByNo(applyNo); // 참여정보 조회
	Payment payment = paymentDao.getPaymentByApplyNo(applyNo);  // 결제정보 조회
%>
<div class="container">
	<div class="row">
		<div class="col-12 text-center mb-5">
			<h1 class="mt-3 pt-5 mb-5" style="font-size: 60px">
				<i class="bi bi-check-circle-fill text-primary"></i>
			</h1>
			<div class="mb-5 pb-3">
				<h2><font class="text-primary">결제</font>가 완료되었습니다.</h2>
			</div>
			<div class="nav justify-content-center mb-5 pb-3">
				<div class="text-start me-5">
					<span class="nav-item lh-lg">결제번호<br></span> <!-- *lh-lg : 행간 넓게 -->
					<span class="nav-item lh-lg">결제일<br></span>
					<span class="nav-item lh-lg">결제수단<br></span>
					<span class="nav-item lh-lg">결제가격<br></span>
				</div>
				<div class="text-start ms-5">
					<span class="nav-item lh-lg"><%=payment.getOrderNo() %><br></span>
					<span class="nav-item lh-lg"><%=DateUtils.toTextOrderTime(payment.getPayDate()) %><br></span>
					<span class="nav-item lh-lg"><%=payment.getMethod() %><br></span>
					<span class="nav-item lh-lg"><%=NumberUtils.toCurrency(payment.getPrice()) %>원<br></span>
				</div>
			</div>
			<a href="/info/userpayment.jsp" class="btn btn-primary" style="width: 15%; font-size: 17px;">결제내역 확인</a>
		</div>
	</div>
</div>
</body>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="payment" name="menu"/>
</jsp:include>
</html>