use crate::problem::{load, Solution};

pub struct Day1;

impl Solution for Day1 {
    fn a(&self) -> String {
        let input = load(2015, 1);

        let mut floor = 0;

        input.chars().for_each(|char| match char {
            '(' => {
                floor += 1;
            }
            ')' => {
                floor -= 1;
            }
            _ => (),
        });

        floor.to_string()
    }
    /// Naive solution.
    fn b(&self) -> String {
        let input = load(2015, 1);
        let mut floor = 0;
        let mut i = 0;

        for (_, char) in input.chars().enumerate() {
            match char {
                '(' => {
                    floor += 1;
                }
                ')' => {
                    floor -= 1;
                }
                _ => (),
            }
            i += 1;
            if floor < 0 {
                break;
            }
        }

        i.to_string()
    }
}
