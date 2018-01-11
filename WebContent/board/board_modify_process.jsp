<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;

	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String sql = "";
	

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();
		conn.setAutoCommit(false);

		int updateCount=0;

		String board_sql = "select * from board where board_num=?";

		psmt = conn.prepareStatement(board_sql);
		psmt.setInt(1, board_num);
		rs = psmt.executeQuery();
		rs.next();

		if (rs.getString("board_pass").equals(rs.getString("board_pass"))) {
			sql = "update board set board_subject=?,board_content=? where board_num=?";

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, request.getParameter("board_subject"));
			psmt.setString(2, request.getParameter("board_content"));
			psmt.setInt(3, board_num);
			updateCount = psmt.executeUpdate();

		}else{
			out.print("<script>");
			out.print("alert('비밀번호 오류')");
			out.print("history.back();");
			out.print("<script>");
		}

		if (updateCount > 0) {
			conn.commit();
			response.sendRedirect("board_list.jsp");
		} else {
			conn.rollback();
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