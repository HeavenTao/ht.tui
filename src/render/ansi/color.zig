const std = @import("std");
const mem = std.mem;

// ==================== 前景色 8-16色 ====================

/// 设置前景色为黑色
pub fn fgBlack(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[30m");
}

/// 设置前景色为红色
pub fn fgRed(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[31m");
}

/// 设置前景色为绿色
pub fn fgGreen(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[32m");
}

/// 设置前景色为黄色
pub fn fgYellow(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[33m");
}

/// 设置前景色为蓝色
pub fn fgBlue(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[34m");
}

/// 设置前景色为品红色
pub fn fgMagenta(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[35m");
}

/// 设置前景色为青色
pub fn fgCyan(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[36m");
}

/// 设置前景色为白色
pub fn fgWhite(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[37m");
}

/// 设置前景色为默认
pub fn fgDefault(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[39m");
}

// ==================== 背景色 8-16色 ====================

/// 设置背景色为黑色
pub fn bgBlack(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[40m");
}

/// 设置背景色为红色
pub fn bgRed(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[41m");
}

/// 设置背景色为绿色
pub fn bgGreen(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[42m");
}

/// 设置背景色为黄色
pub fn bgYellow(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[43m");
}

/// 设置背景色为蓝色
pub fn bgBlue(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[44m");
}

/// 设置背景色为品红色
pub fn bgMagenta(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[45m");
}

/// 设置背景色为青色
pub fn bgCyan(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[46m");
}

/// 设置背景色为白色
pub fn bgWhite(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[47m");
}

/// 设置背景色为默认
pub fn bgDefault(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[49m");
}

// ==================== 前景色 亮色 ====================

/// 设置前景色为亮黑色
pub fn fgBrightBlack(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[90m");
}

/// 设置前景色为亮红色
pub fn fgBrightRed(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[91m");
}

/// 设置前景色为亮绿色
pub fn fgBrightGreen(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[92m");
}

/// 设置前景色为亮黄色
pub fn fgBrightYellow(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[93m");
}

/// 设置前景色为亮蓝色
pub fn fgBrightBlue(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[94m");
}

/// 设置前景色为亮品红色
pub fn fgBrightMagenta(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[95m");
}

/// 设置前景色为亮青色
pub fn fgBrightCyan(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[96m");
}

/// 设置前景色为亮白色
pub fn fgBrightWhite(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[97m");
}

// ==================== 背景色 亮色 ====================

/// 设置背景色为亮黑色
pub fn bgBrightBlack(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[100m");
}

/// 设置背景色为亮红色
pub fn bgBrightRed(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[101m");
}

/// 设置背景色为亮绿色
pub fn bgBrightGreen(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[102m");
}

/// 设置背景色为亮黄色
pub fn bgBrightYellow(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[103m");
}

/// 设置背景色为亮蓝色
pub fn bgBrightBlue(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[104m");
}

/// 设置背景色为亮品红色
pub fn bgBrightMagenta(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[105m");
}

/// 设置背景色为亮青色
pub fn bgBrightCyan(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[106m");
}

/// 设置背景色为亮白色
pub fn bgBrightWhite(allocator: mem.Allocator) ![]u8 {
    return try allocator.dupe(u8, "\x1b[107m");
}

// ==================== 测试 ====================

test "fgBlack" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgBlack(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[30m", result);
}

test "fgRed" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgRed(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[31m", result);
}

test "fgGreen" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgGreen(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[32m", result);
}

test "fgBlue" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgBlue(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[34m", result);
}

test "fgDefault" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgDefault(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[39m", result);
}

test "bgBlack" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgBlack(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[40m", result);
}

test "bgRed" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgRed(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[41m", result);
}

test "bgGreen" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgGreen(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[42m", result);
}

test "bgBlue" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgBlue(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[44m", result);
}

test "bgDefault" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgDefault(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[49m", result);
}

test "fgBrightWhite" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try fgBrightWhite(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[97m", result);
}

test "bgBrightWhite" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try bgBrightWhite(allocator);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[107m", result);
}
