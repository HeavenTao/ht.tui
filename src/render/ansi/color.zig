const std = @import("std");
const mem = std.mem;

// ==================== 前景色 8-16色 ====================

/// 设置前景色为黑色
pub fn fgBlack() []const u8 {
    return "\x1b[30m";
}

/// 设置前景色为红色
pub fn fgRed() []const u8 {
    return "\x1b[31m";
}

/// 设置前景色为绿色
pub fn fgGreen() []const u8 {
    return "\x1b[32m";
}

/// 设置前景色为黄色
pub fn fgYellow() []const u8 {
    return "\x1b[33m";
}

/// 设置前景色为蓝色
pub fn fgBlue() []const u8 {
    return "\x1b[34m";
}

/// 设置前景色为品红色
pub fn fgMagenta() []const u8 {
    return "\x1b[35m";
}

/// 设置前景色为青色
pub fn fgCyan() []const u8 {
    return "\x1b[36m";
}

/// 设置前景色为白色
pub fn fgWhite() []const u8 {
    return "\x1b[37m";
}

/// 设置前景色为默认
pub fn fgDefault() []const u8 {
    return "\x1b[39m";
}

// ==================== 背景色 8-16色 ====================

/// 设置背景色为黑色
pub fn bgBlack() []const u8 {
    return "\x1b[40m";
}

/// 设置背景色为红色
pub fn bgRed() []const u8 {
    return "\x1b[41m";
}

/// 设置背景色为绿色
pub fn bgGreen() []const u8 {
    return "\x1b[42m";
}

/// 设置背景色为黄色
pub fn bgYellow() []const u8 {
    return "\x1b[43m";
}

/// 设置背景色为蓝色
pub fn bgBlue() []const u8 {
    return "\x1b[44m";
}

/// 设置背景色为品红色
pub fn bgMagenta() []const u8 {
    return "\x1b[45m";
}

/// 设置背景色为青色
pub fn bgCyan() []const u8 {
    return "\x1b[46m";
}

/// 设置背景色为白色
pub fn bgWhite() []const u8 {
    return "\x1b[47m";
}

/// 设置背景色为默认
pub fn bgDefault() []const u8 {
    return "\x1b[49m";
}

// ==================== 前景色 亮色 ====================

/// 设置前景色为亮黑色
pub fn fgBrightBlack() []const u8 {
    return "\x1b[90m";
}

/// 设置前景色为亮红色
pub fn fgBrightRed() []const u8 {
    return "\x1b[91m";
}

/// 设置前景色为亮绿色
pub fn fgBrightGreen() []const u8 {
    return "\x1b[92m";
}

/// 设置前景色为亮黄色
pub fn fgBrightYellow() []const u8 {
    return "\x1b[93m";
}

/// 设置前景色为亮蓝色
pub fn fgBrightBlue() []const u8 {
    return "\x1b[94m";
}

/// 设置前景色为亮品红色
pub fn fgBrightMagenta() []const u8 {
    return "\x1b[95m";
}

/// 设置前景色为亮青色
pub fn fgBrightCyan() []const u8 {
    return "\x1b[96m";
}

/// 设置前景色为亮白色
pub fn fgBrightWhite() []const u8 {
    return "\x1b[97m";
}

// ==================== 背景色 亮色 ====================

/// 设置背景色为亮黑色
pub fn bgBrightBlack() []const u8 {
    return "\x1b[100m";
}

/// 设置背景色为亮红色
pub fn bgBrightRed() []const u8 {
    return "\x1b[101m";
}

/// 设置背景色为亮绿色
pub fn bgBrightGreen() []const u8 {
    return "\x1b[102m";
}

/// 设置背景色为亮黄色
pub fn bgBrightYellow() []const u8 {
    return "\x1b[103m";
}

/// 设置背景色为亮蓝色
pub fn bgBrightBlue() []const u8 {
    return "\x1b[104m";
}

/// 设置背景色为亮品红色
pub fn bgBrightMagenta() []const u8 {
    return "\x1b[105m";
}

/// 设置背景色为亮青色
pub fn bgBrightCyan() []const u8 {
    return "\x1b[106m";
}

/// 设置背景色为亮白色
pub fn bgBrightWhite() []const u8 {
    return "\x1b[107m";
}

// ==================== 通用颜色函数 ====================

/// 设置前景色（根据颜色代码）
/// 支持8-16色模式和256色模式
pub fn fg(allocator: mem.Allocator, code: u8) ![]u8 {
    const fg_8color_min: u8 = 30;
    const fg_8color_max: u8 = 37;
    const fg_bright_min: u8 = 90;
    const fg_bright_max: u8 = 97;

    if (code >= fg_8color_min and code <= fg_8color_max) {
        return std.fmt.allocPrint(allocator, "\x1b[{d}m", .{code});
    } else if (code >= fg_bright_min and code <= fg_bright_max) {
        return std.fmt.allocPrint(allocator, "\x1b[{d}m", .{code});
    } else {
        return std.fmt.allocPrint(allocator, "\x1b[38;5;{d}m", .{code});
    }
}

/// 设置背景色（根据颜色代码）
/// 支持8-16色模式和256色模式
pub fn bg(allocator: mem.Allocator, code: u8) ![]u8 {
    const bg_8color_min: u8 = 40;
    const bg_8color_max: u8 = 47;
    const bg_bright_min: u8 = 100;
    const bg_bright_max: u8 = 107;

    if (code >= bg_8color_min and code <= bg_8color_max) {
        return std.fmt.allocPrint(allocator, "\x1b[{d}m", .{code});
    } else if (code >= bg_bright_min and code <= bg_bright_max) {
        return std.fmt.allocPrint(allocator, "\x1b[{d}m", .{code});
    } else {
        return std.fmt.allocPrint(allocator, "\x1b[48;5;{d}m", .{code});
    }
}

// ==================== 测试 ====================

test "fgBlack" {
    const testing = std.testing;
    const result = fgBlack();
    try testing.expectEqualStrings("\x1b[30m", result);
}

test "fgRed" {
    const testing = std.testing;
    const result = fgRed();
    try testing.expectEqualStrings("\x1b[31m", result);
}

test "fgGreen" {
    const testing = std.testing;
    const result = fgGreen();
    try testing.expectEqualStrings("\x1b[32m", result);
}

test "fgBlue" {
    const testing = std.testing;
    const result = fgBlue();
    try testing.expectEqualStrings("\x1b[34m", result);
}

test "fgDefault" {
    const testing = std.testing;
    const result = fgDefault();
    try testing.expectEqualStrings("\x1b[39m", result);
}

test "bgBlack" {
    const testing = std.testing;
    const result = bgBlack();
    try testing.expectEqualStrings("\x1b[40m", result);
}

test "bgRed" {
    const testing = std.testing;
    const result = bgRed();
    try testing.expectEqualStrings("\x1b[41m", result);
}

test "bgGreen" {
    const testing = std.testing;
    const result = bgGreen();
    try testing.expectEqualStrings("\x1b[42m", result);
}

test "bgBlue" {
    const testing = std.testing;
    const result = bgBlue();
    try testing.expectEqualStrings("\x1b[44m", result);
}

test "bgDefault" {
    const testing = std.testing;
    const result = bgDefault();
    try testing.expectEqualStrings("\x1b[49m", result);
}

test "fgBrightWhite" {
    const testing = std.testing;
    const result = fgBrightWhite();
    try testing.expectEqualStrings("\x1b[97m", result);
}

test "bgBrightWhite" {
    const testing = std.testing;
    const result = bgBrightWhite();
    try testing.expectEqualStrings("\x1b[107m", result);
}
