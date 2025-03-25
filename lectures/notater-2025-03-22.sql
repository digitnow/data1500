MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.008 sec)

MariaDB [(none)]> CREATE DATABASE kap10;
Query OK, 1 row affected (0.004 sec)

MariaDB [(none)]> 
MariaDB [(none)]> CREATE USER 'u_kap10_25'@'localhost' IDENTIFIED BY '123.Kap10#';
Query OK, 0 rows affected (0.007 sec)

MariaDB [(none)]> GRANT CREATE ON kap10.* TO 'u_kap10_25'@'localhost';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> GRANT SELECT, INSERT, UPDATE, DELETE ON kap10.* TO 'u_kap10_25'@'localhost';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> use kap10
Database changed
MariaDB [kap10]> show tables;
Empty set (0.000 sec)

MariaDB [kap10]> CREATE TABLE Konto (
    ->     KontoId INT AUTO_INCREMENT PRIMARY KEY,
    ->     KontoNavn VARCHAR(50) NOT NULL,
    ->     Balanse DECIMAL(10, 2) NOT NULL
    -> );
Query OK, 0 rows affected (0.010 sec)

MariaDB [kap10]> 
MariaDB [kap10]> INSERT INTO Konto (KontoNavn, Balanse) VALUES ('Alice', 1000.00), ('Bob', 500.00);
Query OK, 2 rows affected (0.004 sec)
Records: 2  Duplicates: 0  Warnings: 0

MariaDB [kap10]> 
MariaDB [kap10]> SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
Query OK, 0 rows affected (0.000 sec)

MariaDB [kap10]> SELECT @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| READ-UNCOMMITTED        |
+-------------------------+
1 row in set (0.000 sec)

MariaDB [kap10]> show grants for 'u_kap10_25'@'localhost';
+-------------------------------------------------------------------------------------------------------------------+
| Grants for u_kap10_25@localhost                                                                                   |
+-------------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `u_kap10_25`@`localhost` IDENTIFIED BY PASSWORD '*18F129A1175612847C206742AD5C153491167513' |
| GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON `kap10`.* TO `u_kap10_25`@`localhost`                             |
+-------------------------------------------------------------------------------------------------------------------+
2 rows in set (0.000 sec)