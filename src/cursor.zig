const std = @import("std");
const cursor = @This();

pub fn moveCursor(x: u16, y: u16) void {
    std.debug.print("\x1b[{};{}H", .{ y, x });
}
