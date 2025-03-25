import java.sql.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class BankAccount {
    private int id;
    private double balance;
    private final Lock lock = new ReentrantLock();

    public BankAccount(int id, double initialBalance) {
        this.id = id;
        this.balance = initialBalance;
    }

    public void transfer(BankAccount to, double amount) {
        // Fase 1: Vekstfasen - skaff alle låser
        lock.lock();
        try {
            to.lock.lock();
            try {
                // Fase 2: Krympfasen - utfør transaksjonen
                if (this.balance >= amount) {
                    this.balance -= amount;
                    to.balance += amount;
                    System.out.println(Thread.currentThread().getName() + 
                                     " Overførte " + amount + 
                                     " fra konto " + this.id + 
                                     " til konto " + to.id);
                } else {
                    System.out.println(Thread.currentThread().getName() + 
                                     " Utilstrekkelig balanse på konto " + this.id);
                }
            } finally {
                to.lock.unlock();
            }
        } finally {
            lock.unlock();
        }
    }

    public double getBalance() {
        return balance;
    }
}

public class TwoPhaseLockingExample {
    public static void main(String[] args) throws InterruptedException {
        BankAccount account1 = new BankAccount(1, 1000);
        BankAccount account2 = new BankAccount(2, 1000);

        // Tråd 1: Overfører fra konto 1 til konto 2
        Thread thread1 = new Thread(() -> {
            for (int i = 0; i < 100; i++) {
                account1.transfer(account2, 10);
            }
        }, "Tråd-1");

        // Tråd 2: Overfører fra konto 2 til konto 1
        Thread thread2 = new Thread(() -> {
            for (int i = 0; i < 100; i++) {
                account2.transfer(account1, 10);
            }
        }, "Tråd-2");

        thread1.start();
        thread2.start();

        thread1.join();
        thread2.join();

        System.out.println("Endelig balanse:");
        System.out.println("Konto 1: " + account1.getBalance());
        System.out.println("Konto 2: " + account2.getBalance());
    }
}