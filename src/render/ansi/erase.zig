// ==================== 擦除功能 ====================

/// 擦除整个屏幕
pub fn display() []const u8 {
    return "\x1b[2J";
}

/// 从光标到屏幕末尾
pub fn displayToEnd() []const u8 {
    return "\x1b[0J";
}

/// 从屏幕开头到光标
pub fn displayToStart() []const u8 {
    return "\x1b[1J";
}

/// 擦除已保存的行
pub fn savedLines() []const u8 {
    return "\x1b[3J";
}

/// 擦除整行
pub fn line() []const u8 {
    return "\x1b[2K";
}

/// 从光标到行尾
pub fn lineToEnd() []const u8 {
    return "\x1b[0K";
}

/// 从行首到光标
pub fn lineToStart() []const u8 {
    return "\x1b[1K";
}

// ==================== 测试 ====================

const std = @import("std");

test "display" {
    const testing = std.testing;
    const result = display();
    try testing.expectEqualStrings("\x1b[2J", result);
}

test "displayToEnd" {
    const testing = std.testing;
    const result = displayToEnd();
    try testing.expectEqualStrings("\x1b[0J", result);
}

test "displayToStart" {
    const testing = std.testing;
    const result = displayToStart();
    try testing.expectEqualStrings("\x1b[1J", result);
}

test "savedLines" {
    const testing = std.testing;
    const result = savedLines();
    try testing.expectEqualStrings("\x1b[3J", result);
}

test "line" {
    const testing = std.testing;
    const result = line();
    try testing.expectEqualStrings("\x1b[2K", result);
}

test "lineToEnd" {
    const testing = std.testing;
    const result = lineToEnd();
    try testing.expectEqualStrings("\x1b[0K", result);
}

test "lineToStart" {
    const testing = std.testing;
    const result = lineToStart();
    try testing.expectEqualStrings("\x1b[1K", result);
}
