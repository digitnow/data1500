import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class FileValueUpdater {

    // Funksjon for å endre verdien (her økes verdien med 1 som eksempel)
    private static int modifyValue(int value) {
        return value + 1; // Endre denne logikken etter behov
    }

    // Les verdien fra filen
    private static int readValueFromFile(String filePath) throws FileNotFoundException {
        File file = new File(filePath);
        try (Scanner scanner = new Scanner(file)) {
            if (scanner.hasNextInt()) {
                return scanner.nextInt();
            } else {
                throw new IllegalArgumentException("Filen inneholder ikke en gyldig tallverdi.");
            }
        }
    }

    // Skriv den nye verdien til filen
    private static void writeValueToFile(String filePath, int value) throws IOException {
        try (FileWriter writer = new FileWriter(filePath)) {
            writer.write(Integer.toString(value));
        }
    }

    public static void main(String[] args) {
        String filePath = "td/value.txt"; // Filbanen til filen som inneholder verdien

        try {
            // Les verdien fra filen
            int currentValue = readValueFromFile(filePath);
            System.out.println("Verdi lest fra fil: " + currentValue);

            // Endre verdien ved hjelp av en intern funksjon
            int newValue = modifyValue(currentValue);
            System.out.println("Ny verdi etter endring: " + newValue);

            // Simuler en forsinkelse (f.eks. 5 sekunder)
            System.out.println("Simulerer forsinkelse...");
            Thread.sleep(5000); // 5000 millisekunder = 5 sekunder

            // Skriv den nye verdien tilbake til filen
            writeValueToFile(filePath, newValue);
            System.out.println("Ny verdi skrevet til fil.");

        } catch (FileNotFoundException e) {
            System.err.println("Filen ble ikke funnet: " + e.getMessage());
        } catch (IOException e) {
            System.err.println("Feil under lesing/skriving til fil: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.err.println("Ugyldig data i filen: " + e.getMessage());
        } catch (InterruptedException e) {
            System.err.println("Forsinkelsen ble avbrutt: " + e.getMessage());
        }
    }
}