package dao;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DBConnection {
	static Connection con = null;
	public static Connection makeConnection()
	{
		if(con == null)
		{
			con = getConnection();
			return con;
		}
		return con;
	}
	
	private static Connection getConnection()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/management_system","root","");
		} catch (ClassNotFoundException e) {
			System.out.print("Class not found");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Connecton error");
			e.printStackTrace();
		}
		
		return con;
		
	}
}
