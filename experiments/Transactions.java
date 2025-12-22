import java.io.*;
import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Transactions {
    public static void main(String[] args) throws IOException {
        int port = 5005;
        ServerSocket serverSocket = new ServerSocket(port);
        System.out.println("Server listening on port " + port);

        while (true) {
            Socket clientSocket = serverSocket.accept();
            System.out.println("New connection from " + clientSocket.getInetAddress());

            new Thread(() -> handleRequest(clientSocket)).start();
        }
    }

    private static void handleRequest(Socket clientSocket) {
        try (
            BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            OutputStream out = clientSocket.getOutputStream();
            PrintWriter writer = new PrintWriter(out, true);
        ) {
            // Les HTTP-forespørselen
            String requestLine = in.readLine();
            System.out.println("Request: " + requestLine);

            if (requestLine != null) {
                String[] requestParts = requestLine.split(" ");
                String method = requestParts[0]; // HTTP-metoden (GET eller POST)
                String path = requestParts[1];   // URI-en (f.eks. /update eller /balance)

                if (method.equals("POST") && path.equals("/trx/update")) {
                    // T1: Oppdater balansen til Alice
                    updateBalance(writer);
                } else if (method.equals("GET") && path.equals("/trx/balance")) {
                    // T2: Hent balansen til Alice
                    getBalance(writer);
                } else if (method.equals("GET") && path.equals("/trx/")) {
                    // Skriv ut hele tabellen Konto
                    fetchDataFromDatabase(writer);
                } else {
                    // Ugyldig forespørsel
                    sendResponse(writer, "HTTP/1.1 404 Not Found", "Path not found");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                clientSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static void updateBalance(PrintWriter writer) {
        try (Connection connection = getConnection()) {
            // Start transaksjonen
            connection.setAutoCommit(false);

            connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            // Oppdater balansen til Alice
            String sql = "UPDATE accounts SET balance = balance + 100 WHERE name = 'Alice'";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.executeUpdate();
            }

            // Simuler en langvarig transaksjon
            Thread.sleep(10000); // 10 sekunder

            // Rollback transaksjonen
            connection.rollback();
            sendResponse(writer, "HTTP/1.1 200 OK", "Balance update rolled back");
        } catch (SQLException | InterruptedException e) {
            e.printStackTrace();
            sendResponse(writer, "HTTP/1.1 500 Internal Server Error", "Error during update");
        }
    }

    private static void getBalance(PrintWriter writer) {
        try (Connection connection = getConnection()) {
            // Start transaksjonen
            connection.setAutoCommit(false);
            connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            // Hent balansen til Alice
            String sql = "SELECT balance FROM accounts WHERE name = 'Alice'";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    double balance = resultSet.getDouble("balance");
                    sendResponse(writer, "HTTP/1.1 200 OK", "Balance: " + balance);
                } else {
                    sendResponse(writer, "HTTP/1.1 404 Not Found", "Account not found");
                }
            }

            // Commit transaksjonen
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            sendResponse(writer, "HTTP/1.1 500 Internal Server Error", "Error during balance retrieval");
        }
    }

    private static void fetchDataFromDatabase(PrintWriter writer) {
        StringBuilder htmlContent = new StringBuilder();
        htmlContent.append("<!DOCTYPE html><html><head><title>Kontooversikt</title></head><body>");
        htmlContent.append("<h1>Kontooversikt</h1>");
        htmlContent.append("<table border='1'><tr><th>KontoId</th><th>KontoNavn</th><th>Balanse</th></tr>");

        try (Connection connection = getConnection()) {
            String sql = "SELECT * FROM Konto";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                // Legg til rader i HTML-tabellen basert på databaseinnholdet
                while (resultSet.next()) {
                    int kontoId = resultSet.getInt("KontoId");
                    String kontoNavn = resultSet.getString("KontoNavn");
                    double balanse = resultSet.getDouble("Balanse");

                    htmlContent.append("<tr>")
                               .append("<td>").append(kontoId).append("</td>")
                               .append("<td>").append(kontoNavn).append("</td>")
                               .append("<td>").append(balanse).append("</td>")
                               .append("</tr>");
                }
                htmlContent.append("</table></body></html>");
                sendResponse(writer, "HTTP/1.1 200 OK", htmlContent.toString());
            }            
        } catch (SQLException e) {
            e.printStackTrace();
            sendResponse(writer, "HTTP/1.1 500 Internal Server Error", "Feil ved henting av data fra databasen");
        }    
    }    

    private static Connection getConnection() throws SQLException {
        // Databasekonfigurasjon
        //String url = "jdbc:mysql://localhost:3306/kap10";
        //String username = "u_kap10_25";
        //String password = "123.Kap10#";
        String DB_URL = System.getenv("DB_URL");
        String DB_USER = System.getenv("DB_USER");
        String DB_PASSWORD = System.getenv("DB_PASSWORD");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private static void sendResponse(PrintWriter writer, String status, String body) {
        String response = status + "\r\n"
                        + "Content-Type: text/plain\r\n"
                        + "Content-Length: " + body.length() + "\r\n"
                        + "Connection: close\r\n"
                        + "\r\n"
                        + body;
        writer.print(response);
    }
}