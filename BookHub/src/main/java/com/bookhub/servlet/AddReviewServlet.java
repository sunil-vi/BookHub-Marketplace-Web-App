package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.bookhub.dao.User;
import com.bookhub.util.DBUtil;

/**
 * Servlet implementation class AddReviewServlet
 */
public class AddReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int uid= Integer.parseInt(request.getParameter("uid"));
		
		if(uid == 0) {
			dispatcher = request.getRequestDispatcher("account-signin.jsp?error=8");
			dispatcher.forward(request, response);
		}
		int bid= Integer.parseInt(request.getParameter("bid"));
		int rating= Integer.parseInt(request.getParameter("rating"));
		String uname = request.getParameter("uname");
		String email = request.getParameter("email");
		String review = request.getParameter("review");
		
		try {
			String query = "INSERT INTO review(uname,rating,review,bid,uid) VALUES (?,?,?,?,?)";
			Connection conn = DBUtil.getConnection();
			PreparedStatement pt = conn.prepareStatement(query);
			pt.setString(1,uname);
			pt.setInt(2,rating);
			pt.setString(3,review);
			pt.setInt(4,bid);
			pt.setInt(5,uid);
			
			System.out.println(uid);
			
			int k = pt.executeUpdate();
			if(k>0) {
				dispatcher = request.getRequestDispatcher("marketplace-single.jsp?id="+bid+"&success=1");
				dispatcher.forward(request, response);
			}
				
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
	}

}
