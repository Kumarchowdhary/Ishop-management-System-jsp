<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
	<title>Home Area</title>
	<meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
	<link href="css/mainstyle.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/offcanvas.js"></script>    
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<%
	String username = (String) request.getAttribute("username");
	String empTypeName = (String) request.getAttribute("empTypeName");
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("empTypeName", empTypeName);
%>

<nav class="navbar navbar-default navbar-static-top">
  <div class="container">

    <div id="brandicon" class="navbar-header">
      <img src="images/brandicon.png" width="100px">
    </div>
    <div id="hearts" class="navbar-nav navbar-right">
      <a class="navbar-brand" href="#" data-transition="linear"><img src="images/hamburgericon2.png" width="50px" class="visible-xs"><img src="images/hamburgericon.png" width="80px" class="visible-sm visible-md visible-lg"></a>
    </div>
  </div>
</nav>


<div id="site-wrapper">

  <div id="site-canvas">

    <div id="site-menu" align="center">
      <img src="images/logo.png" width="110px">
      <br>
      <br>
          <a href="${pageContext.request.contextPath}/HomeServlet">
          <button type="submit" class="graphite-flat-button">
            <span class="glyphicon glyphicon-home pull-left" aria-hidden="true">
            </span>
            <small>Home</small>
          </button>
          </a>
          <br>
          <a href="${pageContext.request.contextPath}/EmployeeServlet">
          <button type="submit" class="graphite-flat-button">
            <span class="glyphicon glyphicon-user pull-left" aria-hidden="true">
            </span>
          <small>Employees</small>
          </button>
	      </a>
          <br>
          <button type="submit" class="graphite-flat-button"   data-toggle="modal" data-target=".bs-inventory-modal-sm">
            <span class="glyphicon glyphicon-shopping-cart pull-left" aria-hidden="true">
            </span>
          <small>Inventory</small>
          </button>
          <br>
          <button type="submit" class="graphite-flat-button">
            <span class="glyphicon glyphicon-briefcase pull-left" aria-hidden="true">
            </span>
          <small>Companies</small>
          </button>
          <br>
          <a href="${pageContext.request.contextPath}/OrderServlet">
          <button type="submit" class="graphite-flat-button">
            <span class="glyphicon glyphicon-list-alt pull-left" aria-hidden="true">
            </span>
          <small>Order</small>
          </button>
          </a>
          <br>
          <a href="${pageContext.request.contextPath}/EndSession">
          <button type="submit" class="graphite-flat-button">
            <span class="glyphicon glyphicon-log-out pull-left" aria-hidden="true">
            </span>
          <small>Log Out</small>
          </button>
          </a>
    </div>

    <h1 class="text-center"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home Area</h1>

    <p class="lead text-center">
      Hello <b><c:out value="${username}" />!</b> Welcome to iShop Management System.<br>
      You are <b><c:out value="${empTypeName}" />!</b><br>
      You may procede with activities by selecting the specific option from the menu.
    </p>

    <br>
    <div class="container">
      <div class="well">
      </div>
    </div>
    </div>
    
	<!-- Inventory Button Modal -->
    <div class="modal fade bs-inventory-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  		
  		<div class="modal-dialog modal-sm" role="document">
    		<div class="modal-content">
   		   		<div class="modal-header">
        			<h4 class="modal-title" id="myModalLabel">Select Inventory Option</h4>
      			</div>
      			<div class="modal-body">
      			  <a href="${pageContext.request.contextPath}/CategoriesServlet">
      			  <button type="button" class="btn btn-primary btn-lg">Categories</button>
      			  </a>
      			  <a href="${pageContext.request.contextPath}/ProductServlet">
      			  <button type="button" class="btn btn-primary btn-lg">Products</button>
      			  </a>
      			</div>
    		</div>
  		</div>
	</div>
</body>
</html>