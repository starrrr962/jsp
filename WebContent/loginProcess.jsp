<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");
		con = ds.getConnection();
		System.out.println("connection sucess");
		
		pstmt = con.prepareStatement("select * from users where id = ? and passwd = ?");
		pstmt.setString(1, id);
		pstmt.setString(2, passwd);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			session.setAttribute("id", id);
			response.sendRedirect("indexJSP.jsp");
		} else {
			out.println("<script>");
			out.println("alert('로그인실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>