package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.bookhub.util.*;
import com.bookhub.dao.*;

/**
 * Servlet implementation class CheckOutServlet
 */
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try(PrintWriter out = response.getWriter()){
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			User auth = (User) request.getSession(false).getAttribute("user");
			
			OrderDao oDao = new OrderDao(DBUtil.getConnection());
			
			
			if(cart_list != null && auth!=null) {
				
					if(oDao.updatePayment(cart_list,auth))
					{
						for(Cart c:cart_list) {
							
							Order order = new Order();
							BookDao bd = new BookDao(DBUtil.getConnection());
							
							if(bd.UpdateBookSoldCount(c.getId(),c.getAuthor()) && bd.UpdateBookBuyCount(c.getId(),auth.getId())) {
								
							order.setId(c.getId()); // set book id into id childs class object
							order.setUid(auth.getId());
							order.setQunatity(c.getQuantity());
							order.setDate(formatter.format(date));
							
							boolean result = oDao.insertOrder(order);
							if(!result) break;
							}
						}
					}else{
						dispatcher = request.getRequestDispatcher("marketplace-checkout.jsp?error=1");
			        	dispatcher.forward(request, response);

					}
				cart_list.clear();
				response.sendRedirect("dashboard-purchases.jsp");
			}else {
			
				 if(auth==null)  
					 response.sendRedirect("account-signin.jsp"); 
				 else 
					 response.sendRedirect("marketplace-cart.jsp");
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
