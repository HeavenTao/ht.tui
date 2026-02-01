const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

// ==================== 256色模式 ====================

/// 设置前景色为256色模式
pub fn fg(allocator: mem.Allocator, id: usize) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[38;5;{d}m", .{id});
}

/// 设置背景色为256色模式
pub fn bg(allocator: mem.Allocator, id: usize) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[48;5;{d}m", .{id});
}

// ==================== 测试 ====================

test "fg" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fg(allocator, 128);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[38;5;128m", result);
}

test "bg" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bg(allocator, 255);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[48;5;255m", result);
}

test "fgZero" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fg(allocator, 0);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[38;5;0m", result);
}

test "bgHigh" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bg(allocator, 200);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[48;5;200m", result);
}
