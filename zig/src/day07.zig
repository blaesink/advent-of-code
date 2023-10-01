const std = @import("std");
const utils = @import("utils.zig");
const testing = std.testing;
const expect = testing.expect;
const expectEqual = testing.expectEqual;

const Op = enum {
    // SET,
    NOT,
    AND,
    OR,
    LSHFT,
    RSHFT,
};

const keywords = std.ComptimeStringMap(Op, .{
    // .{ "->", .SET },
    .{ "NOT", .NOT },
    .{ "AND", .AND },
    .{ "OR", .OR },
    .{ "LSHIFT", .LSHFT },
    .{ "RSHIFT", .RSHFT },
});

test "simple Tests" {
    {
        const input =
            \\y -> x
            \\123 -> y
        ;
        const actual = solve(input);
        try expectEqual(actual.get("x"), 123);
    }
}
