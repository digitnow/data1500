import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;

public class FileValueUpdaterSync {

    private static int modifyValue(int value) {
        return value + 1; // Endre denne logikken etter behov
    }

    private static int readValueFromFile(String filePath) throws IOException {
        try (RandomAccessFile file = new RandomAccessFile(filePath, "rw");
             FileChannel channel = file.getChannel();
             FileLock lock = channel.lock()) { // Lås filen for lesing/skriving

            String line = file.readLine();
            if (line != null) {
                return Integer.parseInt(line.trim());
            } else {
                throw new IllegalArgumentException("Filen er tom eller inneholder ikke en gyldig tallverdi.");
            }
        }
    }

    private static void writeValueToFile(String filePath, int value) throws IOException {
        try (RandomAccessFile file = new RandomAccessFile(filePath, "rw");
             FileChannel channel = file.getChannel();
             FileLock lock = channel.lock()) { // Lås filen for lesing/skriving

            file.setLength(0); // Tøm filen før skriving
            file.writeBytes(Integer.toString(value));
        }
    }

    public static void main(String[] args) {
        String filePath = "td/value.txt"; // Filbanen til filen som inneholder verdien

        try {
            int currentValue = readValueFromFile(filePath);
            System.out.println("Verdi lest fra fil: " + currentValue);

            int newValue = modifyValue(currentValue);
            System.out.println("Ny verdi etter endring: " + newValue);

            // Simuler en forsinkelse (f.eks. 5 sekunder)
            System.out.println("Simulerer forsinkelse...");
            Thread.sleep(5000); // 5000 millisekunder = 5 sekunder

            writeValueToFile(filePath, newValue);
            System.out.println("Ny verdi skrevet til fil.");

        } catch (IOException e) {
            System.err.println("Feil under filoperasjon: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.err.println("Ugyldig data i filen: " + e.getMessage());
        } catch (InterruptedException e) {
            System.err.println("Forsinkelsen ble avbrutt: " + e.getMessage());
        }
    }
}