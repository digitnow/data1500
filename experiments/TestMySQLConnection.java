import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestMySQLConnection {
    public static void main(String[] args) {
        // JDBC-tilkoblingsinformasjon
        String jdbcUrl = "jdbc:mysql://localhost:3306/testdb?useSSL=false&serverTimezone=UTC";
        String username = "testuser";
        String password = "testpassword";

        // Prøv å opprette en tilkobling
        try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
            System.out.println("Tilkoblingen til MySQL-databasen var vellykket!");
        } catch (SQLException e) {
            System.err.println("Feil under tilkobling til MySQL-databasen:");
            e.printStackTrace();
        }
    }
}