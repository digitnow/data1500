import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MeasureQueryTime {
    public static void main(String[] args) {
        // Databasekonfigurasjon
        String url = "jdbc:mysql://localhost:3306/database"; // Erstatt med din database-URL
        String user = "brukernavn"; // Erstatt med ditt brukernavn
        String password = "passord"; // Erstatt med ditt passord

        // SQL-spørring (eksempel fra uke 12, 2025)
        String query = "SELECT * FROM Kunde WHERE etternavn = 'Etternavn99999';";

        // Mål starttid
        long startTime = System.currentTimeMillis();

        try (Connection connection = DriverManager.getConnection(url, user, password);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            // Mål sluttid
            long endTime = System.currentTimeMillis();

            // Beregn tidsbruk
            long duration = endTime - startTime;
            System.out.println("Tid brukt: " + duration + " millisekunder");

            // Behandle resultatet (valgfritt)
            while (resultSet.next()) {
                int kundeId = resultSet.getInt("kunde_id");
                String fornavn = resultSet.getString("fornavn");
                String etternavn = resultSet.getString("etternavn");
                System.out.println("Kunde ID: " + kundeId + ", Navn: " + fornavn + " " + etternavn);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}