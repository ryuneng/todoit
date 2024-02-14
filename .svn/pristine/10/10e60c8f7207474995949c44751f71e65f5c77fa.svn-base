<%@page import="dto.LoginUser"%>
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
<%@page import="vo.Address"%>
<%@page import="vo.User"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="dao.UserDao"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginUser loginUser = (LoginUser) session.getAttribute("LOGIN_USER");
	String userId = loginUser.getId();
	UserDao userDao = new UserDao();
	User savedUser = userDao.getUserById(userId);

		String directory = "C:\\todoit-workspace\\todoit\\src\\main\\webapp\\resources\\images\\user";

		DiskFileItemFactory factory = DiskFileItemFactory
				.builder()
				.setCharset("utf-8")
				.get();
		JakartaServletDiskFileUpload upload = new JakartaServletDiskFileUpload(factory);
		List<DiskFileItem> items = upload.parseRequest(request);

		Map<String, String> parameter = new HashMap<>();
		String filename = "user_1077114.png";
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







/*
	요청URL
		localhost/comn/modify.jsp
	요청파라미터(요청메세지의 바디부)
		id=xxx&password=xxx&name=xxx&email=xxx&tel=xxx
	*/

	// 1.요청파라미터 값 조회
	String id = parameter.get("id");
	String name = parameter.get("name");
	String nickname = parameter.get("nickname");
	Date birthDate =DateUtils.toDate(parameter.get("birthdate"));
	String gender = parameter.get("gender");
	String email = parameter.get("email");
	String tel = parameter.get("tel");
	int cityNo = Integer.parseInt(parameter.get("cityNo"));
	int guNo = Integer.parseInt(parameter.get("guNo"));
	String content = parameter.get("content");

	Address Address = new Address();
	Address.setNo(guNo);
	Address.setAddress_no2(cityNo);


	// userDao 생성
	User user = userDao.getUserById(userId);


	// 유저객체에 값 저장
	user.setName(name);
	user.setNickname(nickname);
	user.setBirthDate(birthDate);
	user.setGender(gender);
	user.setEmail(email);
	user.setTel(tel);
	user.setAddress(Address);
	user.setContent(content);
	user.setFilename(filename);


	// updateUser로 user에 저장된 값 저장
	userDao.updateUser(user);

	// 회원정보 창으로 이동
	response.sendRedirect("info.jsp");
%>














