<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	request.getSession();
	session.invalidate();
	response.sendRedirect("indexJSP.jsp");
%>