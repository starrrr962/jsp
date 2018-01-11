<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	int nowpage = Integer.parseInt(request.getParameter("page"));

	Connection conn = null;
	PreparedStatement psmt = null;

	int updateCount;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();
		conn.setAutoCommit(false);

		psmt = conn.prepareStatement(
				"update board set board_readcount= board_readcount+1 where board_num=" + board_num);
		updateCount = psmt.executeUpdate();

		if (updateCount > 0) {
			conn.commit();
			response.sendRedirect("board_view.jsp?page="+nowpage+"&board_num="+board_num);
		} else {
			conn.rollback();
			out.print("<script>");
			out.print("alert('글 읽기에 실패하였습니다.')");
			out.print("history.back();");
			out.print("<script>");
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