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
    <title>Checkout</title>
<%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
  <%
	String error = (String) request.getParameter("error");
	if (error != null && error.equals("1")) {
	%>

	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Payment</span> failed.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} 
	%>
  
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
                <li class="breadcrumb-item text-nowrap active" aria-current="page">Checkout</li>
              </ol>
            </nav>
          </div>
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">Checkout</h1>
          </div>
        </div>
      </div>
      <div class="container mb-5 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
          
          <div class="row">
            <!-- Content-->
            <section class="col-lg-8 pt-2 pt-lg-4 pb-4 mb-3">
              <div class="pt-2 px-4 pe-lg-0 ps-xl-5">
                <!-- Title-->
                <h2 class="h6 border-bottom pb-3 mb-3">Billing details</h2>
                <!-- Billing detail-->
                <div class="row pb-4 gx-4 gy-3">
                  <div class="col-sm-6">
                    <label class="form-label" for="mc-fn">First Name<span class='text-danger'>*</span></label>
                    <input class="form-control" type="text" value="<%=user.getFname() %>" id="mc-fn">
                  </div>
                  <div class="col-sm-6">
                    <label class="form-label" for="mc-ln">Last Name<span class='text-danger'>*</span></label>
                    <input class="form-control" type="text" value="<%=user.getLname() %>" id="mc-ln">
                  </div>
                  <div class="col-12">
                    <label class="form-label" for="mc-email">Email<span class='text-danger'>*</span></label>
                    <input class="form-control" type="email" value="<%=user.getEmail() %>" id="mc-email">
                  </div>
                  <div class="col-sm-6">
                    <label class="form-label" for="mc-company">Company</label>
                    <input class="form-control" type="text" value="BookHub" id="mc-company">
                  </div>
                  <!-- <div class="col-sm-6">
                    <label class="form-label" for="mc-country">Country <span class='text-danger'>*</span></label>
                    <select class="form-select" id="mc-country">
                      <option value>Select country</option>
                      <option value="India">India</option>
                      <option value="Belgium">Belgium</option>
                      <option value="France">France</option>
                      <option value="Germany">Germany</option>
                      <option value="Madagascar" selected>Madagascar</option>
                      <option value="Spain">Spain</option>
                      <option value="UK">United Kingdom</option>
                      <option value="USA">USA</option>
                    </select>
                  </div> -->
                </div>
                <!-- Order preview on mobile (screens small than 991px)-->
                <div class="widget mb-3 d-lg-none">
                  <h2 class="widget-title">Order summary</h2>
                  
                  <% if(cart_list !=null ){
                		  
                  	for(Cart c:cart_list){
                  %>
                  <div class="d-flex align-items-center pb-2 border-bottom"><a class="d-block flex-shrink-0 me-2" href="marketplace-single.jsp?id=<%=c.getId() %>"><img class="rounded-1" src="assets/bimages/<%=c.getImage() %>" width="64" alt="Book"></a>
                    <div class="ps-1">
                      <h6 class="widget-product-title"><a href="marketplace-single.jsp?id=<%=c.getId() %>"><%=c.getBname() %></a></h6>
                      <div class="widget-product-meta"><span class="text-accent border-end pe-2 me-2">&#8377 <%=c.getPrice() %>.<small>00</small></span></div>
                    </div>
                  </div>
                 <% }} %>
                  <ul class="list-unstyled fs-sm py-3">
                  
                    <li class="d-flex justify-content-between align-items-center fs-base"><span class="me-2">Total:</span><span class="text-end">&#8377 ${(total>0)?dcf.format(total):0}.<small>00</small></span></li>
                  </ul>
                </div>
                
                <!-- Payment methods accordion-->
                <div class="accordion mb-2" id="payment-method" role="tablist">
                  <div class="accordion-item">
                    <h3 class="accordion-header"><a class="accordion-button" href="#card" data-bs-toggle="collapse"><i class="ci-card fs-lg me-2 mt-n1 align-middle"></i>Pay with Credit Card</a></h3>
                    <div class="accordion-collapse collapse show" id="card" data-bs-parent="#payment-method" role="tabpanel">
                      <div class="accordion-body">
                        <p class="fs-sm">We accept following credit cards:&nbsp;&nbsp;<img class="d-inline-block align-middle" src="img/cards.png" style="width: 187px;" alt="Cerdit Cards"></p>
                        <div class="credit-card-wrapper"></div>
                        <form class="credit-card-form row g-3">
                          <div class="col-sm-6">
                            <input class="form-control" type="text" name="number" placeholder="Card Number" required>
                          </div>
                          <div class="col-sm-6">
                            <input class="form-control" type="text" name="name" placeholder="Full Name" required>
                          </div>
                          <div class="col-sm-3">
                            <input class="form-control" type="text" name="expiry" placeholder="MM/YY" required>
                          </div>
                          <div class="col-sm-3">
                            <input class="form-control" type="text" name="cvc" placeholder="CVC" required>
                          </div>
                          <div class="col-sm-6">
                            <a class="btn btn-primary d-block w-100"  href="CheckOutServlet">Place order</a>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  <div class="accordion-item">
                    <h3 class="accordion-header"><a class="accordion-button collapsed" href="#paypal" data-bs-toggle="collapse"><i class="ci-paypal me-2 align-middle"></i>Pay with PayPal</a></h3>
                    <div class="accordion-collapse collapse" id="paypal" data-bs-parent="#payment-method" role="tabpanel">
                      <div class="accordion-body fs-sm">
                        <p><span class='fw-medium'>PayPal</span> - the safer, easier way to pay</p>
                        <a class="btn btn-primary"  href="CheckOutServlet">Checkout with PayPal</a>
                      </div>
                    </div>
                  </div>
                  
                </div>
              </div>
            </section>
            
            <!-- Sidebar-->
            <!-- Order preview on desktop (screens larger than 991px)-->
            <aside class="col-lg-4 d-none d-lg-block ps-xl-5">
              <hr class="d-lg-none">
              <div class="p-4 h-100 ms-auto border-start">
                <div class="widget px-lg-2 py-2 mb-3">
                  <h2 class="widget-title text-center">Order summary</h2>
                  
                  <% if(cart_list !=null ){
                		  
                  	for(Cart c:cartBook){
                  %>
								<div class="d-flex align-items-center pb-2 border-bottom">
									<a class="d-block flex-shrink-0 me-2"
										href="marketplace-single.html"><img class="rounded-1"
										src="assets/bimages/<%=c.getImage() %>" width="64"
										alt="<%=c.getImage() %>"></a>
									<div class="ps-1">
										<h6 class="widget-product-title">
											<a href="marketplace-single.html"><%=c.getBname()%></a>
										</h6>
										<div class="widget-product-meta">
											<span class="text-accent border-end pe-2 me-2">&#8377 <%=c.getPrice() %>.<small>00</small>
											</span><span class="fs-xs text-muted"><%=c.getCat_name() %></span>
										</div>
									</div>
								</div>
								<% }} %>
                   <!-- <ul class="list-unstyled fs-sm pt-3 pb-2 border-bottom">
                    <li class="d-flex justify-content-between align-items-center"><span class="me-2">Subtotal:</span><span class="text-end">&#8377 32432.<small>00</small></span></li>
                    <li class="d-flex justify-content-between align-items-center"><span class="me-2">Taxes:</span><span class="text-end">&#8377 9.<small>30</small></span></li>
                  </ul> --> 
                  
                  <h3 class="fw-normal text-center my-4">&#8377 ${(total>0)?dcf.format(total):0}.<small>00</small></h3>
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