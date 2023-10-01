const std = @import("std");

fn compile_day(
    b: *std.build.Builder,
    target: std.zig.CrossTarget,
    optimize: std.builtin.Mode,
    counter: usize,
) void {
    const name = b.fmt("day{:0>2}", .{counter});
    const path = b.fmt("src/{s}.zig", .{name});

    const exe = b.addExecutable(.{
        .name = name,
        .root_source_file = .{ .path = path },
        .target = target,
        .optimize = optimize,
    });

    const install_cmd = b.addInstallArtifact(exe, .{});
    const install_step = b.step(b.fmt("build_{s}", .{name}), "Build day");
    install_step.dependOn(&install_cmd.step);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(&install_cmd.step);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(b.fmt("{s}", .{name}), "Run specified day");
    run_step.dependOn(&run_cmd.step);
}

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    comptime var counter: usize = 1;
    inline while (counter < 8) {
        compile_day(b, target, optimize, counter);
        counter += 1;
    }
}
