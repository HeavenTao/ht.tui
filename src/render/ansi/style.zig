const std = @import("std");
const mem = std.mem;

// ==================== 样式模式 ====================

/// 重置所有样式和颜色
pub fn reset(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[0m");
}

/// 设置粗体
pub fn bold(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[1m");
}

/// 设置暗淡
pub fn dim(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[2m");
}

/// 设置斜体
pub fn italic(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[3m");
}

/// 设置下划线
pub fn underline(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[4m");
}

/// 设置闪烁
pub fn blink(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[5m");
}

/// 设置反色
pub fn reverse(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[7m");
}

/// 设置隐藏
pub fn hidden(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[8m");
}

/// 设置删除线
pub fn strikethrough(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[9m");
}

/// 取消粗体
pub fn resetBold(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[22m");
}

/// 取消暗淡
pub fn resetDim(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[22m");
}

/// 取消斜体
pub fn resetItalic(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[23m");
}

/// 取消下划线
pub fn resetUnderline(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[24m");
}

/// 取消闪烁
pub fn resetBlink(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[25m");
}

/// 取消反色
pub fn resetReverse(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[27m");
}

/// 取消隐藏
pub fn resetHidden(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[28m");
}

/// 取消删除线
pub fn resetStrikethrough(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[29m");
}

// ==================== 测试 ====================

test "reset" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try reset(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[0m", result);
}

test "bold" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bold(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[1m", result);
}

test "dim" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try dim(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[2m", result);
}

test "italic" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try italic(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[3m", result);
}

test "underline" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try underline(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[4m", result);
}

test "blink" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try blink(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[5m", result);
}

test "reverse" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try reverse(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[7m", result);
}

test "hidden" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try hidden(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[8m", result);
}

test "strikethrough" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try strikethrough(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[9m", result);
}

test "resetBold" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetBold(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[22m", result);
}

test "resetDim" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetDim(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[22m", result);
}

test "resetItalic" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetItalic(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[23m", result);
}

test "resetUnderline" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetUnderline(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[24m", result);
}

test "resetBlink" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetBlink(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[25m", result);
}

test "resetReverse" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetReverse(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[27m", result);
}

test "resetHidden" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetHidden(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[28m", result);
}

test "resetStrikethrough" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try resetStrikethrough(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[29m", result);
}
