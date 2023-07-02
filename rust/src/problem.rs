use std::fs;

pub trait Solution {
    fn a(&self) -> String;
    fn b(&self) -> String;
}

fn load_raw(year: u32, day: u32) -> String {
    let file = format!("../data/{year}/{:02}.txt", day);
    fs::read_to_string(&file).unwrap_or_else(|_| panic!("Error reading file {}", file))
}

pub fn load(year: u32, day: u32) -> String {
    load_raw(year, day).trim().replace('\r', "")
}
