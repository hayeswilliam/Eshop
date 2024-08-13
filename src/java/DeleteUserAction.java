
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


@WebServlet("/DeleteUserAction")
public class DeleteUserAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");

        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect("manageUsers.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = database.getConnection();

            String sql = "DELETE FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                request.setAttribute("message", "User deleted successfully.");
            } else {
                request.setAttribute("message", "User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the user.");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        response.sendRedirect("manageUsers.jsp");
    }
}
