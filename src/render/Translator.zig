const std = @import("std");
const Cell = @import("Cell.zig");
const Style = @import("Style.zig");
const cursor = @import("ansi/cursor.zig");
const Allocator = std.mem.Allocator;
const style = @import("ansi/style.zig");

pub fn translate(allocator: Allocator, cell: Cell) ![]u8 {
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    const moveBuf = try cursor.move(allocator, cell.line + 1, cell.column + 1);
    defer allocator.free(moveBuf);
    try buf.appendSlice(allocator, moveBuf);

    if (cell.style.bold) {
        const boldBuf = style.bold();
        try buf.appendSlice(allocator, boldBuf);
    }
    if (cell.style.dim) {
        const dimBuf = style.dim();
        try buf.appendSlice(allocator, dimBuf);
    }
    if (cell.style.italic) {
        const italicBuf = style.italic();
        try buf.appendSlice(allocator, italicBuf);
    }
    if (cell.style.underline) {
        const underlineBuf = style.underline();
        try buf.appendSlice(allocator, underlineBuf);
    }
    if (cell.style.blinking) {
        const blinkingBuf = style.blink();
        try buf.appendSlice(allocator, blinkingBuf);
    }
    if (cell.style.reverse) {
        const reverseBuf = style.reverse();
        try buf.appendSlice(allocator, reverseBuf);
    }
    if (cell.style.hidden) {
        const hiddenBuf = style.hidden();
        try buf.appendSlice(allocator, hiddenBuf);
    }
    if (cell.style.strikethrough) {
        const strikethroughBuf = style.strikethrough();
        try buf.appendSlice(allocator, strikethroughBuf);
    }

    try buf.append(allocator, cell.byte);

    return buf.toOwnedSlice(allocator);
}

// ==================== 测试 ====================

test "translate - 仅光标移动" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[1;1HA", result);
}

test "translate - 带粗体样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 5,
        .column = 10,
        .byte = 65,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[6;11H\x1b[1mA", result);
}

test "translate - 带斜体样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 2,
        .column = 3,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = true,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[3;4H\x1b[3mA", result);
}

test "translate - 带下划线样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 1,
        .column = 1,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = true,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[2;2H\x1b[4mA", result);
}

test "translate - 带闪烁样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = true,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[1;1H\x1b[5mA", result);
}

test "translate - 带反色样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 10,
        .column = 20,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = true,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[11;21H\x1b[7mA", result);
}

test "translate - 带隐藏样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 3,
        .column = 5,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = true,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[4;6H\x1b[8mA", result);
}

test "translate - 带删除线样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 7,
        .column = 8,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = true,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[8;9H\x1b[9mA", result);
}

test "translate - 带暗淡样式" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 4,
        .column = 6,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = true,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[5;7H\x1b[2mA", result);
}

test "translate - 带多个样式组合" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = true,
            .underline = true,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[1;1H\x1b[1m\x1b[3m\x1b[4mA", result);
}

test "translate - 带所有样式组合" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 2,
        .column = 3,
        .byte = 65,
        .style = Style{
            .bold = true,
            .dim = true,
            .italic = true,
            .underline = true,
            .blinking = true,
            .reverse = true,
            .hidden = true,
            .strikethrough = true,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    const expected = "\x1b[3;4H\x1b[1m\x1b[2m\x1b[3m\x1b[4m\x1b[5m\x1b[7m\x1b[8m\x1b[9mA";
    try testing.expectEqualStrings(expected, result);
}

test "translate - 大行列值" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 100,
        .column = 200,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[101;201HA", result);
}

test "translate - 不同字节值影响输出" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell1 = Cell{
        .line = 5,
        .column = 10,
        .byte = 65,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const cell2 = Cell{
        .line = 5,
        .column = 10,
        .byte = 90,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result1 = try translate(allocator, cell1);
    defer allocator.free(result1);

    const result2 = try translate(allocator, cell2);
    defer allocator.free(result2);

    try testing.expectEqualStrings("\x1b[6;11H\x1b[1mA", result1);
    try testing.expectEqualStrings("\x1b[6;11H\x1b[1mZ", result2);
}

test "translate - 样式顺序" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 1,
        .column = 2,
        .byte = 65,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = true,
            .hidden = true,
            .strikethrough = true,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[2;3H\x1b[7m\x1b[8m\x1b[9mA", result);
}

test "translate - 特殊字符字节" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell1 = Cell{
        .line = 0,
        .column = 0,
        .byte = 32,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const cell2 = Cell{
        .line = 0,
        .column = 0,
        .byte = 48,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const cell3 = Cell{
        .line = 0,
        .column = 0,
        .byte = 122,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result1 = try translate(allocator, cell1);
    defer allocator.free(result1);

    const result2 = try translate(allocator, cell2);
    defer allocator.free(result2);

    const result3 = try translate(allocator, cell3);
    defer allocator.free(result3);

    try testing.expectEqualStrings("\x1b[1;1H ", result1);
    try testing.expectEqualStrings("\x1b[1;1H0", result2);
    try testing.expectEqualStrings("\x1b[1;1Hz", result3);
}

test "translate - 空字节" {
    const testing = std.testing;
    const allocator = testing.allocator;

    const cell = Cell{
        .line = 0,
        .column = 0,
        .byte = 0,
        .style = Style{
            .bold = false,
            .dim = false,
            .italic = false,
            .underline = false,
            .blinking = false,
            .reverse = false,
            .hidden = false,
            .strikethrough = false,


        },
    };

    const result = try translate(allocator, cell);
    defer allocator.free(result);

    try testing.expectEqualStrings("\x1b[1;1H\x00", result);
}

