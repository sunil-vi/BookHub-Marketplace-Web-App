package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookhub.dao.Book;
import com.bookhub.dao.Cart;
import com.bookhub.util.DBUtil;



public class BookDao {
	private Connection conn;
	private String query;
	private PreparedStatement pst;
    private ResultSet rs,rs9;
    
	public BookDao(Connection conn) {
		super();
		this.conn = conn;
	}
    
    public List<Book> getAllBooks(){
    	List<Book> blist = new ArrayList<>();
    	
    	try {
			query = "select * from books";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();
			
			while (rs.next()) {
				Book book = new Book();
			    book.setId(rs.getInt("id"));
			    book.setBname(rs.getString("bname"));
			    book.setPrice(rs.getInt("price"));
			    book.setAuthor(rs.getString("author"));
			    book.setImage(rs.getString("image"));
			    book.setPdf(rs.getString("pdf"));
			    book.setTags(rs.getString("tags"));
			    book.setBdesc(rs.getString("bdesc"));
			    book.setCat_name(rs.getString("cat_name"));
			    book.setBsold(rs.getInt("bsold"));
			    
			    blist.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return blist;
    }
    
    public Book getSingleBook(int id) {
		 Book book = null;
	        try {
	            query = "select * from books where id=? ";

	            pst = this.conn.prepareStatement(query);
	            pst.setInt(1, id);
	            ResultSet rs = pst.executeQuery();

	            while (rs.next()) {
	            	book = new Book();
	            	book.setId(rs.getInt("id"));
				    book.setBname(rs.getString("bname"));
				    book.setPrice(rs.getInt("price"));
				    book.setAuthor(rs.getString("author"));
				    book.setImage(rs.getString("image"));
				    book.setPdf(rs.getString("pdf"));
				    book.setTags(rs.getString("tags"));
				    book.setBdesc(rs.getString("bdesc"));
				    book.setCat_name(rs.getString("cat_name"));
				    book.setBsold(rs.getInt("bsold"));
	            	
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            
	        }

	        return book;
	    }
    public int getTotalCartPrice(ArrayList<Cart> cartList) {
        int sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select price from books where id=?";
                    pst = this.conn.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        sum+=rs.getInt("price");
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
           
        }
        return sum;
    }
    
    public List<Cart> getCartBooks(ArrayList<Cart> cartList) {
        List<Cart> blist = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select * from books where id=?";
                    pst = this.conn.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    
                    while (rs.next()) {
                        Cart row = new Cart();
                        
                        row.setId(rs.getInt("id"));
                        row.setBname(rs.getString("bname"));
                        row.setImage(rs.getString("image"));
                        row.setCat_name(rs.getString("cat_name"));
                        row.setPrice(rs.getInt("price"));
                        
                        
                        blist.add(row);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return blist;
    }
    
    public List<Book> getUserBooks(String author){
    	List<Book> blist = new ArrayList<>();
    	
    	try {
			query = "select * from books where author= ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, author);
			rs = pst.executeQuery();
			
			while (rs.next()) {
				Book book = new Book();
			    book.setId(rs.getInt("id"));
			    book.setBname(rs.getString("bname"));
			    book.setPrice(rs.getInt("price"));
			    book.setAuthor(rs.getString("author"));
			    book.setImage(rs.getString("image"));
			    book.setPdf(rs.getString("pdf"));
			    book.setTags(rs.getString("tags"));
			    book.setBdesc(rs.getString("bdesc"));
			    book.setCat_name(rs.getString("cat_name"));
			    book.setBsold(rs.getInt("bsold"));
			    
			    blist.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return blist;
    }
    public boolean UpdateBookSoldCount(int bid,String author)
    {
    	int r;
    	String name[] = null;
    	try {
    		query = "SELECT author FROM books WHERE	id="+bid;
    		pst = this.conn.prepareStatement(query);
    		rs9 = pst.executeQuery();
    		if(rs9.next())
    		{
    			name = rs9.getString("author").split(" ");  
    		}
    		
    		query = "UPDATE user SET b_sold = b_sold + 1 WHERE fname LIKE '%"+name[0]+"%'";
    		pst = this.conn.prepareStatement(query);
    		int k = pst.executeUpdate();
    		
    		
    		
			query = "UPDATE books SET bsold = bsold + 1 WHERE id="+bid;
			
			pst = this.conn.prepareStatement(query);
			r = pst.executeUpdate();
			if(r>0) 
					return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return false;
    }

	public boolean UpdateBookBuyCount(int id,int uid) {
		int r;
    	try {
			query = "UPDATE user SET b_bought = b_bought + 1 WHERE id="+uid;
			pst = this.conn.prepareStatement(query);
			r = pst.executeUpdate();
			if(r>0) 
					return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
}
