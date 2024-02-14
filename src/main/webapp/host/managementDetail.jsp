<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dao.MeetingReplyDao"%>
<%@page import="vo.MeetingReply"%>
<%@page import="dao.ApplyUserDao"%>
<%@page import="dto.ReplyManagementDto"%>
<%@page import="utils.DateUtils"%>
<%@page import="vo.Meeting"%>
<%@page import="dao.MeetingDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dto.ApplyManagementDto"%>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<jsp:include page="/include/navbar.jsp">
	<jsp:param value="홈" name="menu"/>
</jsp:include>
<title>Insert title here</title>
<style>
  ul.comment-list {
     list-style-type: none;
     padding-left: 20px;
 }

  ul.comment-list li {
     margin-bottom: 0px;
     border-bottom: 1px solid #ccc; 
     padding-bottom: 0px; 
     background-color: #f0f0f0; 
 }
 
/*타이틀*/
   .title {
       width: 600px;
       word-wrap: break-word; /* 긴 단어일 경우 강제로 줄바꿈 */
   }
</style>



</head>
<body>
<%
    LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

    int meetingNo = Integer.parseInt(request.getParameter("meetingNo"));
    String sta = request.getParameter("sta");
    if (sta == null) {
        sta = "all";
    }
    String nickname = request.getParameter("nickname");


    Map<String, Object> param = new HashMap<>();
    param.put("userNo", loginUser.getNo());
    param.put("sta", sta.equals("all") ? null : sta); // 'all'일 때 null을 전달하여 쿼리에서 처리하도록 함
    param.put("meetingNo", meetingNo);
    if (nickname != null && !nickname.isBlank()) {
        param.put("nickname", nickname);
    }

    // 미팅정보를 조회
    MeetingDao meetingDao = new MeetingDao();
    Meeting meeting = meetingDao.getMeetingByNo(meetingNo);

    // 참여자 정보를 조회
    HostDao hostDao = new HostDao();
    List<ApplyManagementDto> applyList = hostDao.getHostApplies(param);


    // 댓글 정보를 조회
    MeetingReplyDao meetingReplyDao = new MeetingReplyDao();
    List<MeetingReply> replyList = meetingReplyDao.getMeetingReplies(meetingNo);

  
%>
<div class="container" style="max-width: 900px">
	<div class="row mb-3">
		<div class="col-12">
			<h3 class="best meeting category">
	    		<i class="bi bi-people display-3" style="margin-right: 10px;"></i>
	    			모임 관리 
			</h3> 
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="d-flex align-items-center">
				<img src="/resources/images/meeting/<%=meeting.getImageName()%>" style="margin-right: 10px;" class="float-start" alt="..." width="150" height="150">
				<span style="background-color: #6cb2e4; color: white; padding: 1px 8px; border-radius: 4px; margin-right: 20px;"><%=meeting.getStatus() %></span>
	            <h4 class="title">
	                <%=meeting.getTitle() %>
	            </h4>
			</div>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-12">
			<h4>참여자 관리</h4>
		</div>
	</div>
	<form id="form-status" method="get" action="managementDetail.jsp">
		<input type="hidden" name="meetingNo" value="<%=meetingNo %>" />
		<div class="row mb-1">
			<div class="col-md-3">
		        <select class="form-select" name="sta" onchange="changeSta()">
		            <option value="all" selected>전체</option>
		            <option value="accepted">참여확정</option>
		            <option value="waiting">대기중</option>
		        </select>
			</div>
		    <div class="col-md-3 ms-auto mb-3">
		    	<div class="input-group">
			    	<input type="search" class="form-control rounded" name="nickname" placeholder="닉네임 검색" aria-label="Search" aria-describedby="search-addon" />
			   		<button type="submit" class="btn btn-outline-primary">검색</button>
				</div>
			</div>
		</div>
   	</form>
   	<div class="row">
   		<div class="col-12">
			<table class="table table-bordered mb-5">
				<colgroup>
					<col width="10%">
					<col width="20%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="25%">
				</colgroup>
			    <thead>
			        <tr class="table-secondary">
			            <th>순번</th>
			            <th>닉네임</th>
			            <th>신청일자</th>
			            <th>승인일자</th>
			            <th>신청상태</th>
			            <th>비고</th>
			        </tr>
			    </thead>
			    <tbody>
<%
	if (applyList.isEmpty()) {
%>
			        <tr>
			            <td colspan="6">참여자가 없습니다.</td>
			         </tr>
<%		
	} else {
		int count = 1;
		for (ApplyManagementDto dto : applyList) {
%>
			        <tr>
			            <td><%=count++ %></td>
			            <td><%=dto.getNickname() %></td>
			            <td><%=DateUtils.toText(dto.getAppliedDate()) %></td>
			            <td>
<%
		                    // 참여 확정 상태일 때만 승인일자를 표시
		                    if ("Y".equals(dto.getAccepted())) {
%>
		                        <%=DateUtils.toText(dto.getAcceptedDate()) %> <!-- 승인일자 표시 -->
<%
			                    } else {
			                        // 승인되지 않은 상태는 빈칸으로 표시
%>
	                        &nbsp; <!-- 승인되지 않았을 때 공백 -->
<%
                    }
%>
                </td>
                <td>
<%
			if ("W".equals(dto.getAccepted())){
%>
							<span style= "background-color: #e66a77; background-color: #bdbdbd; color: white; padding: 1px 8px; border-radius: 4px; margin-right: 10px;">승인대기</span>

<% 
			} else if ("Y".equals(dto.getAccepted())){
%>
							<span style= "background-color: #e66a77; background-color: #6cb2e4; color: white; padding: 1px 8px; border-radius: 4px; margin-right: 10px;">참여확정</span>
<%
			} else if ("N".equals(dto.getAccepted())) {
%>
							<span style= "background-color: #e66a77; background-color: #f1fe3; color: white; padding: 1px 8px; border-radius: 4px; margin-right: 10px;">승인거절</span>
<%
			}
%>
						</td>
						<td>
<%
			if ("W".equals(dto.getAccepted())) {
%>
			                <a href="applycheck.jsp?meetingNo=<%=meetingNo %>&applyNo=<%=dto.getNo() %>&action=accept" class="btn btn-outline-success btn-sm">수락</a>
			                <a href="applycheck.jsp?meetingNo=<%=meetingNo %>&applyNo=<%=dto.getNo() %>&action=reject" class="btn btn-outline-danger btn-sm">거절</a>
<%
			}
%>
			            </td>
			         </tr>
<%
		}
	}
%>
			    </tbody>
			</table>
   		</div>
   	</div>
	<hr>
	<div class="row align-items-center">
	    <div class="col">
	        <h4>댓글 관리</h4>
	    </div>
	    <div class="col-auto">
	        <button onclick="deleteSelectedComments()" class="btn btn-outline-danger btn-sm">댓글 삭제</button>
	    </div>
	</div>
   	<div class="row">
		<div class="col-12">
	        <div class="row justify-content-end mb-3">
	        </div>
   			<table class="table table-bordered mb-3">
			    <thead>
			        <tr class="table-secondary">
			          <th scope="col" style="width: 2px;">
            				<input type="checkbox" id="selectAllCheckbox" onchange="toggleAllCheckboxes(this)">
        				</th>
			            <th class="text-center">댓글</th>
			        </tr>
			    </thead>
			    <tbody>
<%
    if (replyList.isEmpty()) {
%>
		    <tr>
		        <td colspan="2">등록된 댓글이 없습니다.</td>
		    </tr>
<%
    } else {
        for (MeetingReply parentReply : replyList) {
            if (parentReply.getPartentsReply() == 0) { // 부모 댓글인 경우
%>
				    <!-- 부모 댓글 출력 -->
				    <tr>
				    
				        <td>
				        	<!-- 체크박스 댓글 번호를 숨겨진 필드에 입력 -->
				             <input type="checkbox" class="commentCheckbox" name="replyNo" value="<%=parentReply.getNo() %>" data-comment-id="<%=parentReply.getNo()%>">
				        </td>
				        <td>
				            <div style="padding: 25px;" class="row">
				                <!-- 부모 댓글 내용 출력 -->
				                <div class="d-flex align-items-start">
				                    <img src="../resources/images/user/<%=parentReply.getUser().getFilename() %>" class="rounded-circle me-2" alt="..." width="55px" height="55px">
				                    <div class="d-flex flex-column">
				                        <div class="d-flex align-items-center">
				                            <h6 class="me-2"><%=parentReply.getUser().getNickname() %></h6>
				                            <small><%=DateUtils.toTextCustom(parentReply.getCreatedDate())%></small>
				                        </div>
				                        <span><%=parentReply.getContent()%></span>
				                    </div>
				                </div>
				            </div>
				        </td>
				    </tr>
			    
    				<!-- 대댓글 출력 -->
<%
    			List<MeetingReply> childReplies = meetingReplyDao.getReReplies(parentReply.getNo()); // 해당 부모 댓글의 대댓글 가져오기
    			for (MeetingReply childReply : childReplies) {
%>
					<tr> 
					    <td>
					    	<input type="checkbox" class="commentCheckbox" name="replyNo" value="<%=childReply.getNo() %>" data-comment-id="<%=childReply.getNo()%>"></td>
					    <td>
			            <div style="padding: 25px; margin-left: 50px; background-color: #f5f5f5;" class="row"> <!-- 들여쓰기 추가 -->
			                <!-- 대댓글 내용 출력 -->
			                <div class="d-flex align-items-start">
			                    <i class="bi bi-arrow-return-right"></i>
			                    <img src="../resources/images/user/<%=childReply.getUser().getFilename() %>" class="rounded-circle me-2" alt="..." width="55px" height="55px">
			                    <div class="d-flex flex-column">
			                        <div class="d-flex align-items-center">
			                            <h6 class="me-2"><%=childReply.getUser().getNickname() %></h6>
			                            <small><%=DateUtils.toTextCustom(childReply.getCreatedDate())%></small>
			                        </div>
			                        <span><%=childReply.getContent()%></span>
			                    </div>
			                </div>
			            </div>
			        </td>
			    </tr>
<% 
    			} // 대댓글 반복문 종료
%>
<%
    		} // 부모 댓글인 경우 조건문 종료
		} // 부모 댓글 반복문 종료
    }
%>
			    </tbody>
			</table>
        </div>
	</div>
</div>
<script type="text/javascript">
    function changeSta() {
        document.getElementById("form-status").submit();
    } 



    function deleteSelectedComments() {
        var selectedComments = document.querySelectorAll('.commentCheckbox:checked');
        
        if (selectedComments.length === 0) {
            alert('삭제할 댓글을 선택해주세요.');
            return;
        }
        
        var selectedIds = Array.from(selectedComments).map(checkbox => checkbox.dataset.commentId).join(',');

        var form = document.createElement('form');
        form.method = 'GET';
        form.action = '/host/deleteReply.jsp'; // 수정된 부분: 데이터를 처리할 서버 측 스크립트의 URL을 여기에 입력
        form.style.display = 'none'; // 폼이 화면에 표시되지 않도록 함

        var idsInput = document.createElement('input');
        idsInput.type = 'hidden';
        idsInput.name = 'selectedReplyNos';
        idsInput.value = selectedIds;
        form.appendChild(idsInput);
        
        var meetingNoInput = document.createElement('input');
        meetingNoInput.type = 'hidden';
        meetingNoInput.name = 'meetingNo';
        meetingNoInput.value = '<%=meetingNo%>';
        form.appendChild(meetingNoInput);

        document.body.appendChild(form);
        form.submit();
    }
	
    function toggleAllCheckboxes(source) {
        var checkboxes = document.querySelectorAll('.commentCheckbox');
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = source.checked;
        });
    }

</script>
<jsp:include page="/include/footer.jsp">
	<jsp:param value="mypage" name="menu"/>
</jsp:include>
</body>
</html>