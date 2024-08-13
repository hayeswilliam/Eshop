<%@ include file="header.jsp" %>

	

	<!--================Login Box Area =================-->
	<section class="login_box_area section_gap mt-5">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<img class="img-fluid" src="img/login.jpg" alt="">
						<div class="hover">
							<h4>Welcome to the Signup page</h4>
							
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner">
						<h3>Signup in to enter</h3>
						<form class="row login_form" action="register" method="post" id="contactForm" novalidate="novalidate">
                                                        <div class="col-md-12 form-group">
								<input type="text" class="form-control" id="name" name="name" placeholder="Name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Name'">
							</div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="name" name="email" placeholder="email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'">
							</div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="name" name="password" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
							</div>
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="primary-btn">Sign Up</button>
								
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
            <%@ include file="footer.jsp" %>
