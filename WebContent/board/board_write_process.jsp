<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;

	int num = 0;
	String sql = "";
	String file = null;
	String uploadPath = request.getRealPath("/upload");
	int size = 10*1024*1024;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();
		conn.setAutoCommit(false);
		
		int updateCount;

		psmt = conn.prepareStatement("select max(board_num) from board");
		rs = psmt.executeQuery();
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8",new DefaultFileRenamePolicy());

		if (rs.next()) {
			num = rs.getInt(1) + 1;
		} else {
			num = 1;
		}
		
		file = multi.getOriginalFileName((String)multi.getFileNames().nextElement());
		
		if (file == null) {
			file = "";
			System.out.println("파일없음");
		} else {
			System.out.println("파일등록ok");
		}

		sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now())";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, num);
		psmt.setString(2, multi.getParameter("board_name"));
		psmt.setString(3, multi.getParameter("board_pass"));
		psmt.setString(4, multi.getParameter("board_subject"));
		psmt.setString(5, multi.getParameter("board_content"));
		psmt.setString(6, file);
		psmt.setInt(7, num);
		psmt.setInt(8, 0);
		psmt.setInt(9, 0);
		psmt.setInt(10, 0);

		updateCount = psmt.executeUpdate();
		
		if(updateCount > 0){
			conn.commit();
			System.out.println("글쓰기 성공");
			response.sendRedirect("board_list.jsp");
		}else{
			conn.rollback();
			System.out.println("글쓰기 실패");
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>