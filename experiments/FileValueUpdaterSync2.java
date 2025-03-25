import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;

public class FileValueUpdaterSync2 {

    private static int modifyValue(int value) {
        return value + 1; // Endre denne logikken etter behov
    }

    public static void main(String[] args) {
        String filePath = "td/value.txt"; // Filbanen til filen som inneholder verdien

        try (RandomAccessFile file = new RandomAccessFile(filePath, "rw");
             FileChannel channel = file.getChannel();
             FileLock lock = channel.lock()) { // Lås filen for hele transaksjonen

            // Les verdien fra filen
            String line = file.readLine();
            int currentValue = line != null ? Integer.parseInt(line.trim()) : 0;
            System.out.println("Verdi lest fra fil: " + currentValue);

            // Endre verdien
            int newValue = modifyValue(currentValue);
            System.out.println("Ny verdi etter endring: " + newValue);

            // Simuler en forsinkelse (f.eks. 5 sekunder)
            System.out.println("Simulerer forsinkelse...");
            Thread.sleep(5000); // 5000 millisekunder = 5 sekunder

            // Skriv den nye verdien tilbake til filen
            file.setLength(0); // Tøm filen før skriving
            file.writeBytes(Integer.toString(newValue));
            System.out.println("Ny verdi skrevet til fil.");

        } catch (IOException e) {
            System.err.println("Feil under filoperasjon: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.err.println("Ugyldig data i filen: " + e.getMessage());
        } catch (InterruptedException e) {
            System.err.println("Forsinkelsen ble avbrutt: " + e.getMessage());
        }
    }
}