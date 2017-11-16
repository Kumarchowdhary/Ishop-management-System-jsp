package session;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import dao.DBManager;

/**
 * Servlet implementation class SetSession
 */
@WebServlet("/SetSession")
public class SetSession extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetSession() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name=request.getParameter("username");
		String pass=request.getParameter("password");
		boolean verify = false;
		verify=DBManager.login(name, pass);
		System.out.println(verify);
		if(verify){
			HttpSession session=request.getSession();
			session.setAttribute("uname", name);
			session.setAttribute("password", pass);
			RequestDispatcher rd = request.getRequestDispatcher("/HomeServlet");
			rd.forward(request, response);
			return;
		}
		else { 
			RequestDispatcher rd = request.getRequestDispatcher("/LoginView.jsp");
			rd.forward(request, response);
		}
	}

}
