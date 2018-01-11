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
<script type="text/javascript">
	function modifyboard() {
		modifyform.submit();
	}
</script>
<style type="text/css">
#registForm {
	width: 500px;
	height: 600px;
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
	<h2>게시판글수정</h2>
	<form action="board_modify_process.jsp" method="post" name="modifyform">
			<input type="hidden" name="board_num"
			value="<%=board_num%>" />
			<input type="hidden" name="page"
			value="<%=nowpage%>" />
			<%while(rs.next()) { %>
		<table>
			<tr>
				<td class="td_left"><label for="board_name">글쓴이</label></td>
				<td class="td_right"><input type="text" name="board_name"
					id="board_name" value="<%=rs.getString("board_name")%>" /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_pass">비밀번호</label></td>
				<td class="td_right"><input type="password" name="board_pass"
					id="board_pass" value="<%=rs.getString("board_pass")%>" /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_subject">제목</label></td>
				<td class="td_right"><input type="text" name="board_subject"
					id="board_subject" value="<%=rs.getString("board_subject")%>" /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_content">내용</label></td>
				<td class="td_right"><textarea name="board_content"
						id="board_content" cols="40" rows="15"><%=rs.getString("board_content")%></textarea></td>
			</tr>
		</table>
		<section id="commandCell"> <a
			href="javascript:modifyform.submit()">[수정]</a>&nbsp;&nbsp; <a
			href="javascript:history.go(-1)">[뒤로]</a> </section>
	</form>
	</section>
	<%}
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