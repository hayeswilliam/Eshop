import eShop.database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;


@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
         ResultSet rs = null;
 
        String sql = "INSERT INTO users (name, email, password,role) VALUES (?, ?, ?,?)";

        try (Connection connection = database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, password);
            statement.setString(4, "user"); 
 
            int rowsInserted = statement.executeUpdate();
            rs = statement.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1); 
                HttpSession session = request.getSession();
                session.setAttribute("id", userId);
                session.setAttribute("user", email);  
 
                response.sendRedirect("index.jsp");
            } else { 
                response.sendRedirect("register.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection problem", e);
        }
    }
}
