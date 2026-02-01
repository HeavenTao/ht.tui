const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

// ==================== RGB真彩色 ====================

/// 设置前景色为RGB真彩色
pub fn fg(allocator: mem.Allocator, r: u8, g: u8, b: u8) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[38;2;{d};{d};{d}m", .{ r, g, b });
}

/// 设置背景色为RGB真彩色
pub fn bg(allocator: mem.Allocator, r: u8, g: u8, b: u8) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[48;2;{d};{d};{d}m", .{ r, g, b });
}

// ==================== 测试 ====================

test "fg" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fg(allocator, 255, 128, 64);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[38;2;255;128;64m", result);
}

test "bg" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bg(allocator, 100, 200, 50);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[48;2;100;200;50m", result);
}

test "fgBlack" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fg(allocator, 0, 0, 0);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[38;2;0;0;0m", result);
}

test "bgWhite" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bg(allocator, 255, 255, 255);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[48;2;255;255;255m", result);
}

test "fgRed" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fg(allocator, 255, 0, 0);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[38;2;255;0;0m", result);
}

test "bgGreen" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bg(allocator, 0, 255, 0);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[48;2;0;255;0m", result);
}
