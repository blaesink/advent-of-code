const std = @import("std");
const re = @cImport({
    @cInclude("regez.h");
});

const REGEX_T_ALIGNOF = re.sizeof_regex_t;
const REGEX_T_SIZEOF = re.alignof_regex_t;

const input = @embedFile("data/day6.txt");

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var lines = std.mem.splitAny(u8, input, "\n");
    _ = lines;

    var slice = try allocator.alignedAlloc(u8, REGEX_T_ALIGNOF, REGEX_T_SIZEOF);
    const regex = @as(*re.regex_t, @ptrCast(slice.ptr));
    defer re.regfree(regex);
    defer allocator.free(@as([*]u8, @ptrCast(regex))[0..REGEX_T_SIZEOF]);
}
