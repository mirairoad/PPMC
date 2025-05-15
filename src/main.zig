const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        try stdout.print("Usage: zigpm --p=PORT [--workers=N] -- <command...>\n", .{});
        return;
    }

    var port: u16 = 8080;
    var worker_count: ?usize = null;

    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        if (std.mem.startsWith(u8, args[i], "--p=")) {
            port = try std.fmt.parseInt(u16, args[i][4..], 10);
        } else if (std.mem.startsWith(u8, args[i], "--workers=")) {
            worker_count = try std.fmt.parseInt(usize, args[i][10..], 10);
        } else if (std.mem.eql(u8, args[i], "--")) {
            i += 1;
            break;
        }
    }

    if (i >= args.len) {
        try stdout.print("No command provided.\n", .{});
        return;
    }

    const child_argv = args[i..];
    const cpu_count = try std.Thread.getCpuCount();
    const workers = worker_count orelse cpu_count;

    try stdout.print("Listening on port {d}, spawning {d} workers.\n", .{ port, workers });
    for (child_argv) |arg| {
        try stdout.print(" > {s}\n", .{arg});
    }

    // We'll continue from here in next step: spawn workers
}
