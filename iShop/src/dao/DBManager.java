package dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Date;

import models.Categories;
import models.Employee;
import models.EmployeeType;
import models.Product;
import models.SubCategories;

public class DBManager {
	static Connection con = DBConnection.makeConnection();
	
	public static Boolean login(String user, String pass){
		try {
			Statement stm = con.createStatement();
	        ResultSet rst = stm.executeQuery("Select * from employee where emp_username = '" + user + "' AND emp_password = '" + pass + "' AND emp_active = 1");
	        while(rst.next()) {
	        	return true;
	        }
	    } catch (SQLException ex) {
	    	Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
	    	return false;
	}
	
	/////////////////////
	// Employee Methods
	/////////////////////
	public static int addEmployee(String name, String user, String pass, String gender, String address, String cell, String date, int status, int typeID) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Insert into employee(emp_name, emp_username, emp_password, emp_gender, emp_address, emp_cellno, emp_hiredate, emp_active, emp_type_id) values ('" +name+ "', '" +user+ "', '" +pass+ "', '" +gender+ "', '" +address+ "', '" +cell+ "', '" +date+ "', " +status+ ", " +typeID+ ")";
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	

	public static int updateEmployee(int empId, String name, String user, String pass, String gender, String address, String cell, String date, int status, int typeID) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Update employee set emp_name = '" +name+ "', emp_username = '" +user+ "', emp_password = '" +pass+ "', emp_gender = '" +gender+ "', emp_address = '" +address+ "', emp_cellno = '" +cell+ "', emp_hiredate = '" +date+ "', emp_active = " +status+ ", emp_type_id = " +typeID+ " where emp_id = " +empId;
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int deleteEmployee(int empId) {
		int successful = 0;
        try {
           Statement stm = con.createStatement();
           String query = "Update employee set emp_active = 0 where emp_id =" + empId ;
           successful = stm.executeUpdate(query);
        } catch (SQLException ex) {
           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
       return successful;
	}
	
	public static ArrayList<Employee> getEmployees() {
		ArrayList<Employee> employees = new ArrayList<Employee>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from employee e inner join employee_type et on e.emp_type_id = et.emp_type_id where emp_active = 1");
			while(rst.next()) {
				EmployeeType employeeType=new EmployeeType();
				employeeType.setEmployeeTypeId(rst.getInt("emp_type_id"));
				employeeType.setEmployeeTypeName(rst.getString("emp_type_name"));
				employees.add(new Employee(rst.getInt("emp_id"), rst.getString("emp_name"), rst.getString("emp_username"), rst.getString("emp_password"), rst.getString("emp_gender"), rst.getString("emp_address"), rst.getString("emp_cellno"), rst.getDate("emp_hiredate"), rst.getInt("emp_active"), employeeType));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return employees;
	}
	
	public static Employee getEmployee(String username) {
		Employee emp = null;
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from employee e inner join employee_type et on e.emp_type_id = et.emp_type_id where emp_active = 1 and emp_username = '"+ username +"'");
			while(rst.next()) {
				EmployeeType employeeType=new EmployeeType();
				employeeType.setEmployeeTypeId(rst.getInt("emp_type_id"));
				employeeType.setEmployeeTypeName(rst.getString("emp_type_name"));
				emp = new Employee(rst.getInt("emp_id"), rst.getString("emp_name"), rst.getString("emp_username"), rst.getString("emp_password"), rst.getString("emp_gender"), rst.getString("emp_address"), rst.getString("emp_cellno"), rst.getDate("emp_hiredate"), rst.getInt("emp_active"), employeeType);
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return emp;
	}
	
	public static int getEmployeeTypeId(String employeeTypeName) {
		int empTypeId = 0;
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select emp_type_id from employee_type where emp_type_name ='" + employeeTypeName + "'");
			while(rst.next()) {
				empTypeId = rst.getInt("emp_type_id");
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
		}
		return empTypeId;
	}
	
	public static String getEmployeeTypeName(int employeeTypeId) {
		String empTypeName = "";
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select emp_type_name from employee_type where emp_type_id =" + employeeTypeId);
			while(rst.next()) {
				empTypeName = rst.getString("emp_type_name");
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
		}
		return empTypeName;
	}
	
	//////////////////////
	// Categories Methods
	//////////////////////
	
	public static ArrayList<Categories> getCategories() {
		ArrayList<Categories> categories = new ArrayList<Categories>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from categories where categories_active = 1");
			while(rst.next()) {
				categories.add(new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active")));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return categories;
	}
	
	public static int addCategory(String catName, int status) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Insert into categories(categories_name, categories_active) values ('" +catName+ "'," +status+ ")";
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int updateCategory(int catId, String catName, int status) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Update categories set categories_name = '" +catName+ "', categories_active = " +status+ " where categories_id = " +catId;
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int deleteCategory(int catId) {
		int successful = 0;
        try {
           Statement stm = con.createStatement();
           String query = "Update categories set categories_active = 0 where categories_id =" + catId;
           successful = stm.executeUpdate(query);
        } catch (SQLException ex) {
           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
       return successful;
	}
	
	public static int getCategoryId(String catName) {
		int catId = 0;
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select categories_id from categories where categories_name ='" + catName + "'");
			while(rst.next()) {
				catId = rst.getInt("categories_id");
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
		}
		return catId;
	}
	
	
	////////////////////////////
	// Sub-Categories Methods
	///////////////////////////
	public static ArrayList<SubCategories> getSubCategories() {
		ArrayList<SubCategories> subCategories = new ArrayList<SubCategories>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from categories c inner join sub_categories sc on c.categories_id = sc.categories_id where sub_categories_active = 1");
			while(rst.next()) {
				Categories category=new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				subCategories.add(new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return subCategories;
	}
	
	public static ArrayList<SubCategories> getSubCategories(int catID) {
		ArrayList<SubCategories> subCategories = new ArrayList<SubCategories>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from categories c inner join sub_categories sc on c.categories_id = sc.categories_id where sub_categories_active = 1 and sc.categories_id = " + catID);
			while(rst.next()) {
				Categories category=new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				subCategories.add(new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return subCategories;
	}
	
	public static int addSubCategory(String subCatName, int status, int catId) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Insert into sub_categories(sub_categories_name, sub_categories_active, categories_id) values ('" +subCatName+ "'," +status+ ", " +catId+ ")";
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int updateSubCategory(int subCatId, String subCatName, int status, int catId) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Update sub_categories set sub_categories_name = '" +subCatName+ "', sub_categories_active = " +status+ ", categories_id = " +catId+ "  where sub_categories_id = " +subCatId;
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int deleteSubCategory(int subCatId) {
		int successful = 0;
        try {
           Statement stm = con.createStatement();
           String query = "Update sub_categories set sub_categories_active = 0 where sub_categories_id =" + subCatId;
           successful = stm.executeUpdate(query);
        } catch (SQLException ex) {
           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
       return successful;
	}
	
	public static int getSubCategoryId(String subCatName) {
		int subCatId = 0;
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select sub_categories_id from sub_categories where sub_categories_name ='" + subCatName + "'");
			while(rst.next()) {
				subCatId = rst.getInt("sub_categories_id");
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
		}
		return subCatId;
	}
	
	////////////////////////////
	//Products Methods
	///////////////////////////
	public static ArrayList<Product> getProducts() {
		ArrayList<Product> products = new ArrayList<Product>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from product p inner join sub_categories sc on p.sub_categories_id = sc.sub_categories_id inner join categories c on c.categories_id = sc.categories_id where product_active = 1");
			while(rst.next()) {
				Categories category = new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				SubCategories subCategory = new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category);
				products.add(new Product(rst.getInt("product_id"), rst.getString("product_name"), rst.getInt("product_price") ,rst.getInt("product_active"), subCategory));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return products;
	}
	
	public static ArrayList<Product> getProductsBySearch(String searchText) {
		ArrayList<Product> products = new ArrayList<Product>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from product p inner join sub_categories sc on p.sub_categories_id = sc.sub_categories_id inner join categories c on c.categories_id = sc.categories_id where p.product_name like '%" + searchText + "%' AND product_active = 1");
			while(rst.next()) {
				Categories category = new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				SubCategories subCategory = new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category);
				products.add(new Product(rst.getInt("product_id"), rst.getString("product_name"), rst.getInt("product_price") ,rst.getInt("product_active"), subCategory));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return products;
	}
	
	public static ArrayList<Product> getProducts(int subCatID, String searchText) {
		ArrayList<Product> products = new ArrayList<Product>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from product p inner join sub_categories sc on p.sub_categories_id = sc.sub_categories_id inner join categories c on c.categories_id = sc.categories_id where sc.sub_categories_id =" + subCatID + " AND p.product_name like '%" + searchText + "%' AND product_active = 1");
			while(rst.next()) {
				Categories category = new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				SubCategories subCategory = new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category);
				products.add(new Product(rst.getInt("product_id"), rst.getString("product_name"), rst.getInt("product_price") ,rst.getInt("product_active"), subCategory));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return products;
	}
	
	public static ArrayList<Product> getProductsByCatId(int catID, String searchText) {
		ArrayList<Product> products = new ArrayList<Product>();
		
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select * from product p inner join sub_categories sc on p.sub_categories_id = sc.sub_categories_id inner join categories c on c.categories_id = sc.categories_id where c.categories_id =" + catID  + " AND p.product_name like '%" + searchText + "%' AND product_active = 1");
			while(rst.next()) {
				Categories category = new Categories(rst.getInt("categories_id"), rst.getString("categories_name"), rst.getInt("categories_active"));
				SubCategories subCategory = new SubCategories(rst.getInt("sub_categories_id"), rst.getString("sub_categories_name"), rst.getInt("sub_categories_active"), category);
				products.add(new Product(rst.getInt("product_id"), rst.getString("product_name"), rst.getInt("product_price") ,rst.getInt("product_active"), subCategory));
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	    }
		return products;
	}
	
	public static int getProductId(String productName) {
		int productId = 0;
		try {
			Statement stm = con.createStatement();
			ResultSet rst = stm.executeQuery("Select product_id from product where product_name ='" + productName + "'");
			while(rst.next()) {
				productId = rst.getInt("product_id");
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
		}
		return productId;
	}
	
	public static int deleteProduct(int productId) {
		int successful = 0;
        try {
           Statement stm = con.createStatement();
           String query = "Update product set product_active = 0 where product_id =" + productId;
           successful = stm.executeUpdate(query);
        } catch (SQLException ex) {
           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
       return successful;
	}
	
	public static int addProduct(String productName, int productPrice, int status, int subCategoriesId) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Insert into product(product_name, product_price, product_active, sub_categories_id) values ('" +productName+ "'," +productPrice+ "," +status+ "," +subCategoriesId+ ")";
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int updateProduct(int productId, String productName, int productPrice, int status, int subCategoriesId) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Update product set product_name = '" +productName+ "', product_price = " +productPrice+ ", product_active = " +status+ ", sub_categories_id = " +subCategoriesId+ "  where product_id = " +productId;
	           System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	
	////////////////////////////
	//Receipt Methods
	///////////////////////////
	public static int addReceiptRow(int productId, String productName, int productPrice, int productQuantity, int totalPrice) {
		int successful = 0;
	       try {
	           Statement stm = con.createStatement();
	           String query = "Insert into receipt(product_id, product_name, product_price, product_quantity, total_price) values ("+productId+ ", '" +productName+ "'," +productPrice+ ","+productQuantity+","+totalPrice+")";
	           //System.out.print(query);
	           successful = stm.executeUpdate(query);
	       } catch (SQLException ex) {
	           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
	       }
	       return successful;
	}
	
	public static int clearReceipt()
    {
        int successful = 0;
        try {
            Statement stm = con.createStatement();
            String query = "Delete from receipt";
            //System.out.print(query);
            successful = stm.executeUpdate(query);
        } catch (SQLException ex) {
           Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return successful;
    }
	
}
	

