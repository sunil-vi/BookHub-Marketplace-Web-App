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
import java.util.ArrayList;

import com.bookhub.dao.Cart;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		

        try (PrintWriter out = response.getWriter()) {
        	//out.print("add to cart servlet");
        	
            ArrayList<Cart> cartList = new ArrayList<>(); // Cart of products or temporary to store the whole cart 
            
            int id = Integer.parseInt(request.getParameter("id")); //accept url parameter when book is add
            Cart cm = new Cart();
            
            cm.setId(id);
            cm.setQuantity(1);
            
            
            HttpSession session = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list"); //get pages session attribute which contains cart list of books
            
            if (cart_list == null) {
                
            	cartList.add(cm);
                session.setAttribute("cart-list", cartList);
               dispatcher = request.getRequestDispatcher("index.jsp?success=2");
    			dispatcher.forward(request, response);
    			//response.sendRedirect("index.jsp");
                
            } else {
                cartList = cart_list;

                boolean exist = false;
                for (Cart c : cart_list) {
                    if (c.getId() == id) {
                        exist = true;
                        //out.println("<h3 style='color:crimson; text-align: center'>Item Already in Cart. <a href='cart.jsp'>GO to Cart Page</a></h3>");
                        dispatcher = request.getRequestDispatcher("?error=1");
            			dispatcher.forward(request, response);
                        //response.sendRedirect("index.jsp?error=1");
                    }
                }

                if (!exist) {
                    cartList.add(cm);
                    dispatcher = request.getRequestDispatcher("?success=2");
        			dispatcher.forward(request, response);
                    //response.sendRedirect("index.jsp");
                }
            }
        }
		
	}

	
}
