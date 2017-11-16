package models;

public class Company {
	private int companyId;
	private String companyName;
	private String companyCity;
	private int companyActive;
	
	public Company(int companyId, String companyName, String companyCity,
			int companyActive) {
		super();
		this.companyId = companyId;
		this.companyName = companyName;
		this.companyCity = companyCity;
		this.companyActive = companyActive;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyCity() {
		return companyCity;
	}

	public void setCompanyCity(String companyCity) {
		this.companyCity = companyCity;
	}

	public int getCompanyActive() {
		return companyActive;
	}

	public void setCompanyActive(int companyActive) {
		this.companyActive = companyActive;
	}

}
