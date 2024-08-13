<%@include file="header.jsp" %>

<section></section>
<!--================Order Details Area =================-->
<section class="order_details section_gap mt-5">
    <div class="container">
        <h3 class="title_confirmation">Thank you. Your order has been received.</h3>
        <div class="row order_d_inner">
            <div class="col-lg-4"></div>
            <div class="col-lg-4">
                <div class="details_item">
                    <h4>Order Info</h4>
                    <ul class="list">
                        <li><a href="#"><span>Order number</span> : <%= request.getAttribute("orderNumber") %></a></li>
                        <li><a href="#"><span>Date</span> : <%= request.getAttribute("orderDate") %></a></li>
                        <li><a href="#"><span>Total</span> : USD <%= request.getAttribute("totalAmount") %></a></li>
                        <li><a href="#"><span>Payment method</span> : <%= request.getAttribute("paymentMethod") %></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4"></div>
        </div>
    </div>
</section>
<!--================End Order Details Area =================-->

<%@include file="footer.jsp" %>
