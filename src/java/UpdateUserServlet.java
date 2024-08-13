
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import eShop.database;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect("manageUsers.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = database.getConnection();
 
            String sql = "UPDATE users SET name = ?, email = ?, role = ?, status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, role);
            pstmt.setString(4, status);
            pstmt.setString(5, userId);
 
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) { 
                response.sendRedirect("manageUsers.jsp");
            } else { 
                response.sendRedirect("manageUsers.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace(); 
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
        } finally { 
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
