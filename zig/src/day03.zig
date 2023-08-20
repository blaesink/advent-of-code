const std = @import("std");
const utils = @import("utils.zig");

const Point = struct {
    x: i32,
    y: i32,
};

/// Modify the coordinates based on the input character.
fn change_coordinates(c: []const u8, x: *i32, y: *i32) void {
    if (std.mem.eql(u8, c, "^")) {
        y.* += 1;
    } else if (std.mem.eql(u8, c, "v")) {
        y.* -= 1;
    } else if (std.mem.eql(u8, c, ">")) {
        x.* += 1;
    } else if (std.mem.eql(u8, c, "<")) {
        x.* -= 1;
    }
}

fn part1(allocator: std.mem.Allocator, contents: []const u8) usize {
    var x: i32 = 0;
    var y: i32 = 0;

    var visited = std.AutoHashMap(Point, u8).init(allocator);
    visited.putNoClobber(Point{ .x = x, .y = y }, 1) catch unreachable;
    defer visited.deinit();

    var it = std.mem.window(u8, contents, 1, 1);

    while (it.next()) |c| {
        change_coordinates(c, &x, &y);
        visited.put(Point{ .x = x, .y = y }, 1) catch unreachable;
    }

    return @as(usize, visited.count());
}

fn part2(allocator: std.mem.Allocator, contents: []const u8) !usize {
    var santa_x: i32 = 0;
    var santa_y: i32 = 0;
    var robo_x: i32 = 0;
    var robo_y: i32 = 0;
    var is_santa = true;

    var visited = std.AutoHashMap(Point, u8).init(allocator);
    visited.putNoClobber(Point{ .x = 0, .y = 0 }, 1) catch unreachable;
    defer visited.deinit();

    var it = std.mem.window(u8, contents, 1, 1);

    while (it.next()) |char| {
        if (is_santa) {
            change_coordinates(char, &santa_x, &santa_y);
            visited.put(Point{ .x = santa_x, .y = santa_y }, 1) catch unreachable;
        } else {
            change_coordinates(char, &robo_x, &robo_y);
            visited.put(Point{ .x = robo_x, .y = robo_y }, 1) catch unreachable;
        }
        is_santa = !is_santa;
    }

    return @as(usize, visited.count());
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const contents = try utils.getInput(2015, 3, allocator);
    defer allocator.free(contents);

    std.debug.print("Part 1: {any}\n", .{part1(allocator, contents)});
    std.debug.print("Part 2: {any}\n", .{part2(allocator, contents)});
}

test "part 1" {
    const allocator = std.testing.allocator;

    const contents = try utils.getInput(2015, 3, allocator);
    defer allocator.free(contents);

    try std.testing.expectEqual(part1(allocator, contents), 2572);
}

test "part 2 ^v" {
    const allocator = std.testing.allocator;

    const contents = "^v";

    try std.testing.expectEqual(try part2(allocator, contents), 3);
}

test "part 2 ^>v<" {
    const allocator = std.testing.allocator;
    const contents = "^>v<";

    try std.testing.expectEqual(try part2(allocator, contents), 3);
}

test "part 2 ^v^v^v^v^v" {
    const allocator = std.testing.allocator;
    const contents = "^v^v^v^v^v";
    try std.testing.expectEqual(try part2(allocator, contents), 11);
}
