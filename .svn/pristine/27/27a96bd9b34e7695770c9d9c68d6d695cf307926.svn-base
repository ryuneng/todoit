<%@page import="vo.DailyCheck"%>
<%@page import="dao.DailyCheckDao"%>
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
<style type="text/css">
	.check-on {
		background-image: url('/resources/images/mark.jpg')
	}
</style>
<title>bootstrap</title>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="menu"/>
</jsp:include>
<%
	// 로그인 없이 이벤트에 접속했을때 로그인폼으로 리다이렉트 시킴.
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	if (loginUser == null) {
		response.sendRedirect("/user/loginform.jsp?error=deny");
		return;
	}

	DailyCheckDao dailyCheckDao = new DailyCheckDao();
	DailyCheck dailyCheck = dailyCheckDao.getDailycheckByUserNo(loginUser.getNo());
%>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<div class="card">
				<div class="card-header">TODOIT 2024년 2월(출석체크)</div>
				<table class="table table-bordered">
	   				<tbody class="text-center fs-3">
						<tr>
							<td>일</td>
	                        <td>월</td>
	                        <td>화</td>
	                        <td>수</td>
	                        <td>목</td>
	                        <td>금</td>
	                        <td>토</td>
						</tr>
						<tr>
	                        <td class="fw-bold text-danger"></td>
	                        <td></td>
	                        <td></td>
	                        <td></td>
	                        <td class="table-active">1</td>
	                        <td class="table-active">2</td>
	                        <td class="fw-bold text-primary">3</td>
	                     </tr>
	                     <tr>
	                         <td class="fw-bold text-danger">4</td>
	                         <td class="table-active">5</td>
	                         <td class="table-active">6</td>
	                         <td class="table-active">7</td>
	                         <td class="table-active">8</td>
	                         <td class="table-active">9</td>
	                         <td class="fw-bold text-primary">10</td>
	                     </tr>
	                     <tr>
	                         <td class="fw-bold text-danger">11</td>
	                         <td class="table-active">12</td>
	                         <td class="table-active">13</td>
	                         <td class="table-active">14</td>
	                         <td class="table-active">15</td>
	                         <td class="table-active">16</td>
	                         <td class="fw-bold text-primary">17</td>
	                     </tr>
	                     <tr>
	                         <td class="fw-bold text-danger">18</td>
	                         <td class="table-active">19</td>
	                         <td class="table-active">20</td>
	                         <td class="table-active">21</td>
	                         <td class="table-active">22</td>
	                         <td class="table-active">23</td>
	                         <td class="fw-bold text-primary">24</td>
	                     </tr>
	                     <tr>
	                         <td class="fw-bold text-danger">25</td>
	                         <td class="table-active">26</td>
	                         <td class="table-active">27</td>
	                         <td class="table-active">28</td>   
	                         <td class="table-active">29</td>   
	                         <td ></td>   
	                         <td class="fw-bold text-primary"></td>   
	                     </tr>
			   		</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="d-grid gap-3 col-5 mx-auto">
<%
	// 출석체크를 하지 않은경우 버튼이 생성된다.
	if (dailyCheck == null) {
%>
	  	<a href="insert.jsp" class="btn btn-primary" type="button">출석체크</a>
<% 
	} else {
		// 이미 출석체크를 하였으면 표시가된다.
%>
		<p class="text-center">출석체크를 완료하였습니다.</p>
<% 
	}
%>
	</div>
</div>
</body>

</html>