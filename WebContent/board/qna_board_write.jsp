<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MVC 게시판</title>
<style>
#reqistForm {
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
	<h2>게시판 등록</h2>
	<form action="boardWritePro.bo" method="post"
		enctype="multipart/form-data" name="boardform">
		<table>
			<tr>
				<td class="td_left"><label for="board_name">글쓴이</label></td>
				<td class="td_right"><input type="text" name="board_name"
					id="board_name" required /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_pass">비밀번호</label></td>
				<td class="td_right"><input type="password" name="board_pass"
					id="board_pass" required /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_subject">제목</label></td>
				<td class="td_right"><input type="text" name="board_subject"
					id="board_subject" required /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_content">내용</label></td>
				<td class="td_right"><textarea name="board_content"
						id="board_content" cols="40" rows="15" required></textarea></td>
			</tr>
			<tr>
				<td class="td_left"><label for="board_file">파일첨부</label></td>
				<td class="td_right"><input type="file" name="board_file"
					id="board_file" /></td>
			</tr>
		</table>
		<section id="commandCell"> <input type="submit" value="등록">&nbsp;&nbsp;
		<input type="reset" value="다시쓰기" /> </section>
	</form>
</body>
</html>