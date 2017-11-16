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
import models.SubCategories;
import dao.DBManager;

/**
 * Servlet implementation class CategoriesServlet
 */
@WebServlet("/CategoriesServlet")
public class CategoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriesServlet() {
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
	    request.setAttribute("SubCategoriesList", subCategories);
	    RequestDispatcher rd = request.getRequestDispatcher("/CategoriesView.jsp");
	    rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String section = request.getParameter("section");
		String action = request.getParameter("action");
		if(section.equals("categories")) {
			if(action.equals("add")){
				String catName = request.getParameter("CatName");
				DBManager.addCategory(catName, 1);
			}
			else if(action.equals("update")) {
				String catId = request.getParameter("CategoryId");
				String catName = request.getParameter("CatName");
				DBManager.updateCategory(Integer.parseInt(catId), catName, 1);
			}
			else if(action.equals("remove")) {
				String catId = request.getParameter("categoryId");
				DBManager.deleteCategory(Integer.parseInt(catId));
			}
		}
		else if(section.equals("subcategories")) {
			if(action.equals("add")){
				String subCatName = request.getParameter("SubCatName");
				int catID = DBManager.getCategoryId(request.getParameter("CatName"));
				DBManager.addSubCategory(subCatName, 1, catID );
			}
			else if(action.equals("update")) {
				String subCatId = request.getParameter("SubCategoryId");
				String subCatName = request.getParameter("SubCatName");
				System.out.println(request.getParameter("CatName"));
				int catID = DBManager.getCategoryId(request.getParameter("CatName"));
				DBManager.updateSubCategory(Integer.parseInt(subCatId), subCatName, 1, catID );
			}
			else if(action.equals("remove")) {
				String subCatId = request.getParameter("subCategoryId");
				DBManager.deleteSubCategory(Integer.parseInt(subCatId));
			}
		}
		doGet(request, response);
	}

}
