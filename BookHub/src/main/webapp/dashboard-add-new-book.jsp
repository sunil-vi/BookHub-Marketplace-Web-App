<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.bookhub.util.*" %>
<%@ page import="com.bookhub.dao.*" %>
<%
// Retrieve the session object
HttpSession session1 = request.getSession(false);
User user;
// Check if the session is not null and the user attribute is set
if (session1.getAttribute("user") != null) {
	user = (User)session.getAttribute("user");
	
} else {
	user = null;
	
}
//BookDao bd = new BookDao(DBUtil.getConnection());
//List<Book> books = bd.getAllBooks();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

%>


<!DOCTYPE html>
<html lang="en">

<head>
<title>Add new book</title>
<%@ include file="includes/head.jsp"%>
</head>

<!-- Body-->
<body class="handheld-toolbar-enabled">
<%
	String success = (String)request.getParameter("success");
	String error = (String)request.getParameter("error");
	if (success !=null && success.equals("1") ) {
%>
		<!-- Success alert -->
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<span class="fw-medium">Book</span> uploaded successfully.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
<%	
} else if (error!=null && error.equals("1")) {
%>
<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Book</span> upload failed. Try Again.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
<%} %>



	<main class="page-wrapper">
		<!-- Navbar Marketplace-->
		<%@ include file="includes/header.jsp"%>
		<!-- Dashboard header-->
		<%@ include file="includes/dashboard-header.jsp" %>
		<div class="container mb-5 pb-3">
			<div class="bg-light shadow-lg rounded-3 overflow-hidden">
				<div class="row">
					<!-- Sidebar-->
					<%@ include file="includes/sidebar.jsp" %>
					<!-- Content-->
					<section class="col-lg-8 pt-lg-4 pb-4 mb-3">
						<div class="pt-2 px-4 ps-lg-0 pe-xl-5">
							<form action="AddBookServlet" method="POST" enctype="multipart/form-data">
								<!-- Title-->
								<div
									class="d-sm-flex flex-wrap justify-content-between align-items-center pb-2">
									<h2 class="h3 py-2 me-2 text-center text-sm-start">Add New
										Book</h2>
									<div class="py-2">
										<select class="form-select me-2" id="unp-category" name="cat_name">
											<option >Select category</option>
											<%
												try{
													Connection conn = DBUtil.getConnection();
													Statement st = conn.createStatement();
													ResultSet rs = st.executeQuery("SELECT * FROM category");
													while(rs.next())
													{%>
														<option value="<%=rs.getString(2) %>"><%=rs.getString(2) %></option>
													<%}
													
												}catch(Exception e){
													e.printStackTrace();
												}
											%>
											<!--
											<option>Graphics</option>
											<option>UI Design</option>
											<option>Web Themes</option>
											<option>Fonts</option>
											<option>Add-Ons</option>
											-->


										</select>
									</div>
								</div>

								<div class="mb-3 pb-2">
									<label class="form-label" for="unp-product-name">Book
										name</label> <input class="form-control" type="text"
										id="unp-product-name" name="bname">
									<div class="form-text">Maximum 100 characters. No HTML or
										emoji allowed.</div>
								</div>
								<div class="file-drop-area mb-3">
									<div class="file-drop-icon ci-cloud-upload"></div>
									<span class="file-drop-message">Drag and drop here to
										upload book hardcover</span> <input class="file-drop-input"
										type="file" name="bimage">
									<button class="file-drop-btn btn btn-primary btn-sm mb-2"
										type="button">Or select file</button>
									<div class="form-text">1000 x 800px ideal size for hi-res
										displays</div>
								</div>
								<div class="mb-3 py-2">
									<label class="form-label" for="unp-product-description">Book
										description</label>
									<textarea class="form-control" rows="6"
										id="unp-product-description" name="bdesc"></textarea>
									<div class="bg-secondary p-3 fs-ms rounded-bottom">								
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label class="form-label" for="unp-standard-price">
											Book price</label>
										<div class="input-group">
											<span class="input-group-text"><i class="ci-rupee"></i></span>
											<input class="form-control" type="text"
												id="unp-standard-price" name="price">
										</div>
										<div class="form-text">Average marketplace price for
											this category is Rs.300 .</div>
									</div>

								</div>
								<div class="mb-3 py-2">
									<label class="form-label" for="unp-product-tags">Book
										tags</label>
									<textarea class="form-control" rows="4" id="unp-product-tags" name="tags"></textarea>
									<div class="form-text">Up to 10 keywords that describe
										your item. Tags should all be in lowercase and separated by
										commas.</div>
								</div>
								<div class="mb-3 pb-2">
									<label class="form-label" for="unp-product-files">Book
										files for sale</label> <input class="form-control" type="file"
										id="unp-product-files" name="bpdf">
									<div class="form-text">Maximum file size is 100 MB</div>
								</div>
								<button class="btn btn-primary d-block w-100" type="submit">
									<i class="ci-cloud-upload fs-lg me-2"></i>Upload Book
								</button>
							</form>
						</div>
					</section>
				</div>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@ include file="includes/footer.jsp"%>
	
	
	<!-- Back To Top Button-->
	<a class="btn-scroll-top" href="#top" data-scroll><span
		class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
		class="btn-scroll-top-icon ci-arrow-up"> </i></a>
	<!-- Vendor scrits: js libraries and plugins-->
	<%@ include file="includes/vendorScripts.jsp" %>
</body>

</html>