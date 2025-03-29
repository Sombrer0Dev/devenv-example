pub mod day01;
pub mod day02;
pub mod day03;
pub mod day04;
pub mod day05;
pub mod day06;
pub mod err;

use day01::solve_day1_1;
use day01::solve_day1_2;
use day02::solve_day2_1;
use day02::solve_day2_2;
use day03::solve_day3_1;
use day03::solve_day3_2;
use day04::solve_day4_1;
use day04::solve_day4_2;
use day05::solve_day5_1;
use day05::solve_day5_2;
use day06::solve_day6_1;
use day06::solve_day6_2;
use err::Error;
use err::Result;

use dotenv::dotenv;
use std::env;
use std::fs;

pub fn switch(day: i8, part: i8, sample: bool) -> Result<i64> {
    let ans: i64;
    let path: String;
    let input: String;
    let mut err: Error = Error::new(String::from(""));

    dotenv().ok();
    let root_path = env::var("ROOT_PATH");
    match (root_path, sample) {
        (Ok(v), true) => {
            path = format!("{v}/data/samples/{day}_{part}");
        }
        (Ok(v), false) => {
            path = format!("{v}/data/inputs/{day}");
        }
        (Err(e), _) => {
            err.text = e.to_string();
            return Err(err);
        }
    }

    match fs::read_to_string(path) {
        Ok(v) => input = v,
        Err(e) => {
            err.text = e.to_string();
            return Err(err);
        }
    }

    match (day, part) {
        (1, 1) => ans = solve_day1_1(input),
        (1, 2) => ans = solve_day1_2(input),
        (2, 1) => ans = solve_day2_1(input),
        (2, 2) => ans = solve_day2_2(input),
        (3, 1) => ans = solve_day3_1(input),
        (3, 2) => ans = solve_day3_2(input),
        (4, 1) => ans = solve_day4_1(input),
        (4, 2) => ans = solve_day4_2(input),
        (5, 1) => ans = solve_day5_1(input),
        (5, 2) => ans = solve_day5_2(input),
        (6, 1) => ans = solve_day6_1(input),
        (6, 2) => ans = solve_day6_2(input),
        (_, _) => {
            err.text = String::from("no such day or part");
            return Err(err);
        }
    }

    return Ok(ans);
}
