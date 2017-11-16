package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
	    String uri = ((HttpServletRequest)request).getRequestURI();
		String page = "";

		System.out.println(req.getServletPath());
		//System.out.println(session.getAttribute("uname"));
		
		 if ( uri.indexOf("/css") > 0){
			 chain.doFilter(request, response);
			 return;
		 }
		 else if( uri.indexOf("/images") > 0){
			 chain.doFilter(request, response);
			 return;
		 }
		 else if( uri.indexOf("/js") > 0){
			 chain.doFilter(request, response);
			 return;
		 }
		
		if(req.getServletPath().equals("/SetSession")){
			chain.doFilter(request, response);
			return;
		}
		
		if(session.getAttribute("uname") == null) {
			page = "/LoginView.jsp";
		}
		else if(session.getAttribute("uname") != null && req.getServletPath().equals("/LoginView.jsp"))
		{
			page = "/HomeServlet";
		}
		else {
			chain.doFilter(request, response);
			return;
		}
		RequestDispatcher rd=request.getRequestDispatcher(page);
		rd.forward(req,res);
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
