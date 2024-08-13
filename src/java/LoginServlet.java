import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import eShop.database;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
                       

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = database.getConnection();

            String query = "SELECT id, name, role FROM users WHERE email=? AND password=? AND status=?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, "ACTIVE");
            rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String name = rs.getString("name");
                String role = rs.getString("role");
                

                HttpSession session = request.getSession();
                session.setAttribute("user", email);
                session.setAttribute("id", userId);
                session.setAttribute("name", name);
                session.setAttribute("role", role);

                if ("admin".equals(role)) {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("index.jsp"); // Redirect to customer home or default page
                }
            } else {
                // Handle invalid login
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
