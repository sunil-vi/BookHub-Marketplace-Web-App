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

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartBook = null;

if (cart_list != null) {
	
	BookDao bDao = new BookDao(DBUtil.getConnection());
	cartBook = bDao.getCartBooks(cart_list);
	int total = bDao.getTotalCartPrice(cart_list);
	
	request.setAttribute("total", total);

}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Your cart</title>
<%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
    
    <main class="page-wrapper">
      <!-- Navbar Marketplace-->
      <%@ include file="includes/header.jsp" %>
		
      <!-- Page Title-->
      <div class="page-title-overlap bg-accent pt-4">
        <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
          <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                <li class="breadcrumb-item"><a class="text-nowrap" href="index.html"><i class="ci-home"></i>Home</a></li>
                <li class="breadcrumb-item text-nowrap"><a href="marketplace-category.html">Market</a>
                </li>
                <li class="breadcrumb-item text-nowrap active" aria-current="page">Cart</li>
              </ol>
            </nav>
          </div>
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">Your cart</h1>
          </div>
        </div>
      </div>
      
      <div class="container mb-5 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
          <div class="row">
            <!-- Content-->
            <section class="col-lg-8 pt-2 pt-lg-4 pb-4 mb-3">
              <div class="pt-2 px-4 pe-lg-0 ps-xl-5">
                <!-- Header-->
                
                <%
				 if (cart_list != null) {%>
					 <div class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-3">
	                  <div class="py-1"><a class="btn btn-outline-accent btn-sm" href="marketplace-category.jsp"><i class="ci-arrow-left me-1 ms-n1"></i>Back to shopping</a></div>
	                  <div class="d-none d-sm-block py-1 fs-sm">You have <%=cart_list.size() %> books in your cart</div>
	                  <div class="py-1"><a class="btn btn-outline-danger btn-sm" href="ClearCartServlet"><i class="ci-close fs-xs me-1 ms-n1"></i>Clear cart</a></div>
	                </div>
	            <%
					for (Cart c : cartBook) {
				%>
                <!-- Book-->
							<div
								class="d-block d-sm-flex align-items-center py-4 border-bottom">
								<a class="d-block position-relative mb-3 mb-sm-0 me-sm-4 ms-sm-0 mx-auto"
									href="RemoveBookServlet?id=<%=c.getId() %>" style="width: 12.5rem;"><img
									class="rounded-3" src="assets/bimages/<%=c.getImage() %>"
									alt="Book"><span
									class="btn btn-icon btn-danger position-absolute top-0 end-0 py-0 px-1 m-2"
									data-bs-toggle="tooltip" title="Remove from Cart">
									<i class="ci-trash"></i>
								</span></a>
								<div class="text-center text-sm-start">
									<h3 class="h6 product-title mb-2">
										<a href="marketplace-single.jsp?id=<%=c.getId()%>"><%=c.getBname() %></a>
									</h3>
									<div class="d-inline-block text-accent">
										&#8377 <%=c.getPrice() %>.<small>00</small>
									</div>
									<%-- <a
										class="d-inline-block text-accent fs-ms border-start ms-2 ps-2"
										href="#">by <%=c.getAuthor()%></a> --%>

									<div class="form-inline pt-2">
										Category:<Text><%=c.getCat_name() %></Text>
									</div>

								</div>
							</div>
							<%
								}
							} else {
							%>
							<div
								class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-3">
								<div class="py-1">
									<a class="btn btn-outline-accent btn-sm"
										href="marketplace-category.jsp"><i
										class="ci-arrow-left me-1 ms-n1"></i>Back to shopping</a>
								</div>
								<div class="d-none d-sm-block py-1 fs-sm">
									<h4>Cart is Empty</h4>
								</div>
								<div class="py-1">
									<a class="btn btn-outline-danger btn-sm"
										href="#"><i
										class="ci-close fs-xs me-1 ms-n1"></i>Clear cart</a>
								</div>
							</div>
							<%} %>
							<!--Book End-->
              </div>
            </section>
            
            <!-- Sidebar-->
            <aside class="col-lg-4 ps-xl-5">
              <hr class="d-lg-none">
              <div class="p-4 h-100 ms-auto border-start">
                <div class="px-lg-2">
                  <div class="text-center mb-4 py-3 border-bottom">
                    <h2 class="h6 mb-3 pb-1">Cart total</h2>
                    <h3 class="fw-normal">&#8377 ${(total>0)?dcf.format(total):0}.<small>00</small></h3>
                  </div>
 				<!-- <div class="text-center mb-4 pb-3 border-bottom"> 
                    <h2 class="h6 mb-3 pb-1">Promo code</h2>
                    <form class="needs-validation pb-2" method="post" novalidate>
                      <div class="mb-3">
                        <input class="form-control" type="text" placeholder="Promo code" required>
                        <div class="invalid-feedback">Please provide promo code.</div>
                      </div>
                      <button class="btn btn-secondary d-block w-100" type="submit">Apply promo code</button>
                    </form>
                  </div> -->
								<a class="btn btn-primary btn-shadow d-block w-100 mt-4"
									href=<%out.println((user!=null) ? "marketplace-checkout.jsp" : "account-signin.jsp"); %>><i
									class="ci-locked fs-lg me-2"></i>Secure Checkout</a>
								<!--  <div class="text-center pt-2 pb-3"><small class="text-form text-muted">100% money back guarantee</small></div> -->
                </div>
              </div>
            </aside>
            
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