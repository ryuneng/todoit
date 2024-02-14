<%@page import="dao.PaymentDao"%>
<%@page import="dto.UserPaymentDto"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="utils.NumberUtils"%>
<%@page import="vo.PointHistory"%>
<%@page import="dao.PointDao"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="dto.LoginUser"%>
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
<style type="text/css">
.txt_line {
      width:250px;
      padding:0 5px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
  }
 .size {

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
<title>TODOIT :: 포인트 내역</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
<%
	// 1. HttpSession에 LOGIN_USER 속성명으로 저장된 로그인된 사용자정보 조회
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	// 2. userNo에 로그인한 유저번호 저장
	int userNo = loginUser.getNo();
	
	// 3. UserDao 객체 생성
	UserDao userDao = new UserDao();
	
	// 4. 유저번호로 가져온 유저정보 user에 저장 
	User user = userDao.getUserByNo(userNo);
	
	// 5. PointDao, PointHistory 객체 생성
	PointDao pointDao = new PointDao();
	PointHistory pointHistory = new PointHistory();
	
	// 6. pointHistory 객체에 로그인중인 유저 저장
	pointHistory.setUser(user);
	
	// 7. 포인트 히스토리 전체조회해서 리스트에 담기
	List<PointHistory> pointHistoryList = pointDao.getPointsHistory(userNo);
	
	// 8. 주문내역 받아오기
	PaymentDao paymentDao = new PaymentDao();
	List<UserPaymentDto> paymentList = paymentDao.getUserPaymentByUserNo(userNo);
%>

<div class="container">
	<div class="row mt-3">
		<div class="col-12">
		</div>
	</div>
	<div class="row pt-4 mb-3">
		<div class="col-3">
			<jsp:include page="sidebar.jsp">
				<jsp:param value="myPoints" name="menu"/>
			</jsp:include>
		</div>
		<div class="col-9 ps-5">
			<h1 class="mb-4">포인트 내역</h1>
			<p class="mb-5 fw-bold fs-5">• <%=user.getName() %> 님의 보유 포인트 : <span class="text-primary"><%=NumberUtils.toCurrency(user.getPoint()) %></span> 점</p>
			<!-- 리스트 시작 -->
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>날짜</th>
							<th>내용</th>
							<th>적립</th>
							<th>사용</th>
						</tr>
					</thead>
					<tbody>
<%
	for (PointHistory point : pointHistoryList) {
		if (point.getUsedPoint() == 0 && point.getSavedPoint() == 0) {
%>
<%
		} else {
%>
						<tr>
							<td><%=DateUtils.toTextOrderTime(point.getCreatedDate()) %></td>
<%
		if (point.getUsedPoint() == 0) {
%>
							<td>출석체크 적립</td>
<%
			} else if (point.getSavedPoint() == 0) {
%>	
							<td>결제 시 포인트 차감<span class="text-secondary"> - 결제번호 <%=point.getOrderNo() %></span></td>
<%
		}
%>
							<td class="text-danger">+ <%=NumberUtils.toCurrency(point.getSavedPoint()) %></td>
							<td class="text-primary">- <%=NumberUtils.toCurrency(point.getUsedPoint()) %></td>
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
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
</html>