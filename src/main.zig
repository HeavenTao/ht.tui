const Label = @import("Label.zig");
const std = @import("std");
const posix = std.posix;
const Cell = @import("Cell.zig");
const cursor = @import("cursor.zig");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    const old_termios = try makeRaw(std.fs.File.stdout().handle);
    _ = old_termios;

    const size = getSize(std.fs.File.stdout().handle);
    if (size == null) {
        return;
    }

    var area = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer area.deinit();

    const allocator = area.allocator();

    var curCells: []Cell = undefined;
    curCells = try initCells(allocator, size.?);
    var prevCells = try initCells(allocator, size.?);

    var label = Label.init(0, 0, "hello", allocator);

    var index: usize = 0;
    while (true) {
        index = index + 1;

        const text = try std.fmt.allocPrint(allocator, "this is number:{d}", .{index});

        label.setText(text);

        const cells = try label.getCells();
        defer allocator.free(cells);

        setScreen(curCells, cells, size.?.col);

        const diffCells = try diff(allocator, curCells, prevCells);
        defer allocator.free(diffCells);

        print(diffCells);

        prevCells = curCells;

        std.Thread.sleep(std.time.ns_per_s);
    }
}

fn diff(allocator: Allocator, cur: []Cell, prev: []Cell) ![]Cell {
    var diffCells = try std.ArrayList(Cell).initCapacity(allocator, 100);

    for (cur, 0..) |value, i| {
        if (value.byte != prev[i].byte) {
            try diffCells.appendBounded(cur[i]);
        }
    }

    return diffCells.items;
}

fn setScreen(screen: []Cell, widgets: []Cell, col: u16) void {
    for (widgets) |value| {
        screen[value.y * col + value.x] = value;
    }
}

fn print(cells: []Cell) void {
    for (cells) |value| {
        cursor.moveCursor(value.x, value.y);
        std.debug.print("{}", .{value.byte});
    }
}

fn initCells(allocator: Allocator, size: posix.winsize) ![]Cell {
    var cells: []Cell = try allocator.alloc(Cell, size.col * size.row);

    for (0..size.row) |row| {
        for (0..size.col) |col| {
            cells[row * size.col + col] = Cell.init(@intCast(col), @intCast(row), 32);
        }
    }

    return cells;
}

fn getSize(fd: std.posix.fd_t) ?posix.winsize {
    var winsize: posix.winsize = undefined;
    const err = std.os.linux.ioctl(fd, posix.T.IOCGWINSZ, @intFromPtr(&winsize));
    // const err = posix.system.ioctl(fd, posix.T.IOCGWINSZ, @intFromPtr(&winsize));
    if (posix.errno(err) == .SUCCESS) {
        return winsize;
    } else {
        return null;
    }
}

fn makeRaw(fd: std.posix.fd_t) !std.posix.termios {
    const state = try std.posix.tcgetattr(fd);
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
