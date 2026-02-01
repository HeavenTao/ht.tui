// ==================== 其他控制字符 ====================

/// 终端铃声
pub fn bell() []const u8 {
    return "\x07";
}

/// 退格键
pub fn backspace() []const u8 {
    return "\x08";
}

/// 水平制表符
pub fn tab() []const u8 {
    return "\x09";
}

/// 换行符
pub fn linefeed() []const u8 {
    return "\x0a";
}

/// 回车符
pub fn carriageReturn() []const u8 {
    return "\x0d";
}

// ==================== 测试 ====================

const std = @import("std");

test "bell" {
    const testing = std.testing;
    const result = bell();
    try testing.expectEqualStrings("\x07", result);
}

test "backspace" {
    const testing = std.testing;
    const result = backspace();
    try testing.expectEqualStrings("\x08", result);
}

test "tab" {
    const testing = std.testing;
    const result = tab();
    try testing.expectEqualStrings("\x09", result);
}

test "linefeed" {
    const testing = std.testing;
    const result = linefeed();
    try testing.expectEqualStrings("\x0a", result);
}

test "carriageReturn" {
    const testing = std.testing;
    const result = carriageReturn();
    try testing.expectEqualStrings("\x0d", result);
}
