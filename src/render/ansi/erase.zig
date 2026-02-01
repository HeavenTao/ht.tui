const std = @import("std");
const mem = std.mem;

// ==================== 擦除功能 ====================

/// 擦除整个屏幕
pub fn display(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[2J");
}

/// 从光标到屏幕末尾
pub fn displayToEnd(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[0J");
}

/// 从屏幕开头到光标
pub fn displayToStart(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[1J");
}

/// 擦除已保存的行
pub fn savedLines(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[3J");
}

/// 擦除整行
pub fn line(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[2K");
}

/// 从光标到行尾
pub fn lineToEnd(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[0K");
}

/// 从行首到光标
pub fn lineToStart(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[1K");
}

// ==================== 测试 ====================

test "display" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try display(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[2J", result);
}

test "displayToEnd" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try displayToEnd(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[0J", result);
}

test "displayToStart" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try displayToStart(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[1J", result);
}

test "savedLines" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try savedLines(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[3J", result);
}

test "line" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try line(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[2K", result);
}

test "lineToEnd" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try lineToEnd(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[0K", result);
}

test "lineToStart" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try lineToStart(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[1K", result);
}
