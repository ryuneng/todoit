<%@page import="utils.NumberUtils"%>
<%@page import="dao.MeetingDao"%>
<%@page import="vo.CommCategory"%>
<%@page import="dao.CommunityDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Meeting"%>
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
<%@page import="vo.Community"%>
<%@page import="dto.LoginUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

	String directory = "C:\\todoit-workspace\\todoit\\src\\main\\webapp\\resources\\images\\community";

	DiskFileItemFactory factory = DiskFileItemFactory
      .builder()
      .setCharset("utf-8")
      .get();
	JakartaServletDiskFileUpload upload = new JakartaServletDiskFileUpload(factory);
	List<DiskFileItem> items = upload.parseRequest(request);

	Map<String, String> parameter = new HashMap<>();
	String filename = "community.jpg";
	for (DiskFileItem item : items) {
   		if (item.isFormField()) {      // 일반 입력필드
      	String name = item.getFieldName();
      	String value = item.getString();
      	parameter.put(name, value);
   		} else {                  // 파일업로드 필드
   			if (item.getSize() > 0) {
  				filename = System.currentTimeMillis() + item.getName();
  				InputStream in = item.getInputStream();
  				FileOutputStream fos = new FileOutputStream(new File(directory, filename));
  
  				IOUtils.copy(in, fos);
  				fos.close();
			}
   		}
	}

	String title = parameter.get("title");
	String content = parameter.get("content");
	int catNo = Integer.valueOf(parameter.get("catNo"));
	int meetNo = Integer.valueOf(parameter.get("meetNo"));
	int score = NumberUtils.toInt(parameter.get("score"), 0);
	
	Meeting meeting = new Meeting();
	meeting.setNo(meetNo);
	
	User user = new User();
	user.setNo(loginUser.getNo());
	
	CommCategory category = new CommCategory();
	category.setNo(catNo);
	
	// 커뮤니티 저장
	Community community = new Community();
	community.setTitle(title);
	community.setContent(content);
	community.setCategory(category);
	community.setMeeting(meeting);
	community.setUser(user);
	community.setImageName(filename);
	community.setScore(score);

	CommunityDao commDao = new CommunityDao();
	
	int TOGETHER_CATEGORY_NO = 100000;
	int REVIEW_CATEGORY_NO = 100001;
	
	if (community.getCategory().getNo() == TOGETHER_CATEGORY_NO) {
		// 커뮤니티 같이해요글 저장
		commDao.insertCommunity(community);
		response.sendRedirect("list.jsp");
	}

	// 만약 카테고리 번호가 후기인 경우 
	if (community.getCategory().getNo() == REVIEW_CATEGORY_NO) {
	
		// 모임번호, 사용자번호로 커뮤니티 글 조회
		Community savedCommunity = commDao.getCommunity(community);
	
		if(savedCommunity != null) {
			response.sendRedirect("list.jsp?error=existCommunity");
		} else {
			// 커뮤니티 후기글 저장
			commDao.insertCommunity(community);
			
			// 모임 평점 업데이트
			MeetingDao meetingDao = new MeetingDao();
			meetingDao.updateMeetingScoreByNo(meeting);
			
			response.sendRedirect("list.jsp");
		}
	
	} 
%>
    