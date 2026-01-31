const Cell = @import("Cell.zig");
const Style = @import("Style.zig");
const std = @import("std");
const posix = std.posix;
const Allocator = std.mem.Allocator;
const Screen = @This();

rows: u16,
cols: u16,
cells: []Cell,

pub fn diff(self: Screen, other: Screen, allocator: Allocator) ![]Cell {
    if (self.rows != other.rows or self.cols != other.cols or self.cells.len != other.cells.len) {
        const cells = try allocator.alloc(Cell, self.cells.len);
        @memcpy(cells, self.cells);
        return cells;
    }

    var diffCells: std.ArrayList(Cell) = .empty;
    defer diffCells.deinit(allocator);
    for (0..self.cells.len) |i| {
        if (!self.cells[i].compare(other.cells[i])) {
            try diffCells.append(allocator, self.cells[i]);
        }
    }
    const cells = try allocator.alloc(Cell, diffCells.items.len);
    @memcpy(cells, diffCells.items);
    return cells;
}

fn makeRaw(fd: posix.fd_t) !posix.termios {
    const state = try posix.tcgetattr(fd);
    var raw = state;
    // see termios(3)
    raw.iflag.IGNBRK = false;
    raw.iflag.BRKINT = false;
    raw.iflag.PARMRK = false;
    raw.iflag.ISTRIP = false;
    raw.iflag.INLCR = false;
    raw.iflag.IGNCR = false;
    raw.iflag.ICRNL = false;
    raw.iflag.IXON = false;

    raw.oflag.OPOST = false;

    raw.lflag.ECHO = false;
    raw.lflag.ECHONL = false;
    raw.lflag.ICANON = false;
    raw.lflag.ISIG = true;
    raw.lflag.IEXTEN = false;

    raw.cflag.CSIZE = .CS8;
    raw.cflag.PARENB = false;

    raw.cc[@intFromEnum(posix.V.MIN)] = 1;
    raw.cc[@intFromEnum(posix.V.TIME)] = 0;
    try posix.tcsetattr(fd, .FLUSH, raw);

    return state;
}

test "diff" {
    const testing = std.testing;

    const allocator = std.testing.allocator;

    const style1 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    const style2 = Style{
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
    cells1[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = style1,
    };
    cells1[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };
    cells1[2] = Cell{
        .line = 1,
        .column = 0,
        .byte = 67,
        .style = style1,
    };
    cells1[3] = Cell{
        .line = 1,
        .column = 1,
        .byte = 68,
        .style = style2,
    };

    var cells2 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells2);
    cells2[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = style1,
    };
    cells2[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };
    cells2[2] = Cell{
        .line = 1,
        .column = 0,
        .byte = 67,
        .style = style1,
    };
    cells2[3] = Cell{
        .line = 1,
        .column = 1,
        .byte = 68,
        .style = style2,
    };

    const screen1 = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells1,
    };

    const screen2 = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells2,
    };

    const diff1 = try screen1.diff(screen2, allocator);
    defer allocator.free(diff1);
    try testing.expect(diff1.len == 0);

    var cells3 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells3);
    cells3[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = style1,
    };
    cells3[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };
    cells3[2] = Cell{
        .line = 1,
        .column = 0,
        .byte = 67,
        .style = style1,
    };
    cells3[3] = Cell{
        .line = 1,
        .column = 1,
        .byte = 88,
        .style = style2,
    };

    const screen3 = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells3,
    };

    const diff2 = try screen1.diff(screen3, allocator);
    defer allocator.free(diff2);
    try testing.expect(diff2.len == 1);
    try testing.expect(diff2[0].byte == 68);
    try testing.expect(diff2[0].line == 1);
    try testing.expect(diff2[0].column == 1);

    var cells4 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells4);
    cells4[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 90,
        .style = style2,
    };
    cells4[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };
    cells4[2] = Cell{
        .line = 1,
        .column = 0,
        .byte = 67,
        .style = style1,
    };
    cells4[3] = Cell{
        .line = 1,
        .column = 1,
        .byte = 88,
        .style = style2,
    };

    const screen4 = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells4,
    };

    const diff3 = try screen1.diff(screen4, allocator);
    defer allocator.free(diff3);
    try testing.expect(diff3.len == 2);
    try testing.expect(diff3[0].byte == 65);
    try testing.expect(diff3[1].byte == 68);

    var cells5 = try allocator.alloc(Cell, 9);
    defer allocator.free(cells5);
    for (0..9) |i| {
        cells5[i] = Cell{
            .line = @intCast(i / 3),
            .column = @intCast(i % 3),
            .byte = @intCast(65 + @as(u8, @intCast(i))),
            .style = style1,
        };
    }

    const screen5 = Screen{
        .rows = 3,
        .cols = 3,
        .cells = cells5,
    };

    const diff4 = try screen1.diff(screen5, allocator);
    defer allocator.free(diff4);
    try testing.expect(diff4.len == 4);

    var cells6 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells6);
    cells6[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = style1,
    };
    cells6[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };
    cells6[2] = Cell{
        .line = 1,
        .column = 0,
        .byte = 67,
        .style = style1,
    };
    cells6[3] = Cell{
        .line = 1,
        .column = 1,
        .byte = 68,
        .style = style2,
    };

    const screen6 = Screen{
        .rows = 1,
        .cols = 4,
        .cells = cells6,
    };

    const diff5 = try screen1.diff(screen6, allocator);
    defer allocator.free(diff5);
    try testing.expect(diff5.len == 4);

    var cells7 = try allocator.alloc(Cell, 4);
    defer allocator.free(cells7);
    for (0..4) |i| {
        cells7[i] = Cell{
            .line = @intCast(i / 2),
            .column = @intCast(i % 2),
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
    }

    const screen7 = Screen{
        .rows = 2,
        .cols = 2,
        .cells = cells7,
    };

    const diff6 = try screen1.diff(screen7, allocator);
    defer allocator.free(diff6);
    try testing.expect(diff6.len == 4);

    var cells8 = try allocator.alloc(Cell, 2);
    defer allocator.free(cells8);
    cells8[0] = Cell{
        .line = 0,
        .column = 0,
        .byte = 65,
        .style = style1,
    };
    cells8[1] = Cell{
        .line = 0,
        .column = 1,
        .byte = 66,
        .style = style2,
    };

    const screen8 = Screen{
        .rows = 1,
        .cols = 2,
        .cells = cells8,
    };

    const diff7 = try screen1.diff(screen8, allocator);
    defer allocator.free(diff7);
    try testing.expect(diff7.len == 4);
}
