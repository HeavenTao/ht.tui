const std = @import("std");
const mem = std.mem;

// ==================== 其他控制字符 ====================

/// 终端铃声
pub fn bell(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x07");
}

/// 退格键
pub fn backspace(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x08");
}

/// 水平制表符
pub fn tab(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x09");
}

/// 换行符
pub fn linefeed(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x0a");
}

/// 回车符
pub fn carriageReturn(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x0d");
}

// ==================== 测试 ====================

test "bell" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bell(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x07", result);
}

test "backspace" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try backspace(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x08", result);
}

test "tab" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try tab(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x09", result);
}

test "linefeed" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try linefeed(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x0a", result);
}

test "carriageReturn" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try carriageReturn(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x0d", result);
}
