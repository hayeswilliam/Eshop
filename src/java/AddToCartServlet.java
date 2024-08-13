
import eShop.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;



@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp"); 
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        BigDecimal productPrice = new BigDecimal(request.getParameter("productPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        if (cart.containsKey(productId)) {
            CartItem item = cart.get(productId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            cart.put(productId, new CartItem(productId, productName, productPrice, quantity));
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("cart.jsp");
    }
}
