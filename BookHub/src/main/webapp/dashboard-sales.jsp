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
    <title>Sales</title>
    <%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
    
    <main class="page-wrapper">
      <!-- Navbar Marketplace-->
      <!-- Remove "navbar-sticky" class to make navigation bar scrollable with the page.-->
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
                <h2 class="h3 py-2 text-center text-sm-start">Your sales / earnings</h2>
                <div class="row mx-n2 pt-2">
               <%int total=0,bcnt=0; %>
<%
								try {
									//String query = "SELECT * FROM books WHERE author ";
									String query = "SELECT * FROM books WHERE author ='"+user.getFname()+" "+user.getLname()+"'";
									Connection conn = DBUtil.getConnection();
									PreparedStatement pt = conn.prepareStatement(query);

									//pt.setString(1,author);

									ResultSet rs4 = pt.executeQuery(query);
									while (rs4.next()) {
										total = total + rs4.getInt("price")*rs4.getInt("bsold");
										bcnt = bcnt + rs4.getInt("bsold");
									}
								}catch(Exception e)
{
									e.printStackTrace();
}
								%>
							
                  <div class="col-md-4 col-sm-6 px-2 mb-4">
                    <div class="bg-secondary h-100 rounded-3 p-4 text-center">
                      <h3 class="fs-sm text-muted">Earnings (Before taxes)</h3>
                      <p class="h2 mb-2">&#8377 <%=total %>.<small>00</small></p>
                      <p class="fs-ms text-muted mb-0"><%=bcnt%> Sales</p>
                    </div>
                  </div>
                  <div class="col-md-4 col-sm-6 px-2 mb-4">
                    <div class="bg-secondary h-100 rounded-3 p-4 text-center">
                      <h3 class="fs-sm text-muted">Your Amount</h3>
                      <p class="h2 mb-2">&#8377 <%=total-(total * 2/100)%>.<small>00</small></p>
                      <p class="fs-ms text-muted mb-0">To be paid </p>
                    </div>
                  </div>
                  <div class="col-md-4 col-sm-12 px-2 mb-4">
                    <div class="bg-secondary h-100 rounded-3 p-4 text-center">
                      <h3 class="fs-sm text-muted">Lifetime earnings</h3>
                      <p class="h2 mb-2">&#8377 0.<small>00</small></p>
                      <p class="fs-ms text-muted mb-0">Based on recent data</p>
                    </div>
                  </div>
                </div>
                <h3 class="h5 pb-2">Book Upload History</h3>
                <div class="table-responsive">
                  <table class="table table-layout-fixed fs-sm mb-0">
                    <thead>
                      <tr>
                        <th>Book Name</th>
                        <th>Book Price</th>
                        <th>Date </th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    <%
								try {
									//String query = "SELECT * FROM books WHERE author ";
									String query = "SELECT * FROM books WHERE author ='"+user.getFname()+" "+user.getLname()+"'";
									Connection conn = DBUtil.getConnection();
									PreparedStatement pt = conn.prepareStatement(query);

									//pt.setString(1,author);

									ResultSet rs5 = pt.executeQuery(query);
									while (rs5.next()) {
										
									%>
                      <tr>
                        <td><%=rs5.getString("bname") %></td>
                        <td><%=rs5.getString("price") %></td>
                        <td><%=rs5.getString("udate") %></td>
                      </tr>
                      
                      
                      <% }
								}catch(Exception e)
{
									e.printStackTrace();
}
								%>
                    </tbody>
                  </table>
                </div>
                <hr class="mb-grid-gutter">
                <!-- Pagination-->
                <nav class="d-md-flex justify-content-between align-items-center text-center text-md-start" aria-label="Page navigation">
                  <div class="d-md-flex align-items-center w-100"><span class="fs-sm text-muted me-md-3">Showing records</span>
                    <div class="progress w-100 my-3 mx-auto mx-md-0" style="max-width: 10rem; height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                
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
      <div class="d-table table-layout-fixed w-100"><a class="d-table-cell handheld-toolbar-item" href="dashboard-favorites.html"><span class="handheld-toolbar-icon"><i class="ci-heart"></i></span><span class="handheld-toolbar-label">Favorites</span></a><a class="d-table-cell handheld-toolbar-item" href="javascript:void(0)" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" onclick="window.scrollTo(0, 0)"><span class="handheld-toolbar-icon"><i class="ci-menu"></i></span><span class="handheld-toolbar-label">Menu</span></a><a class="d-table-cell handheld-toolbar-item" href="marketplace-cart.html"><span class="handheld-toolbar-icon"><i class="ci-cart"></i><span class="badge bg-primary rounded-pill ms-1">3</span></span><span class="handheld-toolbar-label">$56.00</span></a></div>
    </div>
    <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>


</html>