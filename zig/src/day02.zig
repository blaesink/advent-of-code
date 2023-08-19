const std = @import("std");
const utils = @import("utils.zig");

/// Return the side with the smallest area in a rectangular prism.
fn min_area(l: usize, w: usize, h: usize) usize {
    const area_1 = l * w;
    const area_2 = l * h;
    const area_3 = w * h;
    return @min(area_1, @min(area_2, area_3));
}

fn wrappingArea(l: usize, w: usize, h: usize) usize {
    const side_1: usize = 2 * l * w;
    const side_2: usize = 2 * w * h;
    const side_3: usize = 2 * h * l;

    return side_1 + side_2 + side_3 + min_area(l, w, h);
}

fn ribbonLength(l: usize, w: usize, h: usize) usize {
    const min_side = @min(l, @min(w, h));
    // Is it ugly? Yes. Is it probably fast-ish? Probably.
    const second_smallest = @max(@max(@min(l, w), @min(l, h)), @min(h, w));

    return (l * w * h) + (2 * min_side) + (2 * second_smallest);
}

fn part1(input: []const u8) !usize {
    var result: usize = 0;

    var it = std.mem.tokenizeSequence(u8, input, "\n");
    while (it.next()) |line| {
        var parts = std.mem.splitAny(u8, line, "x");
        const l = try std.fmt.parseInt(u8, parts.next().?, 10);
        const w = try std.fmt.parseInt(u8, parts.next().?, 10);
        const h = try std.fmt.parseInt(u8, parts.next().?, 10);

        result += wrappingArea(l, w, h);
    }
    return result;
}

fn part2(input: []const u8) !usize {
    var result: usize = 0;

    var it = std.mem.tokenizeSequence(u8, input, "\n");
    while (it.next()) |line| {
        var parts = std.mem.splitAny(u8, line, "x");
        const l = try std.fmt.parseInt(u8, parts.next().?, 10);
        const w = try std.fmt.parseInt(u8, parts.next().?, 10);
        const h = try std.fmt.parseInt(u8, parts.next().?, 10);

        result += ribbonLength(l, w, h);
    }
    return result;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const contents = try utils.getInput(2015, 2, allocator);
    defer allocator.free(contents);

    std.debug.print("Part 1: {d}\n", .{try part1(contents)});
    std.debug.print("Part 2: {d}\n", .{try part2(contents)});
}

test "wrapping area of 2x3x4 present is 58" {
    try std.testing.expect(wrappingArea(2, 3, 4) == 58);
}

test "day 1 is right" {
    const allocator = std.testing.allocator;
    const contents = try utils.getInput(2015, 2, allocator);
    defer allocator.free(contents);

    try std.testing.expect(try part1(contents) == 1588178);
}

test "ribbon length of 2x3x4 is 34" {
    try std.testing.expect(ribbonLength(2, 3, 4) == 34);
}

test "part 2 is right" {
    const allocator = std.testing.allocator;
    const contents = try utils.getInput(2015, 2, allocator);
    defer allocator.free(contents);

    try std.testing.expect(try part2(contents) == 3783758);
}
