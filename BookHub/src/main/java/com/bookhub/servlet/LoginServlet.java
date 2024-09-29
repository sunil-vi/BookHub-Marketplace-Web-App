package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.bookhub.dao.UserDao;
import com.bookhub.dao.User;
import com.bookhub.dao.UserDao;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UserDao userDao = new UserDao();
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (userDao.isValidUser(email)) {
        	
        	User user = userDao.getUser(email,password);
        	
            HttpSession session = request.getSession();
            //session.setAttribute("email", email);
            //session.setAttribute("uid", user.getId());
            session.setAttribute("user", user);
            //session.setAttribute("lname", user.getLname());
            
//            response.sendRedirect("index.jsp?success=1");
            dispatcher = request.getRequestDispatcher("index.jsp?success=1");
            dispatcher.forward(request, response);
            
            
            //System.out.println("Hi - "+username);
        } else {
            response.sendRedirect("account-signin.jsp?error=2");
        }
//		System.out.println("In loginServlet");

	}

}
