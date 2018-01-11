<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null; 
	
	int nowpage = Integer.parseInt(request.getParameter("page"));
	int board_num = Integer.parseInt(request.getParameter("board_num"));

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();

		psmt = conn.prepareStatement("select * from board where board_num=?");
		psmt.setInt(1, board_num);
		rs = psmt.executeQuery();
		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MVC 게시판</title>
<style type="text/css">
#registForm {
	width: 500px;
	height: 610px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

table {
	margin: auto;
	width: 450px;
}

.td_left {
	width: 150px;
	background: orange;
}

.td_right {
	width: 300px;
	background: skyblue;
}

#commandCell {
	text-align: center;
}
</style>
</head>
<body>
	<section id="writeForm">
	<h2>게시판 글 등록</h2>
	<form action="board_reply_process.jsp" method="post" name="boardform">
		<input type="hidden" name="page" value="<%=nowpage%>" /> <input
			type="hidden" name="board_num" value="<%=board_num%>" />
			
			<%while(rs.next()){ %>
		<input type="hidden" name="board_re_ref"
			value="<%=rs.getString("board_re_ref")%>" /> <input type="hidden"
			name="board_re_lev" value="<%=rs.getString("board_re_lev")%>" /> <input
			type="hidden" name="board_re_seq"
			value="<%=rs.getString("board_re_seq")%>" />
			<%} %>
			
		<table>
			<tr>
				<td class="td_left"><label for="board_num">글쓴이</label></td>
				<td class="td_right"><input type="text" name="board_name" id="board_name"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_pass">비밀번호</label></td>
				<td class="td_right"><input type="password" name="board_pass" id="board_pass"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_subject">제 목</label></td>
				<td class="td_right"><input type="text" name="board_subject" id="board_subject"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_content">내 용</label></td>
				<td class="td_right"><textarea name="board_content" id="board_content" cols="40" rows="15"></textarea></td>
			</tr>
		</table>
			<section id="commandCell">
			<input type="submit" value="답변글등록"/>&nbsp;&nbsp;
			<input type="reset" value="다시작성"/>
			</section>	
	</form>
	</section>
	<%
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
</body>
</html>