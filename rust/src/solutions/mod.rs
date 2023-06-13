mod y2015;

pub fn get_year(year: u32) -> &'static [&'static dyn crate::problem::Solution] {
    match year {
        2015 => &y2015::SOLUTIONS,
        _ => &[],
    }
}
