<%@page import="vo.Dog"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
#listForm {
	width: 640px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

img {
	width: 280px;
	height: 280px;
	border: none;
}

#content_main {
	height: 300px;
}

#content_left {
	width: 300px;
	float: left;
}

#content_right {
	width: 340px;
	float: left;
}

#commandList {
	text-align: center;
}

#desc {
	height: 170px;
	background: skyblue;
}
</style>
</head>
<body>
	<section id="listForm">
	<h2>${dog.kind}�ǻ�����</h2>
	<section id="content_main"> <section id="content_left">
	<img src="images/${dog.image }" /> </section> <section id="content_right">
	<b>ǰ�� : </b>${dog.kind }<br>
	<b>���� : </b>${dog.price }<br>
	<b>���� : </b>${dog.height }<br>
	<b>ü�� : </b>${dog.weight }<br>
	<b>������ : </b>${dog.country }<br>
	<p id="desc">
		<b>���� : </b>${dog.content }<br>
	</p>
	</section>
	<div style="clear: both"></div>
	<nav id="commandList"> <a href="dogList.dog">���ΰ���ϱ�</a> <a
		href="dogCartAdd.dog?id=${dog.id }">��ٱ��Ͽ� ���</a> </nav> </section> </section>
</body>
</html>