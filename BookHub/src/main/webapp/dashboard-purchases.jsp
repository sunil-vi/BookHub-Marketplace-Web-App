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

DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

List<Order> orders = null;

if (user != null) {
    OrderDao orderDao  = new OrderDao(DBUtil.getConnection());
	orders = orderDao.userOrders(user.getId());
	
}else{
	response.sendRedirect("account-signin.jsp");
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

%>
<!DOCTYPE html>
<html lang="en">
  
<head>
    <title>Purchases</title>
    <%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
    
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
                  <h2 class="h3 py-2 me-2 text-center text-sm-start">Your purchases</h2>
                  <div class="py-2">
                    
                  </div>
                </div>
                
                <!-- Book list-->
                <!-- Book-->
                <%
			if(orders != null){
				for(Order o:orders){
	
			%>
                <div class="d-block d-sm-flex align-items-center py-4 border-bottom"><a class="d-block mb-3 mb-sm-0 me-sm-4 ms-sm-0 mx-auto" href="marketplace-single.html" style="width: 12.5rem;"><img class="rounded-3" src="assets/bimages/<%=o.getImage() %>" alt="<%=o.getImage() %>"></a>
                  <div class="text-center text-sm-start">
                    <h3 class="h6 product-title mb-2"><a href="marketplace-single.html"><%=o.getBname()%></a></h3>
                    <div class="text-accent fs-sm mb-1"><%=o.getCat_name()%></div>
                    <div class="form-check d-table text-start mx-auto mx-sm-0">
<!--                       <input class="form-check-input" type="checkbox" id="update-info-1" checked> -->
                      <label class="form-check-label fs-ms" for="update-info-1">&#8377 <%=o.getPrice()%></label>
                    </div>
                    <div class="d-flex align-items-center justify-content-center justify-content-sm-start pt-2">
                      <div class="my-2">
                        <a class="btn btn-primary btn-sm me-3" href="DownloadBookServlet?bid=<%=o.getId()%>"><i class="ci-download me-1"></i>Download</a>
                      </div>
<!--                       <a class="d-block text-muted text-center my-2" href="#"> -->
<!--                         <div class="star-rating"><i class="star-rating-icon ci-star"></i><i class="star-rating-icon ci-star"></i><i class="star-rating-icon ci-star"></i><i class="star-rating-icon ci-star"></i><i class="star-rating-icon ci-star"></i> -->
<!--                         </div> -->
<!--                         <div class="fs-xs">Reate this Book</div></a> -->
                    </div>
                  </div>
                </div>
               
                <%
				
					}
			}
			%>
			
			
			
                <!-- Pagination-->
               <nav class="d-md-flex justify-content-between align-items-center text-center text-md-start mt-4" aria-label="Page navigation">
                  <div class="d-md-flex align-items-center w-100"><span class="fs-sm text-muted me-md-3">Showing <%=orders.size()%> books</span>
                    <div class="progress w-100 my-3 mx-auto mx-md-0" style="max-width: 10rem; height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="56" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  <!-- <button class="btn btn-outline-primary btn-sm" type="button">More Books</button> -->
                </nav> 
              </div>
            </section>
          </div>
        </div>
      </div>
    </main>
    <!-- Footer-->
    <%@ include file="includes/footer.jsp" %>
    
    <!-- Toolbar for handheld devices (Marketplace)-->
    <div class="handheld-toolbar">
		<div class="d-table table-layout-fixed w-100">
			<a
				class="d-table-cell handheld-toolbar-item" href="javascript:void(0)"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
				onclick="window.scrollTo(0, 0)"><span
				class="handheld-toolbar-icon"><i class="ci-menu"></i></span><span
				class="handheld-toolbar-label">Menu</span></a><a
				class="d-table-cell handheld-toolbar-item"
				href="marketplace-cart.html"><span class="handheld-toolbar-icon"><i
					class="ci-cart"></i><span
					class="badge bg-primary rounded-pill ms-1">3</span></span><span
				class="handheld-toolbar-label">$56.00</span></a>
		</div>
	</div>
    <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>


</html>