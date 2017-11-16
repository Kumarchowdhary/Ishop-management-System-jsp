package models;

public class SubCategories {
	private int subCategoriesId;
	private String subCategoriesName;
	private int subCategoriesActive;
	private Categories categories;
	
	public SubCategories(int subCategoriesId, String subCategoriesName,
			int subCategoriesActive, Categories categories) {
		super();
		this.subCategoriesId = subCategoriesId;
		this.subCategoriesName = subCategoriesName;
		this.subCategoriesActive = subCategoriesActive;
		this.categories = categories;
	}

	public int getSubCategoriesId() {
		return subCategoriesId;
	}

	public void setSubCategoriesId(int subCategoriesId) {
		this.subCategoriesId = subCategoriesId;
	}

	public String getSubCategoriesName() {
		return subCategoriesName;
	}

	public void setSubCategoriesName(String subCategoriesName) {
		this.subCategoriesName = subCategoriesName;
	}

	public int getSubCategoriesActive() {
		return subCategoriesActive;
	}

	public void setSubCategoriesActive(int subCategoriesActive) {
		this.subCategoriesActive = subCategoriesActive;
	}

	public Categories getCategories() {
		return categories;
	}

	public void setCategories(Categories categories) {
		this.categories = categories;
	}
}
