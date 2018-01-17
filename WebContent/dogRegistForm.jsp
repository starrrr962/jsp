<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	<section id="registForm"> <header>
	<h2>�� �������</h2>
	</header>
	<form action="dogRegist.dog" method="post" name="writeForm"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td colspan="2"><a href="dogList.dog">��Ϻ���</a></td>
			</tr>
			<tr>
				<td class="td_left"><label for="kind">ǰ�� : </label></td>
				<td class="td_right"><input type="text" name="kind" id="kind"
					required /></td>
			</tr>
			<tr>
				<td class="td_left"><label for="nation">������ : </label></td>
				<td class="td_right"><input type="text" name="nation" id="nation"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="price">���� : </label></td>
				<td class="td_right"><input type="text" name="price" id="price"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="height">���� : </label></td>
				<td class="td_right"><input type="text" name="height" id="height"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="weight">ü�� : </label></td>
				<td class="td_right"><input type="text" name="weight" id="weight"/></td>
			</tr>
			<tr>
				<td class="td_left"><label for="content">�۳��� : </label></td>
				<td class="td_right"><textarea name="content" id="content" rows="13" cols="40" wrap="off"></textarea></td>
			</tr>
			<tr>
				<td class="td_left"><label for="image">��ǰ�̹��� : </label></td>
				<td class="td_right"><input type="file" name="image" id="image"/></td>
			</tr>
			<tr>
			<td colspan="2" id="commandCell">
			<input type="submit" value="�� ��ǰ���"/>
			<input type="reset" value="�ٽ��ۼ�"/>
			<input type="button" value="�� ��ǰ��Ϻ���" onclick="window.location.href='dogList.dog'"/>
			</td>
			</tr> 
		</table>
	</form>
	</section>
</body>
</html>