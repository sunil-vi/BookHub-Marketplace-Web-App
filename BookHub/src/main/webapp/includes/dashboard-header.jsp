<div class="page-title-overlap bg-accent pt-4">
        <div class="container d-flex flex-wrap flex-sm-nowrap justify-content-center justify-content-sm-between align-items-center pt-2">
          <div class="d-flex align-items-center pb-3">
            <div class="img-thumbnail rounded-circle position-relative flex-shrink-0" style="width: 6.375rem;"><img class="rounded-circle" src="assets/uimages/<%=user.getImage() %>" alt="BookHub"></div>
            <div class="ps-3">
              <h3 class="text-light fs-lg mb-0"><%=user.getFname()+" "+user.getLname() %></h3><span class="d-block text-light fs-ms opacity-60 py-1">Member since  <%=user.getJoin_date() %></span>
            </div>
          </div>
          <div class="d-flex">
            <div class="text-sm-end me-5">
              <div class="text-light fs-base">Total sales</div>
          
            	  <%!int sales;%>
            	  <%
					try {
						String query = "SELECT SUM(bsold) FROM books WHERE author ='"+user.getFname()+" "+user.getLname()+"'";
					
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement();
						
						ResultSet rs1 = st.executeQuery(query);
						if(rs1.next())
						{
							sales = rs1.getInt(1);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
						
					%>
            	
              <h3 class="text-light"><%=sales %></h3>
            </div>
            <div class="text-sm-end">
              <div class="text-light fs-base">Seller rating</div>
              <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star"></i>
              </div>
              <div class="text-light opacity-60 fs-xs">Based on <%=new Random().nextInt(100) %> reviews</div>
            </div>
          </div>
        </div>
      </div>