package models;

import java.util.Date;

public class Employee {	
	private int employeeId;
	private String employeeName;
	private String employeeUsername;
	private String employeePassword;
	private String employeeGender;
	private String employeeAddress;
	private String employeeNum;
	private Date employeeHireDate = new Date();
	private int employeeActive;
	private EmployeeType employeeType;
	
	public Employee(int employeeId, String employeeName,
			String employeeUsername, String employeePassword,
			String employeeGender, String employeeAddress, String employeeNum,
			Date employeeHireDate, int employeeActive, EmployeeType employeeType) {
		super();
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.employeeUsername = employeeUsername;
		this.employeePassword = employeePassword;
		this.employeeGender = employeeGender;
		this.employeeAddress = employeeAddress;
		this.employeeNum = employeeNum;
		this.employeeHireDate = employeeHireDate;
		this.employeeActive = employeeActive;
		this.employeeType = employeeType;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmployeeUsername() {
		return employeeUsername;
	}

	public void setEmployeeUsername(String employeeUsername) {
		this.employeeUsername = employeeUsername;
	}

	public String getEmployeePassword() {
		return employeePassword;
	}

	public void setEmployeePassword(String employeePassword) {
		this.employeePassword = employeePassword;
	}

	public String getEmployeeGender() {
		return employeeGender;
	}

	public void setEmployeeGender(String employeeGender) {
		this.employeeGender = employeeGender;
	}

	public String getEmployeeAddress() {
		return employeeAddress;
	}

	public void setEmployeeAddress(String employeeAddress) {
		this.employeeAddress = employeeAddress;
	}

	public String getEmployeeNum() {
		return employeeNum;
	}

	public void setEmployeeNum(String employeeNum) {
		this.employeeNum = employeeNum;
	}

	public Date getEmployeeHireDate() {
		return employeeHireDate;
	}

	public void setEmployeeHireDate(Date employeeHireDate) {
		this.employeeHireDate = employeeHireDate;
	}

	public int getEmployeeActive() {
		return employeeActive;
	}

	public void setEmployeeActive(int employeeActive) {
		this.employeeActive = employeeActive;
	}

	public EmployeeType getEmployeeType() {
		return employeeType;
	}

	public void setEmployeeType(EmployeeType employeeType) {
		this.employeeType = employeeType;
	}
	
}
