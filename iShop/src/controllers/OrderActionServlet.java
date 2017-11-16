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

import models.Product;
import models.SubCategories;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import dao.DBManager;


/**
 * Servlet implementation class OrderActionServlet
 */
@WebServlet("/OrderActionServlet")
public class OrderActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderActionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String json = null ;
		String changeIn = request.getParameter("changedParameter");
		//System.out.println(changeIn);
		if(changeIn.equals("searchbar")) {
			String getRequest = request.getParameter("getItems");
			if(getRequest == null) {
				getRequest = "";
			}
			if(getRequest.equals("products")) {
				String searchText = request.getParameter("searchtext");
				String categoryName = request.getParameter("categoryname");
				String subCatName = request.getParameter("subcategoryname");
				ArrayList<Product> products;
				if(subCatName.equals("All")) {
					if(categoryName.equals("All")) {
						products = DBManager.getProductsBySearch(searchText);	
					}
					else {
						int catId = DBManager.getCategoryId(categoryName);
						products = DBManager.getProductsByCatId(catId, searchText);
					}
					//products = DBManager.getProducts();
				}
				else {
					int subCatId = DBManager.getSubCategoryId(subCatName);
					products = DBManager.getProducts(subCatId, searchText);	
				}
				Gson gson = new Gson();
				JsonElement element = gson.toJsonTree(products, new TypeToken<List<Product>>() {}.getType());
				
				JsonArray jsonArray = element.getAsJsonArray();
				response.setContentType("application/json");
				response.getWriter().print(jsonArray);
			}
		}
		else if(changeIn.equals("categoryoption")) {
			String getRequest = request.getParameter("getItems");
			if(getRequest == null) {
				getRequest = "";
			}
			if(getRequest.equals("products")) {	 
				String searchText = request.getParameter("searchtext");
				String categoryName = request.getParameter("categoryname");
				String subCatName = request.getParameter("subcategoryname");
				ArrayList<Product> products;
				if(subCatName.equals("All")) {
						if(categoryName.equals("All")) {
							products = DBManager.getProductsBySearch(searchText);	
						}
						else {
							int catId = DBManager.getCategoryId(categoryName);
							products = DBManager.getProductsByCatId(catId, searchText);
						}
				}
				else {
					int subCatId = DBManager.getSubCategoryId(subCatName);
					products = DBManager.getProducts(subCatId, searchText);	
				}
				Gson gson = new Gson();
				JsonElement element = gson.toJsonTree(products, new TypeToken<List<Product>>() {}.getType());
				
				JsonArray jsonArray = element.getAsJsonArray();
				response.setContentType("application/json");
				response.getWriter().print(jsonArray);
			}
			else {
				String categoryName = request.getParameter("categoryname");
				ArrayList<SubCategories> subCategories;
				if(categoryName.equals("All")) {
				    subCategories = DBManager.getSubCategories();
				}
				else {
					int categoryId = DBManager.getCategoryId(categoryName);
				    subCategories = DBManager.getSubCategories(categoryId);	
				}		
				Map<String, String> subCatList = new LinkedHashMap<String, String>();
				for(int x = 0; x < subCategories.size(); x++) {
					subCatList.put(x + "", subCategories.get(x).getSubCategoriesName());
				}
				json= new Gson().toJson(subCatList);
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			}
			
		}
		else if(changeIn.equals("subcategoryoption")) {
			String getRequest = request.getParameter("getItems");
			if(getRequest == null) {
				getRequest = "";
			}
			if(getRequest.equals("products")) {
				String searchText = request.getParameter("searchtext");
				String categoryName = request.getParameter("categoryname");
				String subCatName = request.getParameter("subcategoryname");
				ArrayList<Product> products;
				if(subCatName.equals("All")) {
					if(categoryName.equals("All")) {
						products = DBManager.getProductsBySearch(searchText);	
					}
					else {
						int catId = DBManager.getCategoryId(categoryName);
						products = DBManager.getProductsByCatId(catId, searchText);
					}
					//products = DBManager.getProducts();
				}
				else {
					int subCatId = DBManager.getSubCategoryId(subCatName);
					products = DBManager.getProducts(subCatId, searchText);	
				}
				Gson gson = new Gson();
				JsonElement element = gson.toJsonTree(products, new TypeToken<List<Product>>() {}.getType());
				
				JsonArray jsonArray = element.getAsJsonArray();
				response.setContentType("application/json");
				response.getWriter().print(jsonArray);
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
