package com.bookhub.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.bookhub.util.DBUtil;
import com.bookhub.dao.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Servlet implementation class AddBookServlet
 */
@MultipartConfig
public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBookServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

//******************************************************************************************************88
		// code to upload image
		Part bimage = request.getPart("bimage"); // to get image of book
		String imageFileName = bimage.getSubmittedFileName(); // get image name

		String uploadPath = "C:/Users/10x Discipline/eclipse-workspace/BookHub/src/main/webapp/assets/bimages/" + imageFileName;
//		System.out.println(imageFileName);

		try {

			// to copy uploding image into bimages folder
			FileOutputStream fos = new FileOutputStream(uploadPath); // open image file where it is going to upload  

			InputStream is = bimage.getInputStream(); //convert into stream selected image
			byte[] data = new byte[is.available()]; 
			is.read(data); //copy image stream

			fos.write(data); // write in the uploading iamge path file
//			System.out.println("Successfully uploaded");
		} catch (Exception e) {
			e.printStackTrace();
			dispatcher = request.getRequestDispatcher("?error=1");
			dispatcher.forward(request, response);
		}
		
//******************************************************************************************************
		//code to upload book pdf
		/*
		 * Part book= request.getPart("bpdf"); // to get pdf of book String pdfFileName
		 * = book.getSubmittedFileName(); // get book name
		 * 
		 * String pdfuploadPath =
		 * "C:/Users/10x Discipline/eclipse-workspace/BookHub/src/main/webapp/assets/bpdf/"
		 * +pdfFileName;
		 * 
		 * try {
		 * 
		 * // to copy uploding book into bpdf folder FileOutputStream fos = new
		 * FileOutputStream(pdfuploadPath); // open book file where it is going to
		 * upload InputStream is = book.getInputStream(); //convert into stream selected
		 * book byte[] pdfdata = new byte[is.available()]; is.read(pdfdata); //copy book
		 * stream
		 * 
		 * fos.write(pdfdata); // write in the uploading book to path file //
		 * System.out.println("Successfully uploaded"); } catch (Exception e) {
		 * e.printStackTrace(); dispatcher = request.getRequestDispatcher("?error=1");
		 * dispatcher.forward(request, response); }
		 */
		
		Part book = request.getPart("bpdf"); // to get pdf of book
		String pdfFileName = book.getSubmittedFileName(); // get book name
		System.out.println(pdfFileName);
		String pdfuploadPath = getServletContext().getRealPath("/") + "assets/bpdf/" + pdfFileName;

		FileOutputStream fos = null;
		InputStream is = null;

		try {
		    File file = new File(pdfuploadPath);
		    if (file.exists()) {
		        // handle case where file already exists
		    }

		    fos = new FileOutputStream(file);
		    is = book.getInputStream();

		    byte[] buffer = new byte[1024];
		    int bytesRead;

		    while ((bytesRead = is.read(buffer)) != -1) {
		        fos.write(buffer, 0, bytesRead);
		    }

		    // System.out.println("Successfully uploaded");
		} catch (Exception e) {
		    e.printStackTrace();
		    dispatcher = request.getRequestDispatcher("?error=1");
		    dispatcher.forward(request, response);
		} finally {
		    if (fos != null) {
		        try {
		            fos.close();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }
		    if (is != null) {
		        try {
		            is.close();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }
		}


		
//******************************************************************************************************
		//upload book data into database s
		String bname = request.getParameter("bname");
		String price = request.getParameter("price");
		
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		//System.out.println(author);
		
		String tags= request.getParameter("tags");
		String bdesc = request.getParameter("bdesc");
		String cat_name= request.getParameter("cat_name");
		
		
		
		
		String query = "INSERT INTO books (bname,price,author,image,pdf,tags,bdesc,cat_name) VALUES (?,?,?,?,?,?,?,?)"; 

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);) {
			
			preparedStatement.setString(1, bname);
			preparedStatement.setString(2, price);
			preparedStatement.setString(3, user.getFname()+" "+user.getLname());
			preparedStatement.setString(4, imageFileName);
			preparedStatement.setString(5, pdfFileName);
			preparedStatement.setString(6, tags);
			preparedStatement.setString(7, bdesc);
			preparedStatement.setString(8, cat_name);
			
			int rows = preparedStatement.executeUpdate();

			if (rows > 0) {
				dispatcher = request.getRequestDispatcher("dashboard-add-new-book.jsp?success=1");
				dispatcher.forward(request, response);
			}
			else {
				dispatcher = request.getRequestDispatcher("dashboard-add-new-book.jsp?error=1");
				dispatcher.forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			dispatcher = request.getRequestDispatcher("dashboard-add-new-book.jsp?error=1");
			dispatcher.forward(request, response);
		}

	}

}
