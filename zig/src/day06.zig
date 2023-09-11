const utils = @import("utils.zig");
const std = @import("std");
const print = std.debug.print;

fn grid() [1000][1000]u1 {
    return std.mem.zeroes([1000][1000]u1);
}

const Instruction = enum {
    Toggle,
    On,
    Off,
};

fn parseInstruction(line: []const u8) ![4]u16 {
    var i: usize = 0;
    var ar: [4]u16 = undefined;
    var it = std.mem.splitAny(u8, line, ", ");

    while (it.next()) |w| {
        if (!std.mem.eql(u8, w, "through")) {
            ar[i] = try std.fmt.parseInt(u16, w, 10);
        }
        i += 1;
    }
    return ar;
}

fn part1(input: []const u8) !usize {
    var lines = std.mem.splitScalar(u8, input, '\n');

    while (lines.next()) |line| {
        var fwd_search_idx: u8 = 0;
        var instruction: Instruction = undefined;

        if (std.mem.count(u8, line, "toggle") > 0) {
            fwd_search_idx = 7;
            instruction = .Toggle;
        } else if (std.mem.count(u8, line, "turn on") > 0) {
            fwd_search_idx = 8;
            instruction = .On;
        } else if (std.mem.count(u8, line, "turn off") > 0) {
            fwd_search_idx = 9;
            instruction = .Off;
        }

        const to_from = try parseInstruction(line[fwd_search_idx..]);
        print("{d}\n", .{to_from[0]});
    }
    return 0;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const alloc = arena.allocator();
    const input = try utils.getInput(2015, 6, alloc);

    print("{d}\n", .{try part1(input)});
}

test "parseInstruction" {
    const expected = [_]u16{ 0, 0, 999, 999 };
    try std.testing.expectEqual(try parseInstruction("0,0 through 999,999"), expected);
}
