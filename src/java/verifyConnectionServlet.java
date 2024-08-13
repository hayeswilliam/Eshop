import eShop.database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/verifyConnectionServlet")
public class verifyConnectionServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try { 
            conn = database.getConnection();
            if (conn != null) {
                out.println("<h2>Connected to the database successfully!</h2>");
                 
                String sql = "SELECT id, email, role FROM users";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                 
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>Email</th><th>Role</th></tr>");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String role = rs.getString("role");
                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + role + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<h2>Failed to connect to the database.</h2>");
            }
        } catch (SQLException e) {
            e.printStackTrace(out);
            out.println("SQL Exception: " + e.getMessage());
        } finally { 
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(out);
            }
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
