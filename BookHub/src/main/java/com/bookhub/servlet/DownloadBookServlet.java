package com.bookhub.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.sql.SQLException;

import com.bookhub.dao.BookDao;
import com.bookhub.dao.Book;
import com.bookhub.util.DBUtil;

import java.io.IOException;

/**
 * Servlet implementation class DownloadBookServlet
 */
public class DownloadBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Book book = new Book();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		BookDao bd = null;
		try {
			bd = new BookDao(DBUtil.getConnection());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String SAVE_DIR = "assets/bpdf";
		int bid =Integer.parseInt(request.getParameter("bid"));
		book = bd.getSingleBook(bid);
	
		   
        // reads input file from an absolute path
        String filePath = getServletContext().getRealPath("") + File.separator + SAVE_DIR + File.separator +  book.getPdf();
//        System.out.println(filePath);
        File downloadFile = new File(filePath);
        FileInputStream inStream = new FileInputStream(downloadFile);

     // if you want to use a relative path to context root:
        String relativePath = getServletContext().getRealPath("");
        //System.out.println("relativePath = " + relativePath);

     
        // obtains ServletContext
        ServletContext context = getServletContext();
        
        // gets MIME type of the file
        String mimeType = context.getMimeType(filePath);
        if (mimeType == null) {        
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }
        System.out.println("MIME type: " + mimeType);

        // modifies response
        response.setContentType(mimeType);
        response.setContentLength((int) downloadFile.length());

        // forces download
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
        response.setHeader(headerKey, headerValue);

        // obtains response's output stream
        OutputStream outStream = response.getOutputStream();

        byte[] buffer = new byte[4096];
        int bytesRead = -1;

        while ((bytesRead = inStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }

        inStream.close();
        outStream.close();     
    }

}
