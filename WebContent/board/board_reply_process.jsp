<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;

	int nowpage = Integer.parseInt(request.getParameter("page"));
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	int re_ref = Integer.parseInt(request.getParameter("board_re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("board_re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("board_re_seq"));

	String board_max_sql = "select max(board_num) from board";
	int num = 0;
	String sql = "";
	int insertCount = 0;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();
		conn.setAutoCommit(false);

		psmt = conn.prepareStatement(board_max_sql);
		rs = psmt.executeQuery();
		
		if (rs.next())
			num = rs.getInt(1) + 1;
		else
			num = 1;
		sql = "update board set board_re_seq = board_re_seq+1 where board_re_ref=? ";
		sql += "and board_re_seq > ?";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, re_ref);
		psmt.setInt(2, re_seq);
		int updateCount = psmt.executeUpdate();

		if (updateCount > 0) {
			conn.commit();
		}

		re_seq = re_seq + 1;
		re_lev = re_lev + 1;
		sql = "insert into board (board_num,board_name, board_pass,board_subject,";
		sql += "board_content, board_file, board_re_ref," + "board_re_lev,board_re_seq,";
		sql += "board_readcount," + "board_date) values(?,?,?,?,?,?,?,?,?,?,now())";

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, num);
		psmt.setString(2, request.getParameter("board_name"));
		psmt.setString(3, request.getParameter("board_pass"));
		psmt.setString(4, request.getParameter("board_subject"));
		psmt.setString(5, request.getParameter("board_content"));
		psmt.setString(6, "");
		psmt.setInt(7, re_ref);
		psmt.setInt(8, re_lev);
		psmt.setInt(9, re_seq);
		psmt.setInt(10, 0);

		insertCount = psmt.executeUpdate() ;
		
		if (insertCount > 0) {
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