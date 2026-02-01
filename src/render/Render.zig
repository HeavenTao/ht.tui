const std = @import("std");
const Allocator = std.mem.Allocator;
const Screen = @import("Screen.zig");
const Cell = @import("Cell.zig");
const Style = @import("Style.zig");
const Render = @This();
const translator = @import("Translator.zig");

prevScreen: Screen,

pub fn render(self: *Render, allocator: Allocator, screen: Screen) ?[]u8 {
    const diffCells: ?[]Cell = screen.diff(self.prevScreen, allocator) catch return null;
    defer if (diffCells) |cells| allocator.free(cells);

    if (diffCells == null) {
        return null;
    }

    var buf: std.ArrayList(u8) = .empty;
    errdefer buf.deinit(allocator);

    for (diffCells.?) |cell| {
        const cellBuf: ?[]u8 = translator.translate(allocator, cell) catch null;
        defer if (cellBuf) |cells| allocator.free(cells);

        if (cellBuf) |cells| {
            _ = buf.appendSlice(allocator, cells) catch null;
        }
    }

    self.prevScreen = screen;

    return buf.toOwnedSlice(allocator) catch null;
}

// ==================== 测试 ====================

test "render - 无差异屏幕" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    var cells = try allocator.alloc(Cell, 4);
    defer allocator.free(cells);
    for (0..4) |i| {
        cells[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    const screen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells,
    };

    var renderer = Render{
        .prevScreen = screen,
    };

    const result = renderer.render(allocator, screen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expectEqual(@as(usize, 0), r.len);
        allocator.free(r);
    }
}

test "render - 单个单元格差异" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    const style2 = Style{
        .bold = true,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    var cells1 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells1);
    for (0..4) |i| {
        cells1[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    var cells2 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells2);
    for (0..4) |i| {
        cells2[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = if (i == 2) style2 else style1,
        };
    }

    const prevScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells1,
    };

    const newScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells2,
    };

    var renderer = Render{
        .prevScreen = prevScreen,
    };

    const result = renderer.render(allocator, newScreen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expect(r.len > 0);
        allocator.free(r);
    }
}

test "render - 多个单元格差异" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    const style2 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    var cells1 = try allocator.alloc(Cell, 9);
    defer allocator.free(cells1);
    for (0..9) |i| {
        cells1[i] = Cell{
            .line = @intCast(i / 3),
            .column = @intCast(i % 3),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    var cells2 = try allocator.alloc(Cell, 9);
    defer allocator.free(cells2);
    for (0..9) |i| {
        const isDifferent = (i == 1 or i == 4 or i == 7);
        cells2[i] = Cell{
            .line = @intCast(i / 3),
            .column = @intCast(i % 3),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = if (isDifferent) style2 else style1,
        };
    }

    const prevScreen = Screen{
        .rows = 3,
        .cols = 3,
        .cells = cells1,
    };

    const newScreen = Screen{
        .rows = 3,
        .cols = 3,
        .cells = cells2,
    };

    var renderer = Render{
        .prevScreen = prevScreen,
    };

    const result = renderer.render(allocator, newScreen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expect(r.len > 0);
        allocator.free(r);
    }
}

test "render - 屏幕尺寸不同" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    var cells1 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells1);
    for (0..4) |i| {
        cells1[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    var cells2 = try allocator.alloc(Cell, 6);
    defer allocator.free(cells2);
    for (0..6) |i| {
        cells2[i] = Cell{
            .line = @intCast(i / 3),
            .column = @intCast(i % 3),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    const prevScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells1,
    };

    const newScreen = Screen{
        .rows = 2,
        .cols = 3,
        .cells = cells2,
    };

    var renderer = Render{
        .prevScreen = prevScreen,
    };

    const result = renderer.render(allocator, newScreen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expect(r.len > 0);
        allocator.free(r);
    }
}

test "render - 字节值差异" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    var cells1 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells1);
    for (0..4) |i| {
        cells1[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    var cells2 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells2);
    for (0..4) |i| {
        cells2[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = if (i == 1) @as(u8, 90) else @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    const prevScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells1,
    };

    const newScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells2,
    };

    var renderer = Render{
        .prevScreen = prevScreen,
    };

    const result = renderer.render(allocator, newScreen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expect(r.len > 0);
        allocator.free(r);
    }
}

test "render - 所有单元格不同" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const style1 = Style{
        .bold = false,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    const style2 = Style{
        .bold = true,
        .dim = true,
        .italic = true,
        .underline = true,
        .blinking = true,
        .reverse = true,
        .hidden = true,
        .strikethrough = true,
    };

    var cells1 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells1);
    for (0..4) |i| {
        cells1[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    var cells2 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells2);
    for (0..4) |i| {
        cells2[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
            .byte = @intCast(90 + @as(u8, @intCast(i))),
            .style = style2,
        };
    }

    const prevScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells1,
    };

    const newScreen = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells2,
    };

    var renderer = Render{
        .prevScreen = prevScreen,
    };

    const result = renderer.render(allocator, newScreen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expect(r.len > 0);
        allocator.free(r);
    }
}

test "render - 空屏幕" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cells = try allocator.alloc(Cell, 0);
    defer allocator.free(cells);

    const screen = Screen{
        .rows = 0,
        .cols = 0,
        .cells = cells,
    };

    var renderer = Render{
        .prevScreen = screen,
    };

    const result = renderer.render(allocator, screen);
    try testing.expect(result != null);
    if (result) |r| {
        try testing.expectEqual(@as(usize, 0), r.len);
        allocator.free(r);
    }
}
