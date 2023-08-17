const std = @import("std");
const fs = std.fs;

const FileError = error{
    BadDayName,
};

pub fn getInput(year: u16, day: u8, allocator: std.mem.Allocator) ![]const u8 {
    const dayName = try switch (day) {
        1...9 => std.fmt.allocPrint(allocator, "0{d}", .{day}),
        10...25 => std.fmt.allocPrint(allocator, "{d}", .{day}),
        else => return FileError.BadDayName,
    };
    defer allocator.free(dayName);

    const bufName = try std.fmt.allocPrint(allocator, "../data/{d}/{s}.txt", .{ year, dayName });
    defer allocator.free(bufName);

    const file = try std.fs.cwd().openFile(bufName, .{});
    defer file.close();

    const stat = try file.stat();

    const contents = try file.reader().readAllAlloc(allocator, stat.size);

    return contents;
}
