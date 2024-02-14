<%@page import="vo.Community"%>
<%@page import="dao.CommunityDao"%>
<%@page import="vo.User"%>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");

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
	
	int no = Integer.parseInt(parameter.get("no"));
	int pageNo = Integer.parseInt(parameter.get("page"));
	
	CommunityDao commDao = new CommunityDao();
	Community community = commDao.getCommunityByNo(no);
	
	community.setTitle(title);
	community.setContent(content);

	int REVIEW_CATEGORY_NO = 100001;
	
	if (community.getCategory().getNo() == REVIEW_CATEGORY_NO) {
		int score = Integer.valueOf(parameter.get("score"));
		community.setScore(score);
	}
	
	if (filename != null) {
		community.setImageName(filename);		
	}

	commDao.updateCommunity(community);
	
	response.sendRedirect("detail.jsp?no=" + no + "&page=" + pageNo);
%>