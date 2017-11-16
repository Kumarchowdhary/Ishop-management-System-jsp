package controllers;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Product;
import models.Receipt;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import dao.DBManager;

/**
 * Servlet implementation class ReceiptActionServlet
 */
@WebServlet("/ReceiptActionServlet")
public class ReceiptActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReceiptActionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String receiptRows = request.getParameter("receipt");
		JsonParser parser = new JsonParser();
		JsonElement tradeElement = parser.parse(receiptRows);
		JsonArray json = tradeElement.getAsJsonArray();

		Gson gson = new Gson();
		Type collectionType = new TypeToken<List<Receipt>>(){}.getType();
		List<Receipt> jsonNodes = gson.fromJson(json, collectionType);		
		ArrayList<Receipt> completeReceipt = new ArrayList<Receipt>();
		Iterator<Receipt> iterator = jsonNodes.iterator();
		while(iterator.hasNext()){
			Receipt node = (Receipt) iterator.next();
			node.setTotalPrice(node.getProductPrice() * node.getProductQuantity());
			node.setProductId(DBManager.getProductId(node.getProductName().trim()));
			node.setProductName(node.getProductName().trim());
			completeReceipt.add(node);
		}
		
		DBManager.clearReceipt();
		
		for(int x=0; x<completeReceipt.size(); x++) {
			Receipt receipt = completeReceipt.get(x);
			
			DBManager.addReceiptRow(receipt.getProductId(), receipt.getProductName(), receipt.getProductPrice(), receipt.getProductQuantity(), receipt.getTotalPrice());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
