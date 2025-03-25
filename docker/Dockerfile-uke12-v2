# Bruk et offisielt Java-basert image som utgangspunkt
FROM openjdk:17-jdk-slim

# Opprett en mappe for applikasjonen
WORKDIR /app

# Last ned MySQL JDBC-driveren
RUN apt-get update && apt-get install -y wget
RUN wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar -O mysql-connector-java.jar

# Kopier Java-kildekoden til containeren
COPY Transactions.java .

# Kompiler Java-koden
RUN javac -cp mysql-connector-java.jar Transactions.java

# Angi porten som applikasjonen kjører på
EXPOSE 5005

# Kjør applikasjonen når containeren starter
CMD ["java", "-cp", ".:mysql-connector-java.jar", "Transactions"]