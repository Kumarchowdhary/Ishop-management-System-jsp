<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Employee" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	ArrayList<Employee> employees = (ArrayList) request.getAttribute("employeesList");
	pageContext.setAttribute("emp", employees);
%>

<c:forEach var="row" items="${emp}">
	  <c:out value="${row.getEmployeeId()}" />
	  <c:out value="${row.getEmployeeName()}" />
	  <c:out value="${row.getEmployeeUsername()}" />
	  <c:out value="${row.getEmployeePassword()}" />
	  <c:out value="${row.getEmployeeGender()}" />
	  <c:out value="${row.getEmployeeAddress()}" />
	  <c:out value="${row.getEmployeeNum()}" />
	  <c:out value="${row.getEmployeeHireDate()}" />
	  <c:out value="${row.getEmployeeActive()}" />
	  <c:out value="${row.getEmployeeTypeId()}" />
	  <br>
</c:forEach>
</body>
</html>