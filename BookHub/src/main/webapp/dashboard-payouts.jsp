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
    <title>Payouts</title>
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
            <!--Sidebar-->
            <%@ include file="includes/sidebar.jsp" %> 
            
            <!-- Content-->
            <section class="col-lg-8 pt-lg-4 pb-4 mb-3">
              <div class="pt-2 px-4 ps-lg-0 pe-xl-5">
                <h2 class="h3 py-2 text-center text-sm-start">Payouts</h2>
                <div class="row mx-n2 py-2">
                  <div class="col-sm-6 px-2 mb-4">
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
                  
                    <div class="bg-secondary h-100 rounded-3 p-4">
                      <h3 class="h5">Next payout</h3>
                      <p class="fs-sm">Your current earnings of <span class='fw-medium'>&#8377 <%=total %></span> will be sent to you 8/15/2025</p>
                    </div>
                  </div>
                  <div class="col-sm-6 px-2 mb-4">
                    <div class="bg-secondary h-100 rounded-3 p-4">
                      <h3 class="h5">Payout method</h3>
                      <div class="d-flex flex-wrap align-items-center py-1 mb-2"><img class="d-block mb-2 me-2" src="img/marketplace/account/paypal-logo.png" width="100" alt="PayPal"><span class="fs-xs mb-2"><%=user.getEmail() %></span></div><a class="btn btn-primary btn-sm" href="#">Change payout method</a>
                    </div>
                  </div>
                </div>
                <h3 class="h5 pb-2">Payout history</h3>
                <div class="table-responsive">
                  <table class="table table-layout-fixed fs-sm mb-0">
                    <thead>
                      <tr>
                        <th>Amount</th>
                        <th>Payout method</th>
                        <th>Date processed</th>
                      </tr>
                    </thead>
                    
                  </table>
                </div>
                <hr class="mb-grid-gutter">
                <!-- Pagination-->
                <nav class="d-md-flex justify-content-between align-items-center text-center text-md-start" aria-label="Page navigation">
                  <div class="d-md-flex align-items-center w-100"><span class="fs-sm text-muted me-md-3">Showing records</span>
                    <div class="progress w-100 my-3 mx-auto mx-md-0" style="max-width: 10rem; height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  
                </nav>
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