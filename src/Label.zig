const std = @import("std");
const Allocator = std.mem.Allocator;
const Cell = @import("Cell.zig");
const Widget = @import("Widget.zig");
const Label = @This();

x: u16,
y: u16,
text: []const u8,

pub fn init(x: u16, y: u16, text: []const u8) Label {
    return .{
        .text = text,
        .x = x,
        .y = y,
    };
}

pub fn setText(self: *Label, text: []const u8) void {
    self.text = text;
}

pub fn widget(self: *const Label) Widget {
    return .{
        .widget_ptr = self,
        .getCells_ptr = typeErasedGetCells,
    };
}

fn typeErasedGetCells(widget_ptr: *anyopaque) []Cell {
    const self: *const Label = @ptrCast(@alignCast(widget_ptr));
    return self.getCells();
}

pub fn getCells(self: *const Label, allocator: Allocator) ![]Cell {
    const cells = try allocator.alloc(Cell, self.text.len);

    for (self.text, 0..) |value, i| {
        cells[i] = Cell.init(@intCast(self.x + i), self.y, value);
    }

    return cells;
}
