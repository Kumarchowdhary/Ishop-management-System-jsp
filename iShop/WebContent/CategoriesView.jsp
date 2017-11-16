<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Categories" %>
<%@ page import="models.SubCategories" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="utf-8">
	<title>Categories Area</title>
	<meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
	<link href="css/mainstyle.css" rel="stylesheet">
	<link href="css/catstyle.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/offcanvas.js"></script>    
    <script src="js/bootstrap.min.js"></script>
    <script>
     	function sendCatId(a){
        	$("#categoryId").val(a);	
        }
     	function sendSubCatId(a){
        	$("#subCategoryId").val(a);	
        }
     	
     	function fillCatUpdateForm(details) {
     		var catDetails = details.split(",");
     		$('#updateCatId').val(catDetails[0]);
     		$('#updateCatName').val(catDetails[1]);     		
     	}
     	function fillSubCatUpdateForm(details) {
     		var subCatDetails = details.split(",");
     		$('#updateSubCatId').val(subCatDetails[0]);
     		$('#updateSubCatName').val(subCatDetails[1]);
     		$('#updateCatList>option:eq('+ (subCatDetails[2] - 1) +')').prop('selected', true);
     	}
    </script>
</head>
<body>
<%
	ArrayList<Categories> categories = (ArrayList) request.getAttribute("categoriesList");
	ArrayList<SubCategories> subCategories = (ArrayList) request.getAttribute("SubCategoriesList");
	pageContext.setAttribute("cat", categories);
	pageContext.setAttribute("subcat", subCategories);
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
          <button type="submit" class="graphite-flat-button"  data-toggle="modal" data-target=".bs-inventory-modal-sm">
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

    <h1 class="text-center"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Categories Area</h1>
	
    <br>
    <div class="container">
      <div id="categoriesTable" class="well table-responsive">
        <table id="catTable" class="table table-hover">
        <thead>
          <tr>
            <th>Categories Id</th>
            <th>Categories Name</th>
            <th>Manipulate</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${cat}">
        <tr>
        	<td><c:out value="${row.getCategoriesId()}" /></td>
			<td><c:out value="${row.getCategoriesName()}" /></td>
	  		<td>
	  		<c:set var="details" scope="session" value="${row.getCategoriesId()},${row.getCategoriesName()}" />
            <a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#updateCategoryModal" onClick="fillCatUpdateForm('${details}');"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>&nbsp;Update</a>
            <a class="btn btn-danger" href="#" role="button"  data-toggle="modal" data-target="#removeCategoryModal" onClick="sendCatId(${row.getCategoriesId()});"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a>
            </td>         
	  	</tr>
		</c:forEach>
        </tbody>
        </table>
      </div>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newCategoryModal">
    	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        &nbsp;Add New Category
    </button>
    </div>
    
    <h1 class="text-center"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Sub-Categories Area</h1>
	
    <br>
    <div class="container">
      <div id="categoriesTable" class="well table-responsive">
        <table id="catTable" class="table table-hover">
        <thead>
          <tr>
            <th>Sub-Categories Id</th>
            <th>Sub-Categories Name</th>
            <th>Categories Name</th>
            <th>Manipulate</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${subcat}">
        <tr>
        	<td><c:out value="${row.getSubCategoriesId()}" /></td>
			<td><c:out value="${row.getSubCategoriesName()}" /></td>
			<td><c:out value="${row.getCategories().getCategoriesName()}" /></td>
	  		<td>
	  		<c:set var="details" scope="session" value="${row.getSubCategoriesId()},${row.getSubCategoriesName()},${row.getCategories().getCategoriesId()}" />
            <a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#updateSubCategoryModal" onClick="fillSubCatUpdateForm('${details}');"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>&nbsp;Update</a>
            <a class="btn btn-danger" href="#" role="button"  data-toggle="modal" data-target="#removeSubCategoryModal" onClick="sendSubCatId(${row.getSubCategoriesId()});"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a>
            </td>         
	  	</tr>
		</c:forEach>
        </tbody>
        </table>
      </div>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newSubCategoryModal">
    	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        &nbsp;Add New Sub-Category
    </button>
    </div>
   </div>

<!-- Add Category Modal -->
<div class="modal fade" id="newCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add New Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Category Information</h3>
        </div><br>
            <input type="hidden" name="section" value="categories"> 
        	<input type="hidden" name="action" value="add"> 
  			<div class="form-group">
    			<label for="catName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="catName" name="CatName" placeholder="Name">
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

   
<!-- Update Category Modal -->
<div class="modal fade" id="updateCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Category Information</h3>
        </div><br>
            <input type="hidden" name="section" value="categories"> 
        	<input type="hidden" name="action" value="update"> 
        	 <input type="hidden" name="CategoryId" id="updateCatId" value=""> 
  			<div class="form-group">
    			<label for="updateCatName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateCatName" name="CatName" placeholder="Name">
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
   
   
<!-- Remove Category Modal -->
<div class="modal fade" id="removeCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Remove Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <input type="hidden" name="section" value="categories"> 
      	<input type="hidden" name="action" value="remove"> 
  		<input type="hidden" name="categoryId" id="categoryId" value=""> 
  		<h3>Are you sure you want to remove this category?</h3>  		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" id="publish" class="btn btn-danger">Remove</button>
      </div>
      </form>
    </div>
  </div>
</div>


<!-- Add Sub-Category Modal -->
<div class="modal fade" id="newSubCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add New Sub-Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Sub-Category Information</h3>
        </div><br>
            <input type="hidden" name="section" value="subcategories"> 
        	<input type="hidden" name="action" value="add"> 
  			<div class="form-group">
    			<label for="SubcatName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="subCatName" name="SubCatName" placeholder="Name">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="updateCatList" class="col-sm-2 control-label">Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="CatName" name="CatName">
    					<c:forEach var="row" items="${cat}">
    						<option><c:out value="${row.getCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
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


<!-- Update Sub-Category Modal -->
<div class="modal fade" id="updateSubCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Sub-Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Category Information</h3>
        </div><br>
            <input type="hidden" name="section" value="subcategories">
        	<input type="hidden" name="action" value="update"> 
        	 <input type="hidden" name="SubCategoryId" id="updateSubCatId" value=""> 
  			<div class="form-group">
    			<label for="updateSubCatName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateSubCatName" name="SubCatName" placeholder="Name">
    			</div>
  			</div>  				      
  			<div class="form-group">
    			<label for="updateCatList" class="col-sm-2 control-label">Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="updateCatList" name="CatName">
    					<c:forEach var="row" items="${cat}">
    						<option><c:out value="${row.getCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
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


<!-- Remove Sub-Category Modal -->
<div class="modal fade" id="removeSubCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Remove Sub-Category</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
      <div class="modal-body">
        <input type="hidden" name="section" value="subcategories"> 
      	<input type="hidden" name="action" value="remove"> 
  		<input type="hidden" name="subCategoryId" id="subCategoryId" value=""> 
  		<h3>Are you sure you want to remove this sub-category?</h3>  		
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