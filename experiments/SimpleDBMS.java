import java.io.*;
import java.util.*;

public class SimpleDBMS {
    private static final String DATA_FILE = "database.txt";
    private static final String INDEX_FILE = "index.txt";
    private Map<String, Long> index; // Indeks for rask søking
    private Map<String, String> cache; // Bufferminne (cache)

    public SimpleDBMS() {
        index = new HashMap<>();
        cache = new HashMap<>();
        loadIndex(); // Last indeksen fra fil ved oppstart
    }

    // Lagre en post i databasen
    public void insert(String key, String value) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_FILE, true))) {
            long position = new File(DATA_FILE).length(); // Finn posisjon for ny post
            writer.write(key + ":" + value + "\n"); // Skriv posten til filen
            index.put(key, position); // Oppdater indeksen
            cache.put(key, value); // Oppdater bufferminnet
            saveIndex(); // Lagre indeksen til fil
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Hent en post fra databasen
    public String get(String key) {
        // Sjekk først i bufferminnet
        if (cache.containsKey(key)) {
            return cache.get(key);
        }

        // Hent posisjon fra indeksen
        Long position = index.get(key);
        if (position == null) {
            return null; // Posten finnes ikke
        }

        // Les posten fra filen
        try (RandomAccessFile file = new RandomAccessFile(DATA_FILE, "r")) {
            file.seek(position); // Gå til riktig posisjon
            String line = file.readLine(); // Les linjen
            if (line != null) {
                String[] parts = line.split(":");
                if (parts.length == 2 && parts[0].equals(key)) {
                    cache.put(key, parts[1]); // Oppdater bufferminnet
                    return parts[1]; // Returner verdien
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Last indeksen fra fil
    private void loadIndex() {
        try (BufferedReader reader = new BufferedReader(new FileReader(INDEX_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length == 2) {
                    index.put(parts[0], Long.parseLong(parts[1]));
                }
            }
        } catch (IOException e) {
            // Ignorer hvis filen ikke finnes (første gang)
        }
    }

    // Lagre indeksen til fil
    private void saveIndex() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(INDEX_FILE))) {
            for (Map.Entry<String, Long> entry : index.entrySet()) {
                writer.write(entry.getKey() + ":" + entry.getValue() + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Enkel transaksjonshåndtering (simulert)
    public void beginTransaction() {
        System.out.println("Transaction started.");
    }

    public void commitTransaction() {
        saveIndex(); // Lagre endringer i indeksen
        System.out.println("Transaction committed.");
    }

    public void rollbackTransaction() {
        loadIndex(); // Tilbakestill indeksen til siste lagrede tilstand
        cache.clear(); // Tøm bufferminnet
        System.out.println("Transaction rolled back.");
    }

    public static void main(String[] args) {
        SimpleDBMS db = new SimpleDBMS();

        // Start en transaksjon
        db.beginTransaction();

        // Sett inn noen data
        db.insert("key1", "value1");
        db.insert("key2", "value2");

        // Hent data
        System.out.println("key1: " + db.get("key1")); // Fra bufferminnet
        System.out.println("key2: " + db.get("key2")); // Fra bufferminnet
        System.out.println("key3: " + db.get("key3")); // Finnes ikke

        // Avslutt transaksjonen
        db.commitTransaction();

        // Simuler en transaksjonsrollback
        db.beginTransaction();
        db.insert("key3", "value3");
        db.rollbackTransaction();
        System.out.println("key3 after rollback: " + db.get("key3")); // Finnes ikke
    }
}