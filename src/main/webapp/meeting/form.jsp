<%@page import="dao.MeetingCategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.MeetingCategory"%>
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
<title>TODOIT::모임게시판</title>
</head>
<body>
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="" name="menu"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col-12">
			<h1>신규 모임 정보 입력폼</h1>
			
			<form class="border bg-light p-3 mb-3"
				method="post"
				action="insert.jsp"
				enctype="multipart/form-data"
				onsubmit="checkForm(event)">
				<div class="form-group mb-3">
					<label class="form-label">모임 제목</label>
					<input type="text" class="form-control" name="title" />
				</div>
<%
	MeetingCategoryDao meetCatDao = new MeetingCategoryDao();
	List<MeetingCategory> meetCatList = meetCatDao.getAllCategories();
%>
				<div class="form-group mb-3">
					<label class="form-label">모임 카테고리</label>
					<select class="form-select" name="catNo">
<%
	for (MeetingCategory meetCat : meetCatList) {
%>
						<option value="<%=meetCat.getNo() %>"><%=meetCat.getName() %></option>
<%
	}
%>
					</select>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 최대인원</label>
					<input type="number" class="form-control" name="maxPeople" />
				</div>
				<div class="form-group mb-3">
					<label class="form-label ">모임 주소</label>
					<input type="text" class="form-control mb-1" name="address" />
					<input type="hidden" class="form-control" name="lat" />
					<input type="hidden" class="form-control" name="lon" />
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 가격</label>
					<input type="number" class="form-control" name="price" min="0" max="9999999" />
				</div>
				
				<div class="form-group mb-3">
					<label class="form-label">모임 할인가격</label>
					<input type="number" class="form-control" name="discountPrice" min="0" max="9999999" value="0"/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 시작일자</label>
					<input type="date" class="form-control" name="startDate">
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 종료일자</label>
					<input type="date" class="form-control" name="endDate">
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 내용</label>
					<textarea rows="10" class="form-control" name="content"></textarea>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">가입 승인 제한 여부</label>
					<div class="form-check form-check-inline">
						<label class="form-check-label">승인 후 가입</label>
						<input class="form-check-input" type="checkbox" name="approve" value="Y" >
					</div>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">모임 사진등록</label>
					<input type="file" class="form-control" name="upfile" accept="image/*"/>
				</div>
				<div class="text-end">
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8969454c0c7cb8ee61ed937eb735f33c&libraries=services"></script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.sido + " " + data.sigungu;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.sido + " " + data.sigungu;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               // document.getElementById('sample6_postcode').value = data.zonecode;
                document.querySelector("input[name=address]").value = addr;
                // 커서를 상세주소 필드로 이동한다.
               // document.getElementById("sample6_detailAddress").focus();
                
                const geocoder = new kakao.maps.services.Geocoder();
                geocoder.addressSearch(data.roadAddress, (result, status) => {
                    if (status === kakao.maps.services.Status.OK) {
                    	document.querySelector("input[name=lat]").value = result[0].y
                    	document.querySelector("input[name=lon]").value = result[0].x
/*                       console.log('위도 : ' + result[0].y);
                      console.log('경도 : ' + result[0].x); */
                    }
                  });
            }
        
        }).open();
    }
    
    function checkForm(event) {
	
		// 입력필드 엘리먼트를 조회한다.
    	let titleInput = document.querySelector("input[name=title]");
		let maxPeopleInput = document.querySelector("input[name=maxPeople]");
		let addressInput = document.querySelector("input[name=address]");
		let priceInput = document.querySelector("input[name=price]");
		let discountPriceInput = document.querySelector("input[name=discountPrice]");
		let startDateInput = document.querySelector("input[name=startDate]");
		let endDateInput = document.querySelector("input[name=endDate]");
		let contentInput = document.querySelector("textarea[name=content]");
		
		// 2. 입력필드의 입력값 조회하기
		let title = titleInput.value;
		let maxPeople = maxPeopleInput.value;
		let address = addressInput.value;
		let price = priceInput.value;
		let discountPrice = discountPriceInput.value;
		let startDate = startDateInput.value;
		let endDate = endDateInput.value;
		let content = contentInput.value;

		if (title === ""){
			event.preventDefault();
			alert("제목은 필수입력값입니다.");
			titleInput.focus();
			return;
		}
		if (maxPeople > 9999 || maxPeople === ""){
			event.preventDefault();
			alert("모임 최대인원은 1 ~ 9999명까지 입력 가능합니다.");
			maxPeopleInput.focus();
			return;
		}
		if (address === ""){
			event.preventDefault();
			alert("모임장소는 필수 입력값입니다.");
			addressInput.focus();
			return;
		}
		if (price < discountPrice || price === ""){
			event.preventDefault();
			alert("모임 가격은 0 ~ 9,999,999원 사이의 값이어야 합니다." );
			priceInput.focus();
			return;
		}
		if (startDate === "" || endDate === ""){
			event.preventDefault();
			alert("모임 일정은 필수 입력값입니다.");
			startDateInput.focus();
			return;
		}
		if (startDate > endDate){
			event.preventDefault();
			alert("모임 시작일이 모임 종료일보다 늦을 수 없습니다.");
			startDateInput.focus();
			return;
		}
		if (content === ""){
			event.preventDefault();
			alert("모임 상세 내용은 필수 입력값입니다.");
			contentInput.focus();
			return;
		}
	}
</script>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>