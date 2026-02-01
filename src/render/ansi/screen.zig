const std = @import("std");
const mem = std.mem;

// ==================== 屏幕模式 ====================

/// 隐藏光标
pub fn hideCursor(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?25l");
}

/// 显示光标
pub fn showCursor(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?25h");
}

/// 保存屏幕
pub fn save(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?47h");
}

/// 恢复屏幕
pub fn restore(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?47l");
}

/// 启用备用缓冲区
pub fn enableAltBuffer(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?1049h");
}

/// 禁用备用缓冲区
pub fn disableAltBuffer(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[?1049l");
}

/// 启用自动换行
pub fn enableLineWrap(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[=7h");
}

/// 禁用自动换行
pub fn disableLineWrap(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[=7l");
}

// ==================== 测试 ====================

test "hideCursor" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try hideCursor(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?25l", result);
}

test "showCursor" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try showCursor(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?25h", result);
}

test "save" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try save(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?47h", result);
}

test "restore" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try restore(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?47l", result);
}

test "enableAltBuffer" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try enableAltBuffer(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?1049h", result);
}

test "disableAltBuffer" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try disableAltBuffer(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[?1049l", result);
}

test "enableLineWrap" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try enableLineWrap(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[=7h", result);
}

test "disableLineWrap" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try disableLineWrap(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[=7l", result);
}
