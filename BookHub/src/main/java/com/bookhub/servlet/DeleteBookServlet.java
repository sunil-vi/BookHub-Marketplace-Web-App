package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;

import com.bookhub.dao.*;
import com.bookhub.util.DBUtil;



/**
 * Servlet implementation class DeleteBookServlet
 */
public class DeleteBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try (PrintWriter out = response.getWriter()) {
			int bookId = Integer.parseInt(request.getParameter("id"));
			
			if (bookId != 0) {
				String query = "DELETE FROM books WHERE id=?";
				Connection conn = DBUtil.getConnection();
				PreparedStatement pt = conn.prepareStatement(query);
				pt.setInt(1, bookId);
				int r = pt.executeUpdate();
				if(r>0){
				dispatcher = request.getRequestDispatcher("dashboard-books.jsp");
				dispatcher.forward(request,response);
				}
			} else {
				response.sendRedirect("dashboard-books.jsp");
			}

		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	

}
