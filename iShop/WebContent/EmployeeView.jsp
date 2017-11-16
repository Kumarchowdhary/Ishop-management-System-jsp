<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Employee" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Employee Area</title>
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
    <link href="css/mainstyle.css" rel="stylesheet">
    <link href="css/employeestyle.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/offcanvas.js"></script>    
    <script src="js/bootstrap.min.js"></script>
    

    <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
     <script>
     	function sendId(a){
        	$("#employeeId").val(a);	
        }
     	
     	function showEmployees(a) {
     		
     		var details = a.split(",");
     		$('#viewEmployeeModal .modal-body').html('<div align="center"> <h3>Account Details</h3> <br> <label>Username: </label> '+ details[1] +'<br> <label>Employee Type: </label> '+ details[9] +'<br> <h3>Personal Details</h3>  <br> <label>Name: </label> '+ details[3] +' <br> <label>Address: </label> '+ details[4] +' <br> <label>Contact No: </label> '+ details[5] +' <br> <label>Hire Date: </label> '+ details[6] +' <br> <label>Gender: </label> '+ details[7] +'</div>');
     	}
     	function fillUpdateForm(details) {
     		var empDetails = details.split(",");
     		$('#updateEmpId').val(empDetails[0]);
     		$('#updateUsername').val(empDetails[1]);
     		$('#updateName').val(empDetails[3]);
     		$('#updateAddress').val(empDetails[4]);
     		$('#updateNumber').val(empDetails[5]);
     		$('#updateDate').val(empDetails[6]);    		
     		if(empDetails[7] == "Male") {
      			$('#updateMale').prop("checked", true);
     		}
     		else {
     			$('#updateFemale').prop("checked", true);
     		}
     		$('#updateType>option:eq('+ (empDetails[2] - 1) +')').prop('selected', true);
     		$('#updatePassword1').val(empDetails[8]);
     		$('#updatePassword2').val(empDetails[8]);
     	}
     	
     </script>
</head>
<body>
<%
	ArrayList<Employee> employees = (ArrayList) 	request.getAttribute("employeesList");
	pageContext.setAttribute("emp", employees);
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
          <button type="submit" class="graphite-flat-button" data-toggle="modal" data-target=".bs-inventory-modal-sm">
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

    <h1 class="text-center"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Employees Area</h1>

    <p class="lead text-center">You can view or manipulate employee information here.</p>

    <br>
    <div class="container">
      <div id="employeeTable" class="well table-responsive">
        <table id="empTable" class="table table-hover">
        <thead>
          <tr>
            <th>Employee Id</th>
            <th>Employee Username</th>
            <th>Employee Type</th>
            <th>Manipulate</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${emp}">
        <tr>
        	<c:set var="empType">${row.getEmployeeType().getEmployeeTypeName()}</c:set>
        	<td><c:out value="${row.getEmployeeId()}" /></td>
			<td><c:out value="${row.getEmployeeUsername()}" /></td>
	  		<td><c:out value="${row.getEmployeeType().getEmployeeTypeName()}" /></td>
	  		<td>
	  		<c:set var="details" scope="session" value="${row.getEmployeeId()},${row.getEmployeeUsername()},${row.getEmployeeType().getEmployeeTypeId()},${row.getEmployeeName()},${row.getEmployeeAddress()},${row.getEmployeeNum()},${row.getEmployeeHireDate()},${row.getEmployeeGender()},${row.getEmployeePassword()}, ${row.getEmployeeType().getEmployeeTypeName()}" />
            <a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#viewEmployeeModal"  onClick="showEmployees('${details}');"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;View</a>
            <a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#updateEmployeeModal" onClick="fillUpdateForm('${details}');"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>&nbsp;Update</a>
            <a id="${row.getEmployeeId()}" class="btn btn-danger hello" href="#" role="button"  data-toggle="modal" data-target="#removeEmployeeModal" onClick="sendId(${row.getEmployeeId()});"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a>
            </td>         
	  	</tr>
		</c:forEach>
        </tbody>
        </table>
      </div>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newEmployeeModal">
    	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        &nbsp;Add New Employee
    </button>
    </div>
  </div>
</div>

<!-- Add New Employee Modal -->
<div class="modal fade" id="newEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add New Employee</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/EmployeeServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Account Details</h3>
        </div><br>
        	<input type="hidden" name="action" value="add"> 
        	<input type="hidden" name="empId" id="empId" value="">
  			<div class="form-group">
    			<label for="empUsername" class="col-sm-2 control-label">Username</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="empUsername" name="username" placeholder="Username">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empPassword1" class="col-sm-2 control-label">Password</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" id="empPassword1" name="password1" placeholder="Password">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empPassword2" class="col-sm-2 control-label">Confirm Password</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" id="empPassword2" name="password2" placeholder="Confirm Password">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empType" class="col-sm-2 control-label">Employee Type</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="empType" name="empType">
    					<option>Admin</option>
    					<option>Manager</option>
    					<option>Cashier</option>
  					</select>
    			</div>
  			</div>
  			
        <div align="center">
        <h3>Enter Personal Details</h3>
        </div><br>
  			<div class="form-group">
    			<label for="empName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="empName" name="name" placeholder="Name">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empAddress" class="col-sm-2 control-label">Address</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="empAddress" name="address" placeholder="Address">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empNumber" class="col-sm-2 control-label">Contact No</label>
    			<div class="col-sm-10">
      				<input type="number" class="form-control" id="empNumber" name="number" placeholder="Contact No">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empDate" class="col-sm-2 control-label">Hire Date</label>
    			<div class="col-sm-10">
      				<input type="date" class="form-control" id="empDate" name="hiredate">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="empDate" class="col-sm-2 control-label">Gender</label>
    			<div class="col-sm-10">
      				<label class="radio-inline"><input type="radio" name="gender" value="Male" checked>Male</label>
					<label class="radio-inline"><input type="radio" name="gender" value="Female" >Female</label>
    			</div>
  			</div>
  			
  			      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" id="publish" class="btn btn-primary">Add</button>
      </div>
      </form>
    </div>
  </div>
</div>


<!-- Update Employee Modal -->
<div class="modal fade" id="updateEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Employee</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/EmployeeServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Account Details</h3>
        </div><br>
        	<input type="hidden" name="action" value="update"> 
        	 <input type="hidden" name="employeeId" id="updateEmpId" value=""> 
  			<div class="form-group">
    			<label for="updateUsername" class="col-sm-2 control-label">Username</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateUsername" name="username" placeholder="Username">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updatePassword1" class="col-sm-2 control-label">Password</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" id="updatePassword1" name="password1" placeholder="Password">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updatePassword2" class="col-sm-2 control-label">Confirm Password</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" id="updatePassword2" name="password2" placeholder="Confirm Password">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updateType" class="col-sm-2 control-label">Employee Type</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="updateType" name="empType">
    					<option>Admin</option>
    					<option>Manager</option>
    					<option>Cashier</option>
  					</select>
    			</div>
  			</div>
  			
        <div align="center">
        <h3>Enter Personal Details</h3>
        </div><br>
  			<div class="form-group">
    			<label for="updateName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateName" name="name" placeholder="Name">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updateAddress" class="col-sm-2 control-label">Address</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateAddress" name="address" placeholder="Address">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updateNumber" class="col-sm-2 control-label">Contact No</label>
    			<div class="col-sm-10">
      				<input type="number" class="form-control" id="updateNumber" name="number" placeholder="Contact No">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updateDate" class="col-sm-2 control-label">Hire Date</label>
    			<div class="col-sm-10">
      				<input type="date" class="form-control" id="updateDate" name="hiredate">
    			</div>
  			</div>
  			<div class="form-group">
    			<label class="col-sm-2 control-label">Gender</label>
    			<div class="col-sm-10">
      				<label class="radio-inline"><input type="radio" id="updateMale" name="gender" value="Male" checked>Male</label>
					<label class="radio-inline"><input type="radio" id="updateFemale" name="gender" value="Female" >Female</label>
    			</div>
  			</div>
  			
  			      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" id="publish" class="btn btn-primary">Update</button>
      </div>
      </form>
    </div>
  </div>
</div>


<!-- View Employee Modal -->
<div class="modal fade" id="viewEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">View Employee</h4>
      </div>
      <div class="modal-body">
  		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Dismiss</button>
      </div>
    </div>
  </div>
</div>

<!-- Remove Employee Modal -->
<div class="modal fade" id="removeEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Remove Employee</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/EmployeeServlet" method="post">
      <div class="modal-body"W>
      	<input type="hidden" name="action" value="remove"> 
  		<input type="hidden" name="employeeId" id="employeeId" value=""> 
  		<h3>Are you sure you want to remove this employee?</h3>  		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" id="publish" class="btn btn-danger">Remove</button>
      </div>
      </form>
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