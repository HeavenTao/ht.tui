// ==================== 屏幕模式 ====================

/// 隐藏光标
pub fn hideCursor() []const u8 {
    return "\x1b[?25l";
}

/// 显示光标
pub fn showCursor() []const u8 {
    return "\x1b[?25h";
}

/// 保存屏幕
pub fn save() []const u8 {
    return "\x1b[?47h";
}

/// 恢复屏幕
pub fn restore() []const u8 {
    return "\x1b[?47l";
}

/// 启用备用缓冲区
pub fn enableAltBuffer() []const u8 {
    return "\x1b[?1049h";
}

/// 禁用备用缓冲区
pub fn disableAltBuffer() []const u8 {
    return "\x1b[?1049l";
}

/// 启用自动换行
pub fn enableLineWrap() []const u8 {
    return "\x1b[=7h";
}

/// 禁用自动换行
pub fn disableLineWrap() []const u8 {
    return "\x1b[=7l";
}

// ==================== 测试 ====================

const std = @import("std");

test "hideCursor" {
    const testing = std.testing;
    const result = hideCursor();
    try testing.expectEqualStrings("\x1b[?25l", result);
}

test "showCursor" {
    const testing = std.testing;
    const result = showCursor();
    try testing.expectEqualStrings("\x1b[?25h", result);
}

test "save" {
    const testing = std.testing;
    const result = save();
    try testing.expectEqualStrings("\x1b[?47h", result);
}

test "restore" {
    const testing = std.testing;
    const result = restore();
    try testing.expectEqualStrings("\x1b[?47l", result);
}

test "enableAltBuffer" {
    const testing = std.testing;
    const result = enableAltBuffer();
    try testing.expectEqualStrings("\x1b[?1049h", result);
}

test "disableAltBuffer" {
    const testing = std.testing;
    const result = disableAltBuffer();
    try testing.expectEqualStrings("\x1b[?1049l", result);
}

test "enableLineWrap" {
    const testing = std.testing;
    const result = enableLineWrap();
    try testing.expectEqualStrings("\x1b[=7h", result);
}

test "disableLineWrap" {
    const testing = std.testing;
    const result = disableLineWrap();
    try testing.expectEqualStrings("\x1b[=7l", result);
}
