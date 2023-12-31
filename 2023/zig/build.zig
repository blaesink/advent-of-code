const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // Not really a var because it's never mutated, but I don't want to
    // make the rest of the build look ugly.
    //
    // This var holds the days that have been completed / being worked on.
    // It's an array because some days are done in different languages, and I don't care
    // to redo them.
    comptime var days = [_]u8{ 1, 6 };

    inline for (days) |day| {
        @setEvalBranchQuota(100000); // comptimePrint is pretty expensive
        const day_string = comptime std.fmt.comptimePrint("{:0>1}", .{day});
        const src_file = "src/" ++ "day" ++ day_string ++ ".zig";

        const exe = b.addExecutable(.{
            .name = day_string,
            .root_source_file = .{ .path = src_file },
            .target = target,
            .optimize = optimize,
        });
        b.installArtifact(exe);

        exe.linkLibC();
        exe.addIncludePath(.{ .path = "lib/regez" });

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());

        const unit_tests = b.addTest(.{
            .root_source_file = .{ .path = src_file },
            .target = target,
            .optimize = optimize,
        });

        const run_tests = b.addRunArtifact(unit_tests);

        const test_step = b.step("test" ++ day_string, "Run tests for this day");
        test_step.dependOn(&run_tests.step);

        const run_step = b.step("run" ++ day_string, "Run this day");
        run_step.dependOn(&run_cmd.step);
    }
}
