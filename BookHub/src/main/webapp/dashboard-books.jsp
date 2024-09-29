<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*,java.text.DecimalFormat"%>
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

	BookDao bd = new BookDao(DBUtil.getConnection());
	List<Book> 	books = bd.getUserBooks(user.getFname()+" "+user.getLname());
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
%>

<!DOCTYPE html>
<html lang="en">
  
<head>
    <title>Books</title>
    <%@ include file="includes/head.jsp"%>
</head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
  <%
	String success = (String) request.getParameter("success");
	if (success != null && success.equals("1")) {
	%>

	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Book</span> Deleted .
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} 
	%>
    <main class="page-wrapper">
      <!-- Navbar Marketplace-->
      <%@ include file="includes/header.jsp" %>
      
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
                <!-- Title-->
                <div class="d-sm-flex flex-wrap justify-content-between align-items-center border-bottom">
                  <h2 class="h3 py-2 me-2 text-center text-sm-start">Your Books<span class="badge bg-faded-accent fs-sm text-body align-middle ms-2"><%=bookCnt %></span></h2>
                  <div class="py-2">
                    
                  </div>
                </div>
                
                <!-- Book-->
                <%
                	for(Book b: books){
     	
                %>
							<div
								class="d-block d-sm-flex align-items-center py-4 border-bottom">
								<a class="d-block mb-3 mb-sm-0 me-sm-4 ms-sm-0 mx-auto"
									href="marketplace-single.jsp" style="width: 12.5rem;"><img
									class="rounded-3" src="assets/bimages/<%=b.getImage()%>"
									alt="<%=b.getImage()%>"></a>
								<div class="text-center text-sm-start">
									<h3 class="h6 product-title mb-2">
										<a href="marketplace-single.jsp"><%=b.getBname()%></a>
									</h3>
									<div class="d-inline-block text-accent">
										&#8377
										<%=b.getPrice()%>.<small>00</small>
									</div>
									<div
										class="d-inline-block text-muted fs-ms border-start ms-2 ps-2">
										Sales: <span class="fw-medium"><%=b.getBsold()%></span>
									</div>
									<div
										class="d-inline-block text-muted fs-ms border-start ms-2 ps-2">
										Earnings: <span class="fw-medium"><%=b.getPrice() * b.getBsold()%>.<small>00</small></span>
									</div>
									<div
										class="d-flex justify-content-center justify-content-sm-start pt-3">
										<a class="btn bg-faded-accent btn-icon me-2"
											href="DownloadBookServlet?bid=<%=b.getId()%>"><i
											class="ci-download text-accent"></i></a>
										<!-- <button class="btn bg-faded-info btn-icon me-2" type="button" data-bs-toggle="tooltip" title="Edit"><i class="ci-edit text-info"></i></button> -->
										<a class="btn bg-faded-danger btn-icon"
											data-bs-toggle="tooltip" title="Delete"
											href="DeleteBookServlet?id=<%=b.getId()%>"><i
											class="ci-trash text-danger"></i></a>
									</div>
								</div>
							</div>
							<%} %>
              </div>
            </section>
          </div>
        </div>
      </div>
    </main>
    <!-- Footer-->
    <%@ include file="includes/footer.jsp" %>
    
    <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>


</html>