<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Categories" %>
<%@ page import="models.SubCategories" %>
<%@ page import="models.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
	<title>Order Area</title>
	<meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/offcanvas.css" rel="stylesheet">
	<link href="css/mainstyle.css" rel="stylesheet">
	<link href="css/orderstyle.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/offcanvas.js"></script>    
    <script src="js/bootstrap.min.js"></script>
    <!-- AJAX Coding -->
    <script>
	$(document).ready(function() {
		
		$('#search').on('input', function(event) {
			var $searchtext=$("#search").val();
			var $category=$("select#catOptions").val();
			var $subcategory=$("select#subCatOptions").val();
			var $changeIn = "searchbar";
			var $get = "products";
				//Change the products
				$.get('OrderActionServlet',{searchtext: $searchtext,categoryname:$category, subcategoryname:$subcategory, changedParameter:$changeIn, getItems:$get},function(responseJson) {
						if(responseJson != null) {
							$("#productTable").find("tr:gt(0)").remove();
							var table = $("#productTable");
							$.each(responseJson, function(key,value) {
								var rowNew = $("<tr><td></td><td></td><td></td><td></td><td></td></tr>");
								rowNew.children().eq(0).text(value['productName']);
								rowNew.children().eq(1).text(value['productPrice']);
								rowNew.children().eq(2).text(value['subCategories'].categories.categoriesName);
								rowNew.children().eq(3).text(value['subCategories'].subCategoriesName);
								rowNew.children().eq(4).html("<a class='btn btn-primary' href='#' role='button' data-toggle='modal' data-target='#updateCategoryModal' onClick='fillCatUpdateForm('${details}');'><span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>&nbsp;Add</a>");
								rowNew.appendTo(table);
							});
						}
				});
			});
		
		$('#catOptions').change(function(event) {
		var $searchtext=$("#search").val();
		var $category=$("select#catOptions").val();
		var $subcategory= "All";
		var $changeIn = "categoryoption";
		var $get = "products";
			//Change the subcategory options
			$.get('OrderActionServlet',{categoryname:$category, changedParameter:$changeIn},function(responseJson) {
				var $select = $('#subCatOptions');
				$select.find('option').remove();
				$('<option>').text("All").appendTo($select);
				$.each(responseJson, function(key, value) {
				$('<option>').text(value).appendTo($select);
				});
			});
			//Change the products
			$.get('OrderActionServlet',{searchtext: $searchtext, categoryname:$category, subcategoryname:$subcategory, changedParameter:$changeIn, getItems:$get},function(responseJson) {
				if(responseJson != null) {
					$("#productTable").find("tr:gt(0)").remove();
					var table = $("#productTable");
					$.each(responseJson, function(key,value) {
						var rowNew = $("<tr><td></td><td></td><td></td><td></td><td></td></tr>");
						rowNew.children().eq(0).text(value['productName']);
						rowNew.children().eq(1).text(value['productPrice']);
						rowNew.children().eq(2).text(value['subCategories'].categories.categoriesName);
						rowNew.children().eq(3).text(value['subCategories'].subCategoriesName);
						rowNew.children().eq(4).html("<a class='btn btn-primary' href='#' role='button' data-toggle='modal' data-target='#updateCategoryModal' onClick='fillCatUpdateForm('${details}');'><span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>&nbsp;Add</a>");
						rowNew.appendTo(table);
					});
				}
			});
		});
		
	$('#subCatOptions').change(function(event) {
		var $searchtext=$("#search").val();
		var $category=$("select#catOptions").val();
		var $subcategory=$("select#subCatOptions").val();
		var $changeIn = "subcategoryoption";
		var $get = "products";
			$.get('OrderActionServlet',{searchtext: $searchtext, categoryname:$category, subcategoryname:$subcategory, changedParameter:$changeIn, getItems:$get},function(responseJson) {
					if(responseJson != null) {
						$("#productTable").find("tr:gt(0)").remove();
						var table = $("#productTable");
						$.each(responseJson, function(key,value) {
							var rowNew = $("<tr><td></td><td></td><td></td><td></td><td></td></tr>");
							rowNew.children().eq(0).text(value['productName']);
							rowNew.children().eq(1).text(value['productPrice']);
							rowNew.children().eq(2).text(value['subCategories'].categories.categoriesName);
							rowNew.children().eq(3).text(value['subCategories'].subCategoriesName);
							rowNew.children().eq(4).html("<a class='btn btn-primary' href='#' role='button' data-toggle='modal' data-target='#updateCategoryModal' onClick='fillCatUpdateForm('${details}');'><span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>&nbsp;Add</a>");
							rowNew.appendTo(table);
						});
					}
			});
		});
	
			
		var receiptRows = [];
		$('#generateReceipt').click(function() {
			$('#receiptTable tbody tr').each(function(){
				var $productName = $(this).find('#productName').text();
				var $productPrice = $(this).find('#productPrice').text();
				var $productQuantity = $(this).find('#productQuantity').val();
				var $receiptRow = {productName: $productName, productPrice: $productPrice, productQuantity: $productQuantity}
				receiptRows.push($receiptRow);
			});
			var $receipt = JSON.stringify(receiptRows);
			console.log(receiptRows);
			$.get('ReceiptActionServlet',{receipt: $receipt}, function(responseJson) {
				if(responseJson != null) {
					
				}
			});
			receiptRows = [];
		});
		
		$("#clearReceipt").click(function() {
			$("#receiptTable").find("tr:gt(0)").remove();
		});
	
	});
	</script>
	
	<!-- Functions -->	
	<script>
	function addToReceipt(details){
		var productDetails = details.split(",");
		var rowId = productDetails[0];
		if($('table#receiptTable').find('#'+rowId).length > 0) {
			$('.product-alert').modal('show');
		}
		else {
			$('#receiptTable tbody').append('<tr id="'+productDetails[0]+'"><td id="productName">' + productDetails[1] + '</td><td id="productPrice">' + productDetails[2] + '</td> <td class="col-xs-1"><input id="productQuantity" type="number" class="form-control" id="quantityNo" name="quantityNo" placeholder="0" value="1"> </td>' + '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'  + '<a class="btn btn-danger" role="button"  onClick="removeFromReceipt('+productDetails[0]+');">  <span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>&nbsp;Remove</a></td>' + '</tr>');
		}
	}
	
	function removeFromReceipt(id) {
		$('table#receiptTable tr#'+id).remove();
			
	}
	</script>
</head>
<body>
<%
	ArrayList<Categories> categories = (ArrayList) request.getAttribute("categoriesList");
	ArrayList<SubCategories> subCategories = (ArrayList) request.getAttribute("SubCategoriesList");
	ArrayList<Product> products = (ArrayList) request.getAttribute("productsList");
	pageContext.setAttribute("cat", categories);
	pageContext.setAttribute("subcat", subCategories);
	pageContext.setAttribute("products", products);
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

    <h1 class="text-center"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Order Area</h1>

    <p class="lead text-center">
      Place the order here
     </p>
    <div class="container">
      <div class="well col-sm-12">
      	<div class="col-sm-6">
      		<div class="form-group">
            	<label for="search" class="col-sm-5 control-label">Search Product:</label>
            	<input type="text" class="form-control" id="search" name="search" placeholder="Product">
          	</div>
	  	</div>
	  	<div class="col-sm-3">
      		<div class="form-group">
            	<label for="search" class="col-sm-12 control-label">Select Category:</label>
				<select class="form-control" id="catOptions" name="catOptions">
    				<option>All</option>
    				<c:forEach var="row" items="${cat}">   				
    				<option><c:out value="${row.getCategoriesName()}" /></option>
    				</c:forEach>
  				</select>
  			</div>
	  	</div>
	  	<div class="col-sm-3">
      		<div class="form-group">
            	<label for="search" class="col-sm-12 control-label">Select Sub-Category:</label>
				<select class="form-control" id="subCatOptions" name="subCatOptions">
    				<option>All</option>
    				<c:forEach var="row" items="${subcat}">   				
    				<option><c:out value="${row.getSubCategoriesName()}" /></option>
    				</c:forEach>
  				</select>
  			</div>
	  	</div>
	  	<div id="productsTable" class="well table-responsive">
        <table id="productTable" class="table table-hover">
        <thead>
          <tr>
            <th>Product Name</th>
            <th>Product Price</th>
            <th>Category</th>
            <th>Sub-Category</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="row" items="${products}">
        <tr>
        	<td><c:out value="${row.getProductName()}" /></td>
			<td><c:out value="${row.getProductPrice()}" /></td>
			<td><c:out value="${row.getSubCategories().getCategories().getCategoriesName()}" /></td>
			<td><c:out value="${row.getSubCategories().getSubCategoriesName()}" /></td>
			<c:set var="details" scope="session" value="${row.getProductId()}, ${row.getProductName()},${row.getProductPrice()}" />
	  		<td>
            <a class="btn btn-primary" role="button" onClick="addToReceipt('${details}');"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Add</a>
            </td>         
	  	</tr>
		</c:forEach>
        </tbody>
        </table>
      </div>			
      </div>
    	
    	<div class="well col-sm-12">
    	<p class="lead text-center">
      		Receipt
     	</p>
     	<div id="receiptsTable" class="well table-responsive">
        <table id="receiptTable" class="table table-hover">
        <thead>
          <tr>
            <th>Product Name</th>
            <th>Product Price</th>
            <th>Quantity</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
      	
        </tbody>
        </table>
      </div>
		<div class="clearfix">
			<div class="pull-right">
			    <a id="clearReceipt" class="btn btn-default" role="button"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Clear Receipt</a>
        		<a href="${pageContext.request.contextPath}/run?__report=new_report.rptdesign&__format=pdf" id="generateReceipt" class="btn btn-primary " role="button" target="_blank"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Generate Receipt</a>
    		</div>
    	</div>
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
	
	<!-- Product Alert Modal -->
	<div class="modal fade product-alert" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  		
  		<div class="modal-dialog modal-md" role="document">
    		<div class="modal-content">
   		   		
      			<div class="modal-body">
      				<h3><b>Alert!</b> This product is already present in the receipt.</h3>
      			</div>
    		</div>
  		</div>
	</div>

</body>
</html>