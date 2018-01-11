<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MVC 게시판</title>
<style type="text/css">
#articleForm {
	width: 500px;
	height: 500px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

#basicInfoArea {
	height: 40px;
	text-align: center;
}

#articleContentArea {
	background: orange;
	margin-top: 20px;
	height: 350px;
	text-align: center;
	overflow: auto;
}

#commandList {
	margin: auto;
	width: 500px;
	text-align: center;
}
</style>
</head>
<body>
	<section id="articleForm">
	<h2>글 내용 상세보기</h2>
	<%while(rs.next()){ %>
	<section id="basicInfoArea"> 제목 : <%=rs.getString("board_subject")%>
	첨부파일 : <%
		if (!(rs.getString("board_file") == null)) {
	%> <a
		href="file_down?file_name=<%=rs.getString("board_file")%>"><%=rs.getString("board_file")%></a>
	<%
		}
	%> </section> <section id="articleContentArea"> <%=rs.getString("board_content")%>
	</section> </section>
	<section id="commandList"> 
	<a href="board_reply.jsp?board_num=<%=rs.getString("board_num")%>&page=<%=nowpage%>">[답변]</a>
	<a href="board_modify.jsp?board_num=<%=rs.getString("board_num")%>&page=<%=nowpage%>">[수정]</a>
	<a href="board_delete.jsp?board_num=<%=rs.getString("board_num")%>&page=<%=nowpage%>">[삭제]</a>
	<a href="board_list.jsp?board_num=<%=rs.getString("board_num")%>&page=<%=nowpage%>">[목록]</a>&nbsp;&nbsp;
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