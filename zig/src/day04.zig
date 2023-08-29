const std = @import("std");
const input: []const u8 = "bgvyzdsv";
const md5 = std.crypto.hash.Md5;

fn part1(allocator: std.mem.Allocator, contents: []const u8) !usize {
    var i: usize = 0;

    while (true) {
        var hash_buf: [md5.digest_length]u8 = undefined;
        var hashed_string: [32]u8 = undefined;
        var input_str = std.ArrayList(u8).init(allocator);

        try input_str.appendSlice(contents);
        try input_str.appendSlice(try std.fmt.bufPrint(&hash_buf, "{d}", .{i}));
        defer input_str.deinit();

        md5.hash(input_str.items, &hash_buf, .{});

        const err = try std.fmt.bufPrint(&hashed_string, "{s}", .{std.fmt.fmtSliceHexLower(&hash_buf)});

        if (std.mem.startsWith(u8, err, "00000")) {
            break;
        }

        i += 1;
    }
    return i;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    std.debug.print("Part 1: {d}\n", .{try part1(allocator, input)});
}

test "part 1" {
    const allocator = std.testing.allocator;
    const key = "abcdef";

    try std.testing.expectEqual(try part1(allocator, key), 609043);
}
