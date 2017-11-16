package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.collections.MappingChange.Map;

import models.Employee;
import dao.DBManager;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeServlet() {
        super();
        // TODO Auto-generated constructor stub
       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 ArrayList<Employee> employees = DBManager.getEmployees();
	     request.setAttribute("employeesList", employees);
	     RequestDispatcher rd = request.getRequestDispatcher("/EmployeeView.jsp");
	     rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		if(action.equals("add")) {
			String name = request.getParameter("name");
			String user = request.getParameter("username");
			String pass = request.getParameter("password1");
			String gender = request.getParameter("gender");
			String address= request.getParameter("address");
			String cell = request.getParameter("number");
			String date = request.getParameter("hiredate");
			int typeID = DBManager.getEmployeeTypeId(request.getParameter("empType"));
			DBManager.addEmployee(name, user, pass, gender, address, cell, date, 1, typeID);
		}
		else if(action.equals("update")){
			String empId = request.getParameter("employeeId");
			String name = request.getParameter("name");
			String user = request.getParameter("username");
			String pass = request.getParameter("password1");
			String gender = request.getParameter("gender");
			String address= request.getParameter("address");
			String cell = request.getParameter("number");
			String date = request.getParameter("hiredate");
			int typeID = DBManager.getEmployeeTypeId(request.getParameter("empType"));
			DBManager.updateEmployee(Integer.parseInt(empId), name, user, pass, gender, address, cell, date, 1, typeID);
		}
		else if(action.equals("remove")) {
			String empId = request.getParameter("employeeId");
			DBManager.deleteEmployee(Integer.parseInt(empId));
		}
		doGet(request, response);
	}
}