<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
Member loginMember = (Member)request.getAttribute("loginMember");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>�α��ο� ������ ����� ����</h1>
�̸�:<%=loginMember.getName() %><br>
�ּ�:<%=loginMember.getAddr() %><br>
�̸���:<%=loginMember.getEmail() %><br>
����:<%=loginMember.getAge() %><br>
</body>
</html>