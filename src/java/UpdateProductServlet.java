
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import eShop.database;

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            String productIdStr = request.getParameter("productId");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String stockQuantityStr = request.getParameter("stockQuantity");
            String categoryIdStr = request.getParameter("categoryId");

            if (productIdStr != null && !productIdStr.trim().isEmpty() &&
                name != null && !name.trim().isEmpty() &&
                description != null && !description.trim().isEmpty() &&
                priceStr != null && !priceStr.trim().isEmpty() &&
                stockQuantityStr != null && !stockQuantityStr.trim().isEmpty() &&
                categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    conn = database.getConnection();
                    String sql = "UPDATE product SET name = ?, description = ?, price = ?, stock_quantity = ?, category_id = ? WHERE product_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, description);
                    pstmt.setBigDecimal(3, new BigDecimal(priceStr));
                    pstmt.setInt(4, Integer.parseInt(stockQuantityStr));
                    pstmt.setInt(5, Integer.parseInt(categoryIdStr));
                    pstmt.setInt(6, Integer.parseInt(productIdStr));
                    pstmt.executeUpdate();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
            response.sendRedirect("manageProduct.jsp");
        } else {
            response.sendRedirect("manageProduct.jsp");
        }
    }
}
