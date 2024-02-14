<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dto.MeetingDto"%>
<%@page import="dao.MeetingDao"%>
<%@page import="dto.LoginUser"%>
<%@page import="vo.Meeting"%>
<%@page import="vo.Banner"%>
<%@page import="dao.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/bdbabb79d8.js" crossorigin="anonymous"></script>
<jsp:include page="include/navbar.jsp">
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

        #carouselExampleIndicators img {
            object-fit: cover;
            height: 400px;
        }

        .category-section {
            margin-top: 30px;
        }

        .icon {
            width: 45px;
            height: 45px;
            margin-right: 5px;
        }

        .card {
            border: none;
            box-shadow: none;
            margin-bottom: 20px;
            width: calc(25% - 1em); 
        }

        .carousel-inner {
            padding: 1em;
        }

        .carousel-control-prev,
        .carousel-control-next {
            background-color: #e1e1e1;
            width: 6vh;
            height: 6vh;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }

        .carousel-control-prev span,
        .carousel-control-next span {
            width: 1.5rem;
            height: 1.5rem;
        }

        .cards-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .card-title {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            white-space: normal;
        }

        .card-body {
            margin-bottom: 5px;
        }

        .image-wrapper {
            height: 13vw;
            position: relative;
        }

        .image-wrapper img {
            max-width: 100%;
            max-height: 100%;
        }

        @media (max-width: 768px) {
            .card {
                width: calc(50% - 1em);
            }
        }

        @media (max-width: 576px) {
            .card {
                width: calc(100% - 1em);
            }
        }
    </style>
</head>
<body>
<%
	Map<String, Object> param = new HashMap<>();

	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	if (loginUser != null) {
		param.put("userNo", loginUser.getNo());
	}
	
	MainDao mainDao = new MainDao();
	MeetingDao meetingDao= new MeetingDao();

	// 배너이미지
	List<Banner> bannerList = mainDao.getBanners();
	// 주간 인기 베스트
	List<MeetingDto> weeklyList = mainDao.getWeeklyBest(param);
	// 스터디/자기계발 베스트
	List<MeetingDto> studyList = mainDao.getStudyCat(param);
	// 문화예술 베스트
	List<MeetingDto> artList = mainDao.getArtCat(param);
	// 운동/액티비티 베스트
	List<MeetingDto> exerciseList = mainDao.getExerciseCat(param);
	// 취미 베스트
	List<MeetingDto> hobbyList = mainDao.getHobbyCat(param);
	// 푸드 베스트
	List<MeetingDto> foodList = mainDao.getFoodCat(param);
	
	
	// 찜 누를때 로그인 확인
	boolean logined = false;
	if (loginUser != null) {
		logined = true;
	}
%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div id="carouselExampleIndicators"  class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="3000">
     			<div class="carousel-indicators">
       				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
       				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
       				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
     			</div>
     			<div class="carousel-inner">
<%
for (Banner banner : bannerList) {
%>
          			<div class="carousel-item active">
               			<img src="/resources/images/banner/<%=banner.getImageName()%>" class="d-block w-100" alt="배너사진">
          			</div>
<%
}
%>
     			</div>
			     <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			          <span class="visually-hidden">Previous</span>
			     </button>
			     <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			          <span class="carousel-control-next-icon" aria-hidden="true"></span>
			          <span class="visually-hidden">Next</span>
			     </button>
			</div>
		</div>
	</div>
<div class="row">
    <div class="col-12">
        <div class="category-section mb-10" >
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">주목할만한 인기 모임</span>
                <img src="resources/images/main/best.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>    
            <div id="bestCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : weeklyList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted sm mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto" style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                } %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="category-section mb-10">
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">배우고 성장하는 삶을 위해</span>
                <img src="resources/images/main/study.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=100001&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>
            <div id="studyCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : studyList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted sm mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto"  style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                } %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="category-section mb-10">
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">경계없는 문화 예술 살롱</span>
                <img src="resources/images/main/art.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=100002&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>
            <div id="artCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : artList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted sm mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto"  style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                }
                                                %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <hr style="border-top: 1px solid #666;">
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="category-section mb-10">
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">함께 운동하면 지겨움 극복</span>
                <img src="resources/images/main/exercise.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=100003&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>
            <div id="exerciseCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : exerciseList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted sm mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto" style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                }
                                                %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="category-section mb-10">
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">조금 특별한 일상을 위한 취미</span>
                <img src="resources/images/main/hobby.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=100004&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>
            <div id="hobbyCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : hobbyList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto" style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                }
                                                %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="category-section mb-10">
            <h4 class="best meeting category" style="padding-left: 20px;">
                <span style="font-weight: bold;">푸드에 진심인 사람들</span>
                <img src="resources/images/main/food.png" alt="" class="icon">
                <a href="http://localhost/meeting/list.jsp?catNo=100005&page=1&rows=12&sort=like&opt=&keyword=" class="view-all-link" style="text-decoration: none; color: black; float: right; font-size: medium; margin-top: 20px; margin-right: 30px;">전체보기</a>
            </h4>
            <div id="foodCarousel" class="carousel carousel-dark slide d-none d-sm-block">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="cards-wrapper">
                            <% for (MeetingDto meeting : foodList) { %>
                                <div class="card" onclick="toMeetingDetail(<%= meeting.getNo() %>)">
                                    <div class="image-wrapper">
                                        <img src="/resources/images/meeting/<%=meeting.getImageName() %>" class="rounded" alt="...">
										<button class="btn btn-sm like-button" type="button" 
										    style="position: absolute; top: 10px; right: 10px; background: transparent; border: none;" 
										    onclick="event.stopPropagation(); wish(<%=logined %>, <%=meeting.getNo() %>, event)">
										    <i class="<%="Y".equals(meeting.getLikes())? "fa-solid text-danger" : "fa-regular text-light" %>  fa-heart"></i>
										</button>
                                    </div>
                                    <div class="card-body d-flex flex-column align-items-start">
                                        <p class="text-muted mb-2"><%=meeting.getAddress()%></p>
                                        <h6 class="card-title"><%= meeting.getTitle() %></h6>
                                        <div class="d-flex align-items-center mt-auto" style="margin-bottom: 10px;">
                                            <div class="rating me-2">
                                                <% 
                                                double score = meeting.getScoreAverage();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= (int)score) { %>
                                                        <i class="bi bi-star-fill"></i>
                                                    <% } else if (i - score > 0 && i - score < 1) { %>
                                                        <i class="bi bi-star-half"></i>
                                                    <% } else { %>
                                                        <i class="bi bi-star"></i>
                                                    <% }
                                                }
                                                %>
                                            </div>
                                            <span class="me-2"><%= meeting.getScoreAverage() %>점</span>
                                        </div>
                                        <div>
                                            <% if (meeting.getDiscountPrice() == 0) { %>
                                                 <span style="font-weight: bold;">
                                                    <%= meeting.getPrice() == 0 ? "무료모임" : meeting.getPrice() + "원"%>
                                                </span>
                                            <% } else { %>
                                                 <span style="text-decoration: line-through; color: #999999;"><%= meeting.getPrice() %>원</span>
                                                <span style="font-weight: bold; margin-left: 5px;"><%= meeting.getDiscountPrice() %>원</span>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>

	// 찜 추가 
	function wish(isLogined, no, event) {
	    if (!isLogined) {
	        // 로그인 페이지로 이동
	        location.href = '/user/loginform.jsp';
	        return;
	    }
	    
	    location.href = "/main/addWish.jsp?meetingNo=" + no;
	
	    // 이벤트 전파 중지
	    if (event) {
	        event.stopPropagation();
	    }
	}
	
	// 모임 상세 페이지 이동 
	function toMeetingDetail(meetNo) {
	    location.href = "/meeting/detail.jsp?meetNo=" + meetNo + "&page=1";
	}

</script>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="meeting" name="menu"/>
</jsp:include>
</body>
</html>