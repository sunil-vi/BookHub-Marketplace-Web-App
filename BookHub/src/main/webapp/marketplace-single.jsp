<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.bookhub.util.*" %>
<%@ page import="com.bookhub.dao.*" %>
<%! int bid; %>
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

Book book = new Book();
BookDao bd = new BookDao(DBUtil.getConnection());
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

 bid = Integer.parseInt(request.getParameter("id"));
if(request.getParameter("id") !=null)
{
	book = bd.getSingleBook(bid);
}

%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title><%=book.getBname() %></title>
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
		<span class="fw-medium">Review </span>submitted.
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
                <li class="breadcrumb-item"><a class="text-nowrap" href="index.jsp"><i class="ci-home"></i>Home</a></li>
                <li class="breadcrumb-item text-nowrap"><a href="marketplace-category.jsp">Market</a>
                </li>
                <li class="breadcrumb-item text-nowrap active" aria-current="page">Single Item</li>
              </ol>
            </nav>
          </div>
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0"><%=book.getBname() %></h1>
          </div>
        </div>
      </div>
      <!-- Shadow box-->
      <section class="container mb-3 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
          <div class="row">
            <!-- Content-->
            <section class="col-lg-8 pt-2 pt-lg-4 pb-4 mb-lg-3">
              <div class="pt-3 px-5 pe-lg-7 ps-xl-5">
                <!-- Book gallery-->
							<div class="gallery">
								<a class="gallery-item rounded-3 mb-grid-gutter"
									href="assets/bimages/<%=book.getImage()%>"><img
									src="assets/bimages/<%=book.getImage()%>" alt="Gallery preview"><span
									class="gallery-item-caption"><%=book.getBname() %></span></a>
								
							</div>
			
              </div>
             </section>
            
            <!-- Sidebar-->
            <aside class="col-lg-4 ps-xl-5">
              <hr class="d-lg-none">
              <div class="bg-white h-100 p-4 ms-auto border-start">
                <div class="px-lg-2">
                  <div class="accordion accordion-flush" id="licenses">
                    <div class="accordion-item border-bottom">
                      <div class="accordion-header d-flex justify-content-between align-items-center py-3">
                        <div class="form-check" data-bs-toggle="collapse" data-bs-target="#standard-license">
                          <input class="form-check-input" type="radio" name="license" id="license-std" checked>
                          <label class="form-check-label fw-medium text-dark" for="license-std">Standard Price</label>
                        </div>
                        <h5 class="mb-0 text-accent fw-normal">&#8377 <%=book.getPrice() %>.<small>00</small></h5>
                      </div>
                      
                      <div class="accordion-collapse collapse show" id="standard-license" data-bs-parent="#licenses">
                        <div class="accordion-body py-0 pb-2">
                          <ul class="list-unstyled fs-sm">
                            <li class="d-flex align-items-center"><i class="ci-check-circle text-success me-1"></i><span class="fs-ms">Quality verified</span></li>
                            <li class="d-flex align-items-center"><i class="ci-check-circle text-success me-1"></i><span class="fs-ms">Use for a single project</span></li>
                            <li class="d-flex align-items-center"><i class="ci-check-circle text-success me-1"></i><span class="fs-ms">Non-paying users only</span></li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    
                    
                  </div>
                  <hr>
                  <a class="btn btn-primary btn-shadow d-block w-100 mt-4" href="CartServlet?id=<%=book.getId()%>"><i class="ci-cart fs-lg me-2" ></i>Add to Cart</a>
                  <div class="bg-secondary rounded p-3 mt-4 mb-2"><a class="d-flex align-items-center" href="#"><img class="rounded-circle" src="img/testimonials/01.jpg" width="50" alt="Sara Palson">
                      <div class="ps-2"><span class="fs-ms text-muted">Author</span>
                        <h6 class="fs-sm mb-0"><%=book.getAuthor() %></h6>
                      </div></a></div>
                  <div class="bg-secondary rounded p-3 mb-2"><i class="ci-download h5 text-muted align-middle mb-0 mt-n1 me-2"></i><span class="d-inline-block h6 mb-0 me-1"><%=book.getBsold() %></span><span class="fs-sm">Sales</span></div>
                  <div class="bg-secondary rounded p-3 mb-4">
                    <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star"></i>
                    </div><span class="fs-ms ms-2">4.1/5</span>
                    <div class="fs-ms text-muted">based on 74 reviews</div>
                  </div>
                  <ul class="list-unstyled fs-sm">
                    <li class="d-flex justify-content-between mb-3 pb-3 border-bottom"><span class="text-dark fw-medium">Last update</span><span class="text-muted">April 27, 2024</span></li>
                    <li class="d-flex justify-content-between mb-3 pb-3 border-bottom"><span class="text-dark fw-medium">Released</span><span class="text-muted">February 13, 2024</span></li>
                    <li class="d-flex justify-content-between mb-3 pb-3 border-bottom"><span class="text-dark fw-medium">Category</span><a class="product-meta" href="#"><%=book.getCat_name() %></a></li>
                    <li class="d-flex justify-content-between mb-3 pb-3 border-bottom"><span class="text-dark fw-medium">Supported On</span><span class="text-muted">Windows,Linux,Mac</span></li>
                    <li class="d-flex justify-content-between mb-3 pb-3 border-bottom"><span class="text-dark fw-medium">File type</span><span class="text-muted">Pdf</span></li>
                    
                  </ul>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </section>
      <!-- Book description + Reviews + Comments-->
      <section class="container mb-4 mb-lg-5">
      
        <!-- Nav tabs-->
        <ul class="nav nav-tabs" role="tablist">
          <li class="nav-item"><a class="nav-link p-4 active" href="#details" data-bs-toggle="tab" role="tab">Book details</a></li>
          <li class="nav-item"><a class="nav-link p-4" href="#reviews" data-bs-toggle="tab" role="tab">Reviews</a></li>
          
        </ul>
        <div class="tab-content pt-2">
        
          <!-- Book details tab-->
          <div class="tab-pane fade show active" id="details" role="tabpanel">
            <div class="row">
              <div class="col-lg-8">
                <p class="fs-md"><%=book.getBdesc() %>.</p>
                <h3 class="h5 pt-2">Main features</h3>
                <ul class="fs-md">
                  <li>Book is celebrated for their original storytelling, bringing fresh and unique narratives to the literary world.</li>
                  <li>This Book features dynamic characters each with their own compelling arcs that engage and resonate with readers.</li>
                  <li>Book is known for their meticulous research, ensuring authenticity and depth in every genre.</li>
                  <li>Authors craft immersive worlds, allowing readers to escape into diverse and richly described settings.</li>
                  <li>The writing style is often lyrical and evocative, making every sentence a pleasure to read.</li>
                  <li>Book reflects the author's distinct voice, offering new perspectives and insights that challenge and delight readers.</li>
                </ul>
              </div>
            </div>
          </div>
          
          <!-- Reviews tab-->
          <div class="tab-pane fade" id="reviews" role="tabpanel">
            <!-- Reviews-->
                            <% 
                String query = "SELECT COUNT(bid) FROM review WHERE bid = ? ";
                try {
					Connection conn = DBUtil.getConnection();
					PreparedStatement pt = conn.prepareStatement(query);
					pt.setInt(1,bid);
					ResultSet rs1 = pt.executeQuery();
					rs1.next();
		
				%>
				
            <div class="row pt-2 pb-3">
              <div class="col-lg-4 col-md-5">
                <h3 class="h4 mb-4"><%=rs1.getInt(1) %> Reviews</h3>
               
                <div class="star-rating me-2"><i class="ci-star-filled fs-sm text-accent me-1"></i><i class="ci-star-filled fs-sm text-accent me-1"></i><i class="ci-star-filled fs-sm text-accent me-1"></i><i class="ci-star-filled fs-sm text-accent me-1"></i><i class="ci-star fs-sm text-muted me-1"></i></div><span class="d-inline-block align-middle">4.1 Overall rating</span>
                <p class="pt-3 fs-sm text-muted"><%=rs1.getInt(1)-2 %> out of <%=rs1.getInt(1) %> <br>Readers recommended this book</p>
                 <%  
					
					} catch (Exception e) {
					e.printStackTrace();}
					 %>
              </div>
              
              <div class="col-lg-8 col-md-7">
                <% 
                String query1 = "SELECT rating,COUNT(rating) FROM review WHERE bid=? GROUP BY rating ORDER BY 1 DESC";
                try {
					Connection conn = DBUtil.getConnection();
					PreparedStatement pt = conn.prepareStatement(query1);
					pt.setInt(1,bid);
					ResultSet rs2 = pt.executeQuery();
		
				%>
                <div class="d-flex align-items-center mb-2">
                  <div class="text-nowrap me-3"><span class="d-inline-block align-middle text-muted">5</span><i class="ci-star-filled fs-xs ms-1"></i></div>
                  <div class="w-100">
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar bg-success" role="progressbar" style="width: 100%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  <%if(rs2.next()) %>
                  <span class="text-muted ms-3"><%=rs2.getInt(2) %></span>
                </div>
                
                <div class="d-flex align-items-center mb-2">
                  <div class="text-nowrap me-3"><span class="d-inline-block align-middle text-muted">4</span><i class="ci-star-filled fs-xs ms-1"></i></div>
                  <div class="w-100">
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 80%; background-color: #a7e453;" aria-valuenow="27" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  <%if(rs2.next()) %>
                  <span class="text-muted ms-3"><%=rs2.getInt(2) %></span>
                </div>
                
                <div class="d-flex align-items-center mb-2">
                  <div class="text-nowrap me-3"><span class="d-inline-block align-middle text-muted">3</span><i class="ci-star-filled fs-xs ms-1"></i></div>
                  <div class="w-100">
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 60%; background-color: #ffda75;" aria-valuenow="17" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  <%if(rs2.next()) %>
                  <span class="text-muted ms-3"><%=rs2.getInt(2) %></span>
                </div>
                
                <div class="d-flex align-items-center mb-2">
                  <div class="text-nowrap me-3"><span class="d-inline-block align-middle text-muted">2</span><i class="ci-star-filled fs-xs ms-1"></i></div>
                  <div class="w-100">
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar" role="progressbar" style="width: 40%; background-color: #fea569;" aria-valuenow="9" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                 <%if(rs2.next()) %>
                  <span class="text-muted ms-3"><%=rs2.getInt(2) %></span>
                </div>
                
                <div class="d-flex align-items-center">
                  <div class="text-nowrap me-3"><span class="d-inline-block align-middle text-muted">1</span><i class="ci-star-filled fs-xs ms-1"></i></div>
                  <div class="w-100">
                    <div class="progress" style="height: 4px;">
                      <div class="progress-bar bg-danger" role="progressbar" style="width: 10%;" aria-valuenow="4" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                  </div>
                  <%if(rs2.next()) %>
                  <span class="text-muted ms-3"><%=rs2.getInt(2) %></span>
                </div>
                <%  
					
					} catch (Exception e) {
					e.printStackTrace();}
					 %>
              </div>
            </div>
            <hr class="mt-4 mb-3">
            <div class="row py-4">
            
              <!-- Reviews list-->
              <div class="col-md-7">
                
                <% 
                String query3 = "SELECT * FROM review WHERE bid = ? LIMIT 0,5";
                try {
					Connection conn = DBUtil.getConnection();
					PreparedStatement pt = conn.prepareStatement(query3);
					pt.setInt(1,bid);
					ResultSet rs = pt.executeQuery();
		
					while (rs.next()) {
				%>
                <!-- Review-->
                <div class="product-review pb-4 mb-4 border-bottom">
                  <div class="d-flex mb-3">
                    <div class="d-flex align-items-center me-4 pe-2"><img class="rounded-circle" src="img/shop/reviews/01.jpg" width="50" alt="Rafael Marquez">
                      <div class="ps-3">
                        <h6 class="fs-sm mb-0"><%=rs.getString(2) %></h6><span class="fs-ms text-muted"><%=rs.getString(7) %></span>
                      </div>
                    </div>
                    
                  </div>
                  <p class="fs-md mb-2"><%=rs.getString(4) %></p>
                  
                  
                </div>
                <%  
					}
					} catch (Exception e) {
					e.printStackTrace();}
					 %>
                
               
              </div>
              
              <!-- Leave review form-->
              <div class="col-md-5 mt-2 pt-4 mt-md-0 pt-md-0">
                <div class="bg-secondary py-grid-gutter px-grid-gutter rounded-3">
                  <h3 class="h4 pb-2">Write a review</h3>
                  <form class="needs-validation" method="post" novalidate action="AddReviewServlet">
                    <div class="mb-3">
                      <label class="form-label" for="review-name">Your name<span class="text-danger">*</span></label>
                      <input class="form-control" type="text" required id="review-name" name="uname">
                      
                      <input class="form-control" type="hidden" required id="review-name" value="<%=bid%>" name="bid">
                      <input class="form-control" type="hidden" required id="review-name" value="<%=user.getId()%>" name="uid">
                      <div class="invalid-feedback">Please enter your name!</div><small class="form-text text-muted">Will be displayed on the comment.</small>
                    </div>
                    <div class="mb-3">
                      <label class="form-label" for="review-email">Your email<span class="text-danger">*</span></label>
                      <input class="form-control" type="email" required id="review-email" name="email">
                      <div class="invalid-feedback">Please provide valid email address!</div><small class="form-text text-muted">Authentication only - we won't spam you.</small>
                    </div>
                    <div class="mb-3">
                      <label class="form-label" for="review-rating">Rating<span class="text-danger">*</span></label>
                      <select class="form-select" required id="review-rating" name="rating"> 
                        <option value="">Choose rating</option>
                        <option value="5">5 stars</option>
                        <option value="4">4 stars</option>
                        <option value="3">3 stars</option>
                        <option value="2">2 stars</option>
                        <option value="1">1 star</option>
                      </select>
                      <div class="invalid-feedback">Please choose rating!</div>
                    </div>
                    <div class="mb-3">
                      <label class="form-label" for="review-text">Review<span class="text-danger">*</span></label>
                      <textarea class="form-control" rows="6" required id="review-text" name="review"></textarea>
                      <div class="invalid-feedback">Please write a review!</div><small class="form-text text-muted">Your review must be at least 50 characters.</small>
                    </div>
                   
                    
                    <button class="btn btn-primary btn-shadow d-block w-100" type="submit">Submit a Review</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
          
          
        </div>
      </section>
      
      <!-- Related Book carousel-->
      <section class="container mb-5 pb-lg-3">
        <div class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-4 mb-4">
          <h2 class="h3 mb-0 pt-2">Related Books</h2>
          <div class="pt-2"><a class="btn btn-outline-accent btn-sm" href="marketplace-category.jsp">More Books<i class="ci-arrow-end ms-1 me-n1"></i></a></div>
        </div>
        
        <!-- Carousel-->
        <div class="tns-carousel">
          <div class="tns-carousel-inner" data-carousel-options="{&quot;items&quot;: 2, &quot;gutter&quot;: 16, &quot;controls&quot;: false, &quot;nav&quot;: true, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2 },&quot;768&quot;:{&quot;items&quot;:3}, &quot;992&quot;:{&quot;items&quot;:4}}}">
            
            <%
							try {
								Connection conn = DBUtil.getConnection();
								Statement st = conn.createStatement();
								ResultSet rs1 = st.executeQuery("SELECT * FROM books ORDER BY 1 DESC LIMIT 0,4");
								while (rs1.next()) { 
									//for (Book b: books) {
							%>
            <!-- Book-->
            <div>
              <div class="card product-card-alt">
                <div class="product-thumb">
                 
                  <div class="product-card-actions"><a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="marketplace-single.jsp?id=<%=rs1.getInt("id")%>"><i class="ci-eye"></i></a>
                    <a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=book.getId()%>"><i class="ci-cart" ></i></a>
                  </div><a class="product-thumb-overlay" href="marketplace-single.jsp?id=<%=rs1.getInt("id")%>"></a><img src="assets/bimages/<%=rs1.getString("image")%>" alt="<%=rs1.getString("image")%>">
                </div>
                <div class="card-body">
                  <div class="d-flex flex-wrap justify-content-between align-items-start pb-2">
                    <div class="text-muted fs-xs me-1">by <a class="product-meta fw-medium" href="#"><%=rs1.getString("author")%>. </a>in <a class="product-meta fw-medium" href="#"><%=rs1.getString("cat_name")%></a></div>
                    <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i>
                    </div>
                  </div>
                  <h3 class="product-title fs-sm mb-2"><a href="#"><%=rs1.getString("bname")%></a></h3>
                  <div class="d-flex flex-wrap justify-content-between align-items-center">
                    <div class="fs-sm me-2"><i class="ci-download text-muted me-1"></i><%=rs1.getString("bsold")%><span class="fs-xs ms-1">Sales</span></div>
                    <div class="bg-faded-accent text-accent rounded-1 py-1 px-2">&#8377 <%=rs1.getString("price")%>.<small>00</small></div>
                  </div>
                </div>
              </div>
            </div>
            <%
								}
							} catch (Exception e) {
							e.printStackTrace();
							}
            %>
          </div>
        </div>
      </section>
    </main>
    
    <!-- Footer-->
    <%@ include file="includes/footer.jsp" %>
    
    <!-- Toolbar for handheld devices (Marketplace)-->
    <div class="handheld-toolbar">
      <div class="d-table table-layout-fixed w-100"><a class="d-table-cell handheld-toolbar-item" href="dashboard-favorites.jsp"><span class="handheld-toolbar-icon"><i class="ci-heart"></i></span><span class="handheld-toolbar-label">Favorites</span></a><a class="d-table-cell handheld-toolbar-item" href="javascript:void(0)" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" onclick="window.scrollTo(0, 0)"><span class="handheld-toolbar-icon"><i class="ci-menu"></i></span><span class="handheld-toolbar-label">Menu</span></a><a class="d-table-cell handheld-toolbar-item" href="marketplace-cart.jsp"><span class="handheld-toolbar-icon"><i class="ci-cart"></i><span class="badge bg-primary rounded-pill ms-1">3</span></span><span class="handheld-toolbar-label">$56.00</span></a></div>
    </div>
    
    <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>

</html>