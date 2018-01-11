<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null; // 목록보여주는 rs
	
	PreparedStatement psmt1 = null; 
	ResultSet rs1 = null; // 순서 rs
	
	int nowpage = 1;
	int listCount = 0;
	
	if(request.getParameter("page")!=null){
		nowpage = Integer.parseInt(request.getParameter("page"));
	} // 한번더 호출시 다시 돌려주는거 
	
	int limit = 5;
	int pageLimit = 10;
	
	int count = 0;

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB");
		conn = ds.getConnection();

		psmt = conn.prepareStatement("select * from board order by board_re_ref desc,board_re_seq limit ?,"+limit);
		int startrow = (nowpage - 1) * limit ;
		psmt.setInt(1, startrow);
		rs = psmt.executeQuery();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MVC 게시판</title>
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

#tr_top {
	background: orange;
	text-align: center;
}

#pageList {
	margin: auto;
	width: 500px;
	text-align: center;
}
</style>
</head>
<body>
	<section id="listForm">
	<h2>
		글목록<a href="board_write.jsp">게시판 글쓰기</a>
	</h2>
	<table>
		<%
			if (rs.next()) {
					rs.beforeFirst();
		%>
		<tr id="tr_top">
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>날짜</td>
			<td>조회수</td>
		</tr>
		<%
			while (rs.next()) {
						if (rs.getInt("board_re_lev") != 0) {
							out.println("<tr>");
							out.println("<td></td>");
							out.println("<td>");
							for (int a = 0; a <= rs.getInt("board_re_lev") * 2; a++) {
								out.println("&nbsp;");
							}
							out.println("▶");
						} else {
							count++;
							out.println("<tr>");
							out.println("<td>" + count + "</td>");
							out.println("<td>");
							out.println("▶");
						}
						out.println("<a href='board_view_process.jsp?board_num=" + rs.getInt("board_num")+"&page="+nowpage + "'>"
								+ rs.getString("board_subject") +"</a></td>");
						out.println("<td>" + rs.getString("board_name") + "</td>");
						out.println("<td>" + rs.getString("board_date") + "</td>");
						out.println("<td>" + rs.getString("board_readcount") + "</td></tr>");
						
					}
		
		%>
	</table>
	</section>
	<section id="pageList">
	<%
	
	psmt1 = conn.prepareStatement("select count(*) from board");
	rs1 = psmt1.executeQuery();

	if (rs1.next()) {
		listCount = rs1.getInt(1);
	}
	
	int maxPage = (int)((double)listCount/limit+0.95);
	int startPage = (((int)((double)nowpage/pageLimit+0.9))-1)*pageLimit+1;
	int endPage = startPage+pageLimit-1;
	
	if(endPage>maxPage) endPage = maxPage;
	
		if (nowpage <= 1) {
			out.println("[이전]&nbsp;");
		} else {
			out.println("<a href='board_list.jsp?page=" +(nowpage-1)+"'>[이전]</a>&nbsp");
		}
	for (int a = startPage; a <= endPage; a++) {
		if (a == nowpage) {
			out.println("[" + a + "]");
			} else {
				out.print("<a href='board_list.jsp?page="+a+"'>["+a+"]</a>&nbsp;");
				}
		}
	if (nowpage >= endPage) {
		out.println("[다음]");
		} else {
			out.println("<a href='board_list.jsp?page="+(nowpage+1)+"'>[다음]</a>&nbsp;");
			}%>
</section>
	<%} else {%>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<%
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
</body>
</html>