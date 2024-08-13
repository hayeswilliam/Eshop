import eShop.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Map;
import eShop.database;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");
        int id = (int) session.getAttribute("id");
        if (user == null) {
            response.sendRedirect("login.jsp"); 
            return;
        }

        
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp"); 
            return;
        }

        try (Connection conn = database.getConnection()) {
            conn.setAutoCommit(false); 

            try {
                String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, order_date) VALUES (?, ?, ?)";
                PreparedStatement orderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
                orderStmt.setInt(1, id);
                orderStmt.setBigDecimal(2, calculateTotalAmount(cart));
                orderStmt.setDate(3, new java.sql.Date(new Date().getTime())); 
                orderStmt.executeUpdate();

                int orderId = -1;
                try (var rs = orderStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }

                String insertOrderedProductsSQL = "INSERT INTO ordered_products (order_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement orderedProductsStmt = conn.prepareStatement(insertOrderedProductsSQL);
                String updateStockSQL = "UPDATE product SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
                PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL);

                for (CartItem item : cart.values()) {
                    orderedProductsStmt.setInt(1, orderId);
                    orderedProductsStmt.setInt(2, item.getProductId());
                    orderedProductsStmt.setInt(3, item.getQuantity());
                    orderedProductsStmt.executeUpdate();

                    updateStockStmt.setInt(1, item.getQuantity());
                    updateStockStmt.setInt(2, item.getProductId());
                    updateStockStmt.executeUpdate();
                }

                conn.commit();

                request.setAttribute("orderNumber", orderId);
                request.setAttribute("orderDate", new Date());
                request.setAttribute("totalAmount", calculateTotalAmount(cart));
                request.setAttribute("paymentMethod", "Check payments"); 

                request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);

            } catch (SQLException e) {
                conn.rollback(); 
                throw new ServletException("Error processing order", e);
            }
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    private BigDecimal calculateTotalAmount(Map<Integer, CartItem> cart) {
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            totalAmount = totalAmount.add(item.getProductPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        return totalAmount;
    }
}
