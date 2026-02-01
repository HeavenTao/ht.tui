// ==================== 样式模式 ====================

/// 重置所有样式和颜色
pub fn reset() []const u8 {
    return "\x1b[0m";
}

/// 设置粗体
pub fn bold() []const u8 {
    return "\x1b[1m";
}

/// 设置暗淡
pub fn dim() []const u8 {
    return "\x1b[2m";
}

/// 设置斜体
pub fn italic() []const u8 {
    return "\x1b[3m";
}

/// 设置下划线
pub fn underline() []const u8 {
    return "\x1b[4m";
}

/// 设置闪烁
pub fn blink() []const u8 {
    return "\x1b[5m";
}

/// 设置反色
pub fn reverse() []const u8 {
    return "\x1b[7m";
}

/// 设置隐藏
pub fn hidden() []const u8 {
    return "\x1b[8m";
}

/// 设置删除线
pub fn strikethrough() []const u8 {
    return "\x1b[9m";
}

/// 取消粗体
pub fn resetBold() []const u8 {
    return "\x1b[22m";
}

/// 取消暗淡
pub fn resetDim() []const u8 {
    return "\x1b[22m";
}

/// 取消斜体
pub fn resetItalic() []const u8 {
    return "\x1b[23m";
}

/// 取消下划线
pub fn resetUnderline() []const u8 {
    return "\x1b[24m";
}

/// 取消闪烁
pub fn resetBlink() []const u8 {
    return "\x1b[25m";
}

/// 取消反色
pub fn resetReverse() []const u8 {
    return "\x1b[27m";
}

/// 取消隐藏
pub fn resetHidden() []const u8 {
    return "\x1b[28m";
}

/// 取消删除线
pub fn resetStrikethrough() []const u8 {
    return "\x1b[29m";
}

// ==================== 测试 ====================

const std = @import("std");

test "reset" {
    const testing = std.testing;
    const result = reset();
    try testing.expectEqualStrings("\x1b[0m", result);
}

test "bold" {
    const testing = std.testing;
    const result = bold();
    try testing.expectEqualStrings("\x1b[1m", result);
}

test "dim" {
    const testing = std.testing;
    const result = dim();
    try testing.expectEqualStrings("\x1b[2m", result);
}

test "italic" {
    const testing = std.testing;
    const result = italic();
    try testing.expectEqualStrings("\x1b[3m", result);
}

test "underline" {
    const testing = std.testing;
    const result = underline();
    try testing.expectEqualStrings("\x1b[4m", result);
}

test "blink" {
    const testing = std.testing;
    const result = blink();
    try testing.expectEqualStrings("\x1b[5m", result);
}

test "reverse" {
    const testing = std.testing;
    const result = reverse();
    try testing.expectEqualStrings("\x1b[7m", result);
}

test "hidden" {
    const testing = std.testing;
    const result = hidden();
    try testing.expectEqualStrings("\x1b[8m", result);
}

test "strikethrough" {
    const testing = std.testing;
    const result = strikethrough();
    try testing.expectEqualStrings("\x1b[9m", result);
}

test "resetBold" {
    const testing = std.testing;
    const result = resetBold();
    try testing.expectEqualStrings("\x1b[22m", result);
}

test "resetDim" {
    const testing = std.testing;
    const result = resetDim();
    try testing.expectEqualStrings("\x1b[22m", result);
}

test "resetItalic" {
    const testing = std.testing;
    const result = resetItalic();
    try testing.expectEqualStrings("\x1b[23m", result);
}

test "resetUnderline" {
    const testing = std.testing;
    const result = resetUnderline();
    try testing.expectEqualStrings("\x1b[24m", result);
}

test "resetBlink" {
    const testing = std.testing;
    const result = resetBlink();
    try testing.expectEqualStrings("\x1b[25m", result);
}

test "resetReverse" {
    const testing = std.testing;
    const result = resetReverse();
    try testing.expectEqualStrings("\x1b[27m", result);
}

test "resetHidden" {
    const testing = std.testing;
    const result = resetHidden();
    try testing.expectEqualStrings("\x1b[28m", result);
}

test "resetStrikethrough" {
    const testing = std.testing;
    const result = resetStrikethrough();
    try testing.expectEqualStrings("\x1b[29m", result);
}
