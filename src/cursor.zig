const std = @import("std");
const cursor = @This();

pub fn moveCursor(x: u16, y: u16) void {
    std.debug.print("ESC[{{s}};{{s}}H", .{ x, y });
}
