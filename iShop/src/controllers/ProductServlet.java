package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Categories;
import models.Product;
import models.SubCategories;
import dao.DBManager;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Categories> categories = DBManager.getCategories();
	    request.setAttribute("categoriesList", categories);
	    ArrayList<SubCategories> subCategories = DBManager.getSubCategories();
	    request.setAttribute("subCategoriesList", subCategories);
		ArrayList<Product> products = DBManager.getProducts();
	    request.setAttribute("products", products);
	    RequestDispatcher rd = request.getRequestDispatcher("/ProductView.jsp");
	    rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		if(action.equals("add")) {
			String productName = request.getParameter("ProductName");
			int productPrice = Integer.parseInt(request.getParameter("ProductPrice"));
			int subCategoriesId = DBManager.getSubCategoryId(request.getParameter("SubCatOptions"));
			DBManager.addProduct(productName, productPrice, 1, subCategoriesId);
		}
		else if(action.equals("update")) {
			int productId = Integer.parseInt(request.getParameter("UpdateProductId"));
			String productName = request.getParameter("UpdateProductName");
			int productPrice = Integer.parseInt(request.getParameter("UpdateProductPrice"));
			int subCategoriesId = DBManager.getSubCategoryId(request.getParameter("UpdateSubCatOptions"));
			DBManager.updateProduct(productId, productName, productPrice, 1, subCategoriesId);
		}
		else if(action.equals("remove")) {
			String productId = request.getParameter("ProductId");
			DBManager.deleteProduct(Integer.parseInt(productId));
		}
		doGet(request, response);
	}

}
