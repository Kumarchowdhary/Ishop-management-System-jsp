package models;

public class Product {
	private int productId;
	private String productName;
	private int productPrice;
	private int productActive;
	private SubCategories subCategories;
	
	public Product(int productId, String productName, int productPrice,
			int productActive, SubCategories subCategories) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productActive = productActive;
		this.subCategories = subCategories;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	
	public int getProductActive() {
		return productActive;
	}

	public void setProductActive(int productActive) {
		this.productActive = productActive;
	}

	public SubCategories getSubCategories() {
		return subCategories;
	}

	public void setSubCategories(SubCategories subCategories) {
		this.subCategories = subCategories;
	}

}