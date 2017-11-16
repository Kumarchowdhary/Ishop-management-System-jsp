<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Categories" %>
<%@ page import="models.SubCategories" %>
<%@ page import="models.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="utf-8">
	<title>Products Area</title>
	<meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
	<link href="css/mainstyle.css" rel="stylesheet">
	<link href="css/productstyle.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/offcanvas.js"></script>    
    <script src="js/bootstrap.min.js"></script>
    <!-- AJAX -->
    <script>
	$(document).ready(function() {

    	$('#catOptions').change(function(event) {
			updateSubCategoriesList();
    	});
    	
    	$('#updateCatOptions').change(function(event) {
			updateSubCategoriesList2();
    	});
    	
    	$("#publish").click(function(event) {
    		var $action = "add";
    		var $productName = $("#productName").val();
    		var $productPrice = $("#productPrice").val();
    		var $subCatOptions = $("#subCatOptions").val();
			$.get('ProductActionServlet', {Action: $action, ProductName: $productName, ProductPrice: $productPrice, SubCatOptions: $subCatOptions}, function(responseJson) {
				if(responseJson != null) {
					$("#productTable").find("tr:gt(0)").remove();
					var table = $("#productTable");
					$.each(responseJson, function(key,value) {
						var rowNew = $("<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
						rowNew.children().eq(0).text(value['productId']);
						rowNew.children().eq(1).text(value['productName']);
						rowNew.children().eq(2).text(value['productPrice']);
						rowNew.children().eq(3).text(value['subCategories'].categories.categoriesName);
						rowNew.children().eq(4).text(value['subCategories'].subCategoriesName);
						var details = [value['productId'], value['productName'], value['productPrice']];
						var productId = value['productId'];
						rowNew.children().eq(5).html('<a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#updateProductModal" onClick="fillProductUpdateForm('+details+');"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>&nbsp;Update</a>  <a class="btn btn-danger" href="#" role="button"  data-toggle="modal" data-target="#removeProductModal" onClick="sendProductId('+productId+');"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a>');
						rowNew.appendTo(table);
					});
				}
			});    		
    	});
	});
	
	function updateSubCategoriesList() {
		var $action = "updateSubCatList";
		var $category=$("select#catOptions").val();
		//Change the subcategory options
		$.get('ProductActionServlet',{Action: $action, categoryname:$category},function(responseJson) {
			var $select = $('#subCatOptions');
			$select.find('option').remove();
			$.each(responseJson, function(key, value) {
			$('<option>').text(value).appendTo($select);
			});
		});
	}
	
	function updateSubCategoriesList2() {
		var $action = "updateSubCatList";
		var $category=$("select#updateCatOptions").val();
		//Change the subcategory options
		$.get('ProductActionServlet',{Action: $action, categoryname:$category},function(responseJson) {
			var $select = $('#updateSubCatOptions');
			$select.find('option').remove();
			$.each(responseJson, function(key, value) {
			$('<option>').text(value).appendTo($select);
			});
		});
	}
    </script>
    <!-- Functions -->
    <script>
     	function sendProductId(a){
        	$("#productId").val(a);	
        }
     	
     	function fillProductUpdateForm(details) {
     		var catDetails = details.split(",");
     		$('#updateProductId').val(catDetails[0]);
     		$('#updateProductName').val(catDetails[1]);
     		$('#updateProductPrice').val(catDetails[2]);     		
     	}
    </script>
</head>
<body>
<%
	ArrayList<Categories> categories = (ArrayList) request.getAttribute("categoriesList");
	ArrayList<SubCategories> subCategories = (ArrayList) request.getAttribute("subCategoriesList");
	ArrayList<Product> products = (ArrayList) request.getAttribute("products");
	pageContext.setAttribute("products", products);
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

    <h1 class="text-center"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Products Area</h1>
	
    <br>
    <div class="container">
      <div id="productsTable" class="well table-responsive">
        <table id="productTable" class="table table-hover">
        <thead>
          <tr>
            <th>Products Id</th>
            <th>Products Name</th>
            <th>Products Price</th>
            <th>Category Name</th>
            <th>Sub-Category Name</th>
            <th>Manipulate</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${products}">
        <tr>
        	<td><c:out value="${row.getProductId()}" /></td>
			<td><c:out value="${row.getProductName()}" /></td>
			<td><c:out value="${row.getProductPrice()}" /></td>
			<td><c:out value="${row.getSubCategories().getCategories().getCategoriesName()}" /></td>
			<td><c:out value="${row.getSubCategories().getSubCategoriesName()}" /></td>
	  		<td>
	  		<c:set var="details" scope="session" value="${row.getProductId()},${row.getProductName()},${row.getProductPrice()}" />
            <a class="btn btn-default" href="#" role="button" data-toggle="modal" data-target="#updateProductModal" onClick="fillProductUpdateForm('${details}');"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>&nbsp;Update</a>
            <a class="btn btn-danger" href="#" role="button"  data-toggle="modal" data-target="#removeProductModal" onClick="sendProductId(${row.getProductId()});"><span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a>
            </td>         
	  	</tr>
		</c:forEach>
        </tbody>
        </table>
      </div>
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newProductModal">
    	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        &nbsp;Add New Product
    </button>
    </div>
    
   </div>

<!-- Add Product Modal -->
<div class="modal fade" id="newProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add New Product</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/ProductServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Product Information</h3>
        </div><br>
        	<input type="hidden" name="action" value="add"> 	 
  			<div class="form-group">
    			<label for="productName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="productName" name="ProductName" placeholder="Name">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="productPrice" class="col-sm-2 control-label">Price</label>
    			<div class="col-sm-10">
      				<input type="number" class="form-control" id="productPrice" name="ProductPrice" placeholder="Price">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="CatOptions" class="col-sm-2 control-label">Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="catOptions" name="CatOptions">
    					<c:forEach var="row" items="${cat}">
    						<option><c:out value="${row.getCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
    			</div>
  			</div>		
  			<div class="form-group">
    			<label for="SubCatOptions" class="col-sm-2 control-label">Sub-Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="subCatOptions" name="SubCatOptions">
    					<c:forEach var="row" items="${subcat}">
    						<option><c:out value="${row.getSubCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
    			</div>
  			</div>      
  			<script>updateSubCategoriesList();</script>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="publish" class="btn btn-primary">Add</button>
      </div>
      </form>
    </div>
  </div>
</div>

   
<!-- Update Product Modal -->
<div class="modal fade" id="updateProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Update Product</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/ProductServlet" method="post">
      <div class="modal-body">
        <div align="center">
        <h3>Enter Product Information</h3>
        </div><br>
        	<input type="hidden" name="action" value="update"> 
        	<input type="hidden" name="UpdateProductId" id="updateProductId" value=""> 
        		 
  			<div class="form-group">
    			<label for="productName" class="col-sm-2 control-label">Name</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" id="updateProductName" name="UpdateProductName" placeholder="Name">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="productPrice" class="col-sm-2 control-label">Price</label>
    			<div class="col-sm-10">
      				<input type="number" class="form-control" id="updateProductPrice" name="UpdateProductPrice" placeholder="Price">
    			</div>
  			</div>
  			<div class="form-group">
    			<label for="CatOptions" class="col-sm-2 control-label">Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="updateCatOptions" name="UpdateCatOptions">
    					<c:forEach var="row" items="${cat}">
    						<option><c:out value="${row.getCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
    			</div>
  			</div>		
  			<div class="form-group">
    			<label for="SubCatOptions" class="col-sm-2 control-label">Sub-Category</label>
    			<div class="col-sm-10">
    				<select class="form-control" id="updateSubCatOptions" name="UpdateSubCatOptions">
    					<c:forEach var="row" items="${subcat}">
    						<option><c:out value="${row.getSubCategoriesName()}" /></option>
    					</c:forEach>
  					</select>
    			</div>
  			</div>      
  			<script>updateSubCategoriesList2();</script>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" id="publish" class="btn btn-primary">Update</button>
      </div>
      </form>
    </div>
  </div>
</div>
   
   
<!-- Remove Product Modal -->
<div class="modal fade" id="removeProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Remove Product</h4>
      </div>
      <form class="form-horizontal" action="${pageContext.request.contextPath}/ProductServlet" method="post">
      <div class="modal-body">
      	<input type="hidden" name="action" value="remove"> 
  		<input type="hidden" name="ProductId" id="productId" value=""> 
  		<h3>Are you sure you want to remove this product?</h3>  		
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