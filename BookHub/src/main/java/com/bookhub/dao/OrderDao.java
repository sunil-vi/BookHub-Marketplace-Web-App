package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.dao.*;
import com.bookhub.util.DBUtil;
import com.bookhub.util.PayId;


public class OrderDao {
	private Connection conn;
	private String query;
    private PreparedStatement pst;
    private ResultSet rs;
    
    

	public OrderDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean insertOrder(Order order) {
        boolean result = false;
        try {
        	
            query = "insert into orders (b_id, u_id, o_quantity, o_date) values(?,?,?,?)";
            pst = this.conn.prepareStatement(query);
            pst.setInt(1, order.getId()); // book id insert into table
            pst.setInt(2, order.getUid());
            pst.setInt(3, order.getQunatity());
            pst.setString(4, order.getDate());
            pst.executeUpdate();
            
            result = true;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }
	

    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from orders where u_id=? order by orders.o_id desc";
            pst = this.conn.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            
            while (rs.next()) {
            	
                Order order = new Order();
                
                BookDao bookDao = new BookDao(this.conn);
                
                int bId = rs.getInt("b_id");
                
                Book book = bookDao.getSingleBook(bId);
                
                order.setOrderId(rs.getInt("o_id"));
                order.setId(bId);	
                order.setBname(book.getBname());
                order.setImage(book.getImage());
                order.setCat_name(book.getCat_name());
                order.setPrice(book.getPrice());
                order.setQunatity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void cancelOrder(int id) {
        //boolean result = false;
        try {
            query = "delete from orders where o_id=?";
            pst = this.conn.prepareStatement(query);
            pst.setInt(1, id);
            pst.execute();
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        //return result;
    }
    public boolean updatePayment(ArrayList<Cart> cart_list,User user) {
		try {
			BookDao bd = new BookDao(DBUtil.getConnection());
            query = "insert into payment(pid,noofbooks,total,uid) values(?,?,?,?)";
            pst = this.conn.prepareStatement(query);
            pst.setString(1, PayId.pId());
            pst.setInt(2,bd.getTotalCartPrice(cart_list));
            pst.setInt(3,cart_list.size());
            pst.setInt(4, user.getId());
            pst.execute();
            return true;
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
            return false;
        }
		
		
		
		
	}

}
