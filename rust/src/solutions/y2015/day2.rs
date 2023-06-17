use std::cmp::min;

use crate::problem::{load, Solution};

pub struct Day2;

impl Solution for Day2 {
    fn a(&self) -> String {
        let input = load(2015, 2);

        input
            .lines()
            .map(|line| Present::from(line).wrapping_paper_area() as u32)
            .sum::<u32>()
            .to_string()
    }

    fn b(&self) -> String {
        let input = load(2015, 2);

        input
            .lines()
            .map(|line| Present::from(line).ribbon_length() as u32)
            .sum::<u32>()
            .to_string()
    }
}

struct Present {
    l: u16,
    w: u16,
    h: u16,
}

impl From<&str> for Present {
    fn from(s: &str) -> Self {
        let mut split = s.split('x');
        let l = split.next().unwrap().parse::<u16>().unwrap();
        let w = split.next().unwrap().parse::<u16>().unwrap();
        let h = split.next().unwrap().parse::<u16>().unwrap();
        Self { l, w, h }
    }
}

impl Present {
    fn wrapping_paper_area(&self) -> u16 {
        let side1 = self.l * self.w;
        let side2 = self.w * self.h;
        let side3 = self.h * self.l;

        2 * side1 + 2 * side2 + 2 * side3 + min(side1, min(side2, side3))
    }

    fn volume(&self) -> u16 {
        self.l * self.w * self.h
    }

    fn ribbon_length(&self) -> u16 {
        let mut sides = [self.l, self.w, self.h];
        sides.sort();

        let smallest_side: u16 = sides.iter().take(2).sum();

        smallest_side * 2 + self.volume()
    }
}

#[cfg(test)]
mod test {
    use super::Present;

    #[test]
    fn test_wrapping_paper_area() {
        let present = Present::from("2x3x4");
        assert_eq!(present.l, 2);
        assert_eq!(present.w, 3);
        assert_eq!(present.h, 4);
        assert_eq!(present.wrapping_paper_area(), 58);
    }

    #[test]
    fn test_ribbon_length() {
        let present = Present::from("2x3x4");
        assert_eq!(present.ribbon_length(), 34);
    }
}
