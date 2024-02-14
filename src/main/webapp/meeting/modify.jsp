<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.fileupload2.core.DiskFileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload2.jakarta.JakartaServletDiskFileUpload"%>
<%@page import="org.apache.commons.fileupload2.core.DiskFileItemFactory"%>
<%@page import="dao.MeetingDao"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="vo.Meeting"%>
<%@page import="vo.User"%>
<%@page import="vo.MeetingCategory"%>
<%@page import="utils.StringUtils"%>
<%@page import="utils.NumberUtils"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	
	String directory = "C:\\todoit-workspace\\todoit\\src\\main\\webapp\\resources\\images\\meeting";
	
	DiskFileItemFactory factory = DiskFileItemFactory
			.builder()
			.setCharset("utf-8")
			.get();
	JakartaServletDiskFileUpload upload = new JakartaServletDiskFileUpload(factory);
	List<DiskFileItem> items = upload.parseRequest(request);
	
	Map<String, String> parameter = new HashMap<>();
	String filename = "meeting.jpg";
	for (DiskFileItem item : items) {
		if (item.isFormField()) {		// 일반 입력필드
			String name = item.getFieldName();
			String value = item.getString();
			parameter.put(name, value);
		} else {						// 파일업로드 필드
			if (item.getSize() > 0) {
				filename = System.currentTimeMillis() + item.getName();
				InputStream in = item.getInputStream();
				FileOutputStream fos = new FileOutputStream(new File(directory, filename));
				
				IOUtils.copy(in, fos);
				fos.close();				
			}
		}
	}
	
	// 요청 파라미터값 조회
	int meetNo = NumberUtils.toInt(parameter.get("meetNo"));
	int currentPage = NumberUtils.toInt(parameter.get("page"), 1);
	String title = parameter.get("title");
	int catNo = NumberUtils.toInt(parameter.get("catNo"));
	int maxPeople = NumberUtils.toInt(parameter.get("maxPeople"));
	String address = parameter.get("address");
	int price = NumberUtils.toInt(parameter.get("price"));
	int discountPrice = NumberUtils.toInt(parameter.get("discountPrice"));
	
	Date startDate = DateUtils.toDate(parameter.get("startDate"));
	Date endDate =  DateUtils.toDate(parameter.get("endDate"));
	String content = StringUtils.withBr(parameter.get("content"));
	String approve = parameter.get("approve");
	if (approve == null) {
		approve = "N";
	}
	
	MeetingDao meetingDao = new MeetingDao();
	
	// 수정할 모임 상세정보 조회
	Meeting meeting = meetingDao.getMeetingByNo(meetNo);
	
	// 로그인유저가 작성한 게시글이 아닌 경우 삭제할 수 없다.
	if (meeting.getUser().getNo() != loginUser.getNo()){
		response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&error=deny" + "&page=" + currentPage);
		return;
	}
	
	MeetingCategory category = new MeetingCategory();
	category.setNo(catNo);
	
	User user = new User();
	user.setNo(loginUser.getNo());
	
	double latitude = NumberUtils.toDouble(parameter.get("lat"));
	double longitude = NumberUtils.toDouble(parameter.get("lon"));

	meeting.setTitle(title);
	meeting.setMaxPeople(maxPeople);
	meeting.setAddress(address);
	meeting.setPrice(price);
	meeting.setDiscountPrice(discountPrice);
	meeting.setStartDate(startDate);
	meeting.setEndDate(endDate);
	meeting.setContent(content);
	meeting.setApprove(approve);
	meeting.setCategory(category);
	meeting.setUser(user);
	meeting.setImageName(filename);
	if(latitude != 0 && longitude != 0) {
		meeting.setLatitude(latitude);
		meeting.setLongitude(longitude);		
	}
	
	meetingDao.updateMeetingByNo(meeting);
	
	response.sendRedirect("detail.jsp?meetNo=" + meetNo + "&page=" + currentPage);
%>