const std = @import("std");
const testing = std.testing;
const ascii = std.ascii;

// We love symlinks.
const input = @embedFile("data/day1.txt");

/// Collects digits from a line.
fn getDigitsFromLine(line: []const u8) []u8 {
    var digits: [8]u8 = undefined;
    var i: u8 = 0;

    for (line) |char| {
        if (ascii.isDigit(char)) {
            digits[i] = char - 48;
            i += 1;
        }
    }

    return digits[0..i];
}

pub fn main() void {
    var part_one: usize = 0;

    var lines = std.mem.splitAny(u8, input, "\n");

    while (lines.next()) |line| {
        const digits = getDigitsFromLine(line);

        if (digits.len > 0) {
            var x: usize = digits[0];
            var y: usize = digits[digits.len - 1];

            var pow: usize = 10;
            while (y >= pow) {
                pow *= 10;
            }
            part_one += x * pow + y;
        }
    }

    std.debug.print("Part One: {d}\n", .{part_one});
}
