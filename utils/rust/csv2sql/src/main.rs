use csv::Reader;
use std::env;
use std::fs::File;
use std::io::{self};
//use std::path::Path;

fn main() -> io::Result<()> {
    // Get the filename from the command line
    let args: Vec<String> = env::args().collect();
    //println!("{}", &args[1]);

    // Check if a filename was provided
    if args.len() < 2 {
        eprintln!("Usage: {} <csv_file>", args[0]);
        std::process::exit(1);
    }

    // Path to the CSV file (taken from the command line)
    let csv_path = &args[1];

    // Read the CSV file
    let file = File::open(csv_path)?;
    let mut reader = Reader::from_reader(file);

    // Collect lines from the CSV file
    //let mut lines = reader.lines();

    // Skip the header row (assuming the first line is the header)
    //let _header = lines.next();

    // Start building the SQL INSERT statement
    let mut sql_insert = String::from("INSERT INTO your_table_name VALUES ");

    // Process each line
    for line in reader.records() {
        let record = line?;
        //let values: Vec<&str> = line.split(',').collect();

        // Format the values for SQL
        let formatted_values = record
            .iter()
            .map(|v| {
                if v.parse::<i32>().is_ok() || v.parse::<f64>().is_ok() {
                    v.to_string() // Numbers don't need quotes
                } else {
                    format!("\"{}\"", v) // Strings need quotes
                }
            })
            .collect::<Vec<String>>()
            .join(",");

        // Append the formatted values to the SQL statement
        sql_insert.push_str(&format!("({}),", formatted_values));
    }

    // Remove the trailing comma and add a semicolon
    sql_insert.pop(); // Remove the last comma
    sql_insert.push(';');

    // Print the final SQL INSERT statement
    println!("{}", sql_insert);

    Ok(())
}