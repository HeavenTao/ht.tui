const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

// ==================== 光标控制 ====================

/// 移动光标到原点 (0, 0)
pub fn home() []const u8 {
    return "\x1b[H";
}

/// 移动光标到指定行列
pub fn move(allocator: mem.Allocator, line: u16, col: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d};{d}H", .{ line, col });
}

/// 移动光标到指定行列 (同 move)
pub fn moveF(allocator: mem.Allocator, line: u16, col: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d};{d}f", .{ line, col });
}

/// 光标向上移动指定行数
pub fn up(allocator: mem.Allocator, lines: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}A", .{lines});
}

/// 光标向下移动指定行数
pub fn down(allocator: mem.Allocator, lines: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}B", .{lines});
}

/// 光标向右移动指定列数
pub fn right(allocator: mem.Allocator, cols: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}C", .{cols});
}

/// 光标向左移动指定列数
pub fn left(allocator: mem.Allocator, cols: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}D", .{cols});
}

/// 移动光标到下一行开头，向下移动指定行数
pub fn nextLine(allocator: mem.Allocator, lines: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}E", .{lines});
}

/// 移动光标到上一行开头，向上移动指定行数
pub fn prevLine(allocator: mem.Allocator, lines: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}F", .{lines});
}

/// 移动光标到指定列
pub fn column(allocator: mem.Allocator, col: u16) ![]u8 {
    return try fmt.allocPrint(allocator, "\x1b[{d}G", .{col});
}

/// 请求光标位置
pub fn requestPosition() []const u8 {
    return "\x1b[6n";
}

/// 保存光标位置 (DEC)
pub fn save() []const u8 {
    return "\x1b 7";
}

/// 恢复光标位置 (DEC)
pub fn restore() []const u8 {
    return "\x1b 8";
}

/// 保存光标位置 (SCO)
pub fn saveSCO() []const u8 {
    return "\x1b[s";
}

/// 恢复光标位置 (SCO)
pub fn restoreSCO() []const u8 {
    return "\x1b[u";
}

// ==================== 测试 ====================

test "home" {
    const testing = std.testing;
    const result = home();
    try testing.expectEqualStrings("\x1b[H", result);
}

test "move" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try move(allocator, 5, 10);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[5;10H", result);
}

test "moveF" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try moveF(allocator, 7, 3);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[7;3f", result);
}

test "up" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try up(allocator, 3);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[3A", result);
}

test "down" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try down(allocator, 5);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[5B", result);
}

test "right" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try right(allocator, 2);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[2C", result);
}

test "left" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try left(allocator, 4);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[4D", result);
}

test "nextLine" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try nextLine(allocator, 2);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[2E", result);
}

test "prevLine" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try prevLine(allocator, 3);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[3F", result);
}

test "column" {
    const testing = std.testing;
    const allocator = testing.allocator;
    const result = try column(allocator, 15);
    defer allocator.free(result);
    try testing.expectEqualStrings("\x1b[15G", result);
}

test "requestPosition" {
    const testing = std.testing;
    const result = requestPosition();
    try testing.expectEqualStrings("\x1b[6n", result);
}

test "save" {
    const testing = std.testing;
    const result = save();
    try testing.expectEqualStrings("\x1b 7", result);
}

test "restore" {
    const testing = std.testing;
    const result = restore();
    try testing.expectEqualStrings("\x1b 8", result);
}

test "saveSCO" {
    const testing = std.testing;
    const result = saveSCO();
    try testing.expectEqualStrings("\x1b[s", result);
}

test "restoreSCO" {
    const testing = std.testing;
    const result = restoreSCO();
    try testing.expectEqualStrings("\x1b[u", result);
}
