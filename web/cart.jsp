<%@page import="java.util.Map"%>
<%@page import="eShop.CartItem"%>
<%@page import="java.math.BigDecimal"%>
<%@ include file="header.jsp" %>

<%
    String Loggeduser=(String) session.getAttribute("user");
    if (session == null || Loggeduser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    BigDecimal subtotal = new BigDecimal(0);

    if (cart == null || cart.isEmpty()) {
%>
<section></section>
    <section class="cart_area section_gap mt-5">
        <div class="container">
            <div class="cart_inner">
                <div class="alert alert-warning" role="alert">
                    Your cart is empty. <a href="index.jsp" class="alert-link">Continue shopping</a>.
                </div>
            </div>
        </div>
    </section>
<%
    } else {
%>
<section></section>
<!--================Cart Area =================-->
<section class="cart_area section_gap mt-5">
    <div class="container">
        <div class="cart_inner">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Product</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (CartItem item : cart.values()) {
                                BigDecimal total = item.getProductPrice().multiply(new BigDecimal(item.getQuantity()));
                                subtotal = subtotal.add(total);
                        %>
                        <tr>
                            <td>
                                <div class="media">
                                    <div class="d-flex">
                                        <img src="" alt="<%= item.getProductName() %>">
                                    </div>
                                    <div class="media-body">
                                        <p><%= item.getProductName() %></p>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5>$<%= item.getProductPrice() %></h5>
                            </td>
                            <td>
                                <div class="product_count">
                                    <input type="text" name="qty" id="sst" maxlength="12" value="<%= item.getQuantity() %>" title="Quantity:"
                                        class="input-text qty">
                                </div>
                            </td>
                            <td>
                                <h5>$<%= total %></h5>
                            </td>
                        </tr>
                        <%
                            } 
                        %>
                        <tr class="bottom_button">
                            <td>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>
                                <h5>Subtotal</h5>
                            </td>
                            <td>
                                <h5>$<%= subtotal %></h5>
                            </td>
                        </tr>
                        <tr class="out_button_area">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <div class="checkout_btn_inner d-flex align-items-center">
                                    <a class="gray_btn" href="index.jsp">Shopping</a>
                                    <form action="<%= request.getContextPath() %>/OrderServlet" method="post">
                                        <button type="submit" class="primary-btn">Proceed to checkout</button>
                                    </form>

                                </div>
                                
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<!--================End Cart Area =================-->

<%
    } 
%>

<%@ include file="footer.jsp" %>
