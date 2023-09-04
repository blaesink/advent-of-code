const std = @import("std");
const utils = @import("utils.zig");

fn countVowels(input: []const u8) u8 {
    var i: u8 = 0;
    for (input) |char| {
        switch (char) {
            'a', 'e', 'i', 'o', 'u' => i += 1,
            else => continue,
        }
    }
    return i;
}

///Check if word contains the strings ab, cd, pq, or xy.
///Returns true if any exist.
fn hasIllegalCharacterSequence(input: []const u8) bool {
    const illegal_sequences = [4][]const u8{ "ab", "cd", "pq", "xy" };
    for (illegal_sequences) |expr| {
        if (std.mem.containsAtLeast(u8, input, 1, expr)) {
            return true;
        }
    }
    return false;
}

fn hasDuplicateCharacter(input: []const u8) bool {
    var previous_letter = input[0];

    for (input[1..]) |char| {
        if (char == previous_letter) {
            return true;
        }
        previous_letter = char;
    }
    return false;
}

fn isNice(input: []const u8) bool {
    if ((countVowels(input) >= 3) and
        hasDuplicateCharacter(input) and
        !hasIllegalCharacterSequence(input))
    {
        return true;
    }
    return false;
}

fn partOne(input: []const u8) usize {
    var num_nice: usize = 0;

    var lines = std.mem.splitScalar(u8, input, '\n');

    while (lines.next()) |line| {
        if (isNice(line)) {
            num_nice += 1;
        }
    }
    return num_nice;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();
    const input = try utils.getInput(2015, 5, allocator);

    std.debug.print("{d}\n", .{partOne(input)});
}

test "count vowels aaa" {
    try std.testing.expectEqual(countVowels("aaa"), 3);
}

test "count vowels abeiy" {
    try std.testing.expectEqual(countVowels("abeiy"), 3);
}

test "has illegal character ab" {
    try std.testing.expect(hasIllegalCharacterSequence("abba"));
}

test "doesn't have illegal character ab" {
    try std.testing.expect(!hasIllegalCharacterSequence("cerq"));
}

test "has illegal characters pq" {
    try std.testing.expect(hasIllegalCharacterSequence("apq"));
}

test "has duplicate letter dd" {
    try std.testing.expect(hasDuplicateCharacter("abba"));
}

test "isNice ugknbfddgicrmopn components" {
    const input = "ugknbfddgicrmopn";
    try std.testing.expect(countVowels(input) >= 3);
    try std.testing.expect(hasDuplicateCharacter(input));
    try std.testing.expect(!hasIllegalCharacterSequence(input));
}

test "isNice ugknbfddgicrmopn" {
    try std.testing.expect(isNice("ugknbfddgicrmopn"));
}

test "isNaughty jchzalrnumimnmhp" {
    try std.testing.expect(!isNice("jchzalrnumimnmhp"));
}
