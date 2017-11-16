package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import dao.DBManager;
import models.Product;
import models.SubCategories;

/**
 * Servlet implementation class ProductActionServlet
 */
@WebServlet("/ProductActionServlet")
public class ProductActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductActionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String json = null ;
		String action = request.getParameter("Action");
		if(action == null) {
			action="";
		}
		if(action.equals("updateSubCatList")) {
			String categoryName = request.getParameter("categoryname");
			ArrayList<SubCategories> subCategories;
			int categoryId = DBManager.getCategoryId(categoryName);
	    	subCategories = DBManager.getSubCategories(categoryId);	
	    	Map<String, String> subCatList = new LinkedHashMap<String, String>();
			for(int x = 0; x < subCategories.size(); x++) {
				subCatList.put(x + "", subCategories.get(x).getSubCategoriesName());
			}
			json= new Gson().toJson(subCatList);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		else if(action.equals("add")){
			String productName = request.getParameter("ProductName");
			int productPrice = Integer.parseInt(request.getParameter("ProductPrice"));
			int subCategoriesId = DBManager.getSubCategoryId(request.getParameter("SubCatOptions"));
			DBManager.addProduct(productName, productPrice, 1, subCategoriesId);
			ArrayList<Product> products = DBManager.getProducts();
			
			Gson gson = new Gson();
			JsonElement element = gson.toJsonTree(products, new TypeToken<List<Product>>() {}.getType());
			JsonArray jsonArray = element.getAsJsonArray();
			response.setContentType("application/json");
			response.getWriter().print(jsonArray);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
