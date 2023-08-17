const std = @import("std");
const fs = std.fs;
const utils = @import("utils.zig");

const lparen = "(";
const rparen = ")";

fn part1(input: []const u8) i32 {
    var floor: i32 = 0;

    var it = std.mem.window(u8, input, 1, 1);

    while (it.next()) |char| {
        if (std.mem.eql(u8, char, lparen)) {
            floor += 1;
        } else if (std.mem.eql(u8, char, rparen)) {
            floor -= 1;
        } else {
            continue;
        }
    }

    return floor;
}

fn part2(input: []const u8) u32 {
    var floor: i32 = 0;
    var index: u32 = 0;

    var it = std.mem.window(u8, input, 1, 1);

    while (it.next()) |char| {
        index += 1;

        if (std.mem.eql(u8, char, lparen)) {
            floor += 1;
        } else if (std.mem.eql(u8, char, rparen)) {
            floor -= 1;
        }

        if (floor < 0) {
            break;
        }
    }
    return index;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const contents = try utils.getInput(2015, 1, allocator);
    defer allocator.free(contents);

    std.debug.print("Part 1: {d}\n", .{part1(contents)});
    std.debug.print("Part 2: {d}\n", .{part2(contents)});
}
