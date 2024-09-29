package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.bookhub.dao.UserDao;
import com.bookhub.util.EmailPassUtil;
import com.bookhub.dao.User;
import com.bookhub.dao.UserDao;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UserDao userDao = new UserDao();
	RequestDispatcher dispatcher;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		String fname= request.getParameter("fname");
        String lname= request.getParameter("lname");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String password= request.getParameter("password");
        String cpass = request.getParameter("cpassword");
        
       
        //System.out.println(fname+lname+email+phno+password+cpass);
        
        

        User user = new User();
        user.setFname(fname);
        user.setLname(lname);
        if(EmailPassUtil.isEmail(email))
    	{
    		user.setEmail(email);
    	}else {
    		dispatcher = request.getRequestDispatcher("account-signin.jsp?error=5");
        	dispatcher.forward(request, response);
    	}
        	
        
        if(cpass.equals(password) && EmailPassUtil.isPass(password))
        {
        	user.setPassword(password);
        }else{
        	dispatcher = request.getRequestDispatcher("account-signin.jsp?error=6");
        	dispatcher.forward(request, response);

        }
        user.setPhno(phno);
        

        
		//UserDao userDao = new UserDao();
       if(!userDao.isUserPresent(email)){
        	if(userDao.addUser(user)) {
        	//response.sendRedirect("account-signin.jsp?registration=success");
        	dispatcher = request.getRequestDispatcher("account-signin.jsp?registration=success");
        	dispatcher.forward(request, response);
        	}else {
        		dispatcher = request.getRequestDispatcher("account-signin.jsp?error=1");
        		dispatcher.forward(request, response);
        	}
       }else{
		// response.sendRedirect("account-signin.jsp?error=1");
		dispatcher = request.getRequestDispatcher("account-signin.jsp?error=4");
		dispatcher.forward(request, response);
       }

//		doGet(request, response);

}

}
