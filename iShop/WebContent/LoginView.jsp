<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
	<title>Welcome to iShop!</title>
	<meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div id="leftside" class="col-md-6" align="center">
      <img src="images/logo.png" id="logoimg">
    </div>
    <div class="col-md-6"   align="center">
    <div id="rightside" class="well well-md"  align="center">
          <img src="images/key_small.png" width='70px'> <br>
          <form action="${pageContext.request.contextPath}/SetSession"  method="post">
          <div class="form-group">
            <label for="username" class="col-sm-2 control-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Username">
          </div>
          <div class="form-group">
            <label for="password" class="col-sm-2 control-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
          </div>

          <div class="form-group">
            <button id="submit" type="submit" class="btn btn-default">Sign in</button>
          </div>
          </form>
    </div>
    </div>
    <script type='text/javascript' src="js/jquery.min.js"></script>
    <script type='text/javascript' src="js/bootstrap.min.js"></script>
</body>
</html>