package models;

public class Categories {
	private int categoriesId;
	private String categoriesName;
	private int categoriesActive;
	
	public Categories(int categoriesId, String categoriesName,
			int categoriesActive) {
		super();
		this.categoriesId = categoriesId;
		this.categoriesName = categoriesName;
		this.categoriesActive = categoriesActive;
	}

	public int getCategoriesId() {
		return categoriesId;
	}

	public void setCategoriesId(int categoriesId) {
		this.categoriesId = categoriesId;
	}

	public String getCategoriesName() {
		return categoriesName;
	}

	public void setCategoriesName(String categoriesName) {
		this.categoriesName = categoriesName;
	}

	public int getCategoriesActive() {
		return categoriesActive;
	}

	public void setCategoriesActive(int categoriesActive) {
		this.categoriesActive = categoriesActive;
	}
	
	
}
