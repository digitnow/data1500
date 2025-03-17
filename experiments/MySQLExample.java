import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class MySQLExample {
    public static void main(String[] args) {
        // JDBC-URL, brukernavn og passord
        String jdbcUrl = "jdbc:mariadb://trial-mariadb:3306/hobbyhuset"; // Erstatt 'databasenavn' med faktisk navn
        String username = "root"; // Standard brukernavn for MariaDB
        String password = "passord"; // Passordet du satte i docker-compose.yml

        try {
            // 1. Registrer JDBC-driveren (ikke nødvendig for MariaDB JDBC-driver >= 2.0)
            Class.forName("org.mariadb.jdbc.Driver");

            // 2. Opprett tilkobling til databasen
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
            System.out.println("Tilkoblingen til databasen var vellykket!");

            // 3. Opprett et Statement for å utføre spørringer
            Statement statement = connection.createStatement();

            // 4. Utfør en spørring
            String sql = "SELECT * FROM Vare"; // Erstatt 'din_tabell' med faktisk tabellnavn
            ResultSet resultSet = statement.executeQuery(sql);

            // 5. Behandle resultatet
            while (resultSet.next()) {
                System.out.println("Resultat: " + resultSet.getString("betegnelse")); // Erstatt 'kolonne_navn'
            }

            // 6. Lukk ressurser
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}