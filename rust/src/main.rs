mod problem;
mod solutions;
// use crate::problem::Solution;
use clap::{Parser, Subcommand};

const DEFAULT_YEAR: u32 = 2015;

#[derive(Parser)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    #[command(about = "Generate a new project")]
    Run {
        day: u32,
        part: char,
        year: Option<u32>,
    },
}

fn main() {
    let args = Cli::parse();

    match args.command {
        Commands::Run { year, day, part } => {
            let year = year.unwrap_or(DEFAULT_YEAR);
            let day = day.saturating_sub(1);

            let s = solutions::get_year(year);

            let solution = match s.get(day as usize) {
                Some(s) => s,
                None => {
                    return println!("No solution for day {} {}", day, year);
                }
            };

            let out = match part.to_lowercase().to_string().as_str() {
                "a" => solution.a(),
                "b" => solution.b(),
                _ => {
                    return println!("Invalid part {}", part);
                }
            };

            println!("{}", out);
        }
    }
}
