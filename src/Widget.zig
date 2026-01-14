const Cell = @import("Cell.zig");
const Widget = @This();

widget_ptr: *const anyopaque,
getCells_ptr: *const fn (widget: *const anyopaque) []Cell,

pub fn getCells(self: *const Widget) []Cell {
    return self.getCells_ptr(self.widget_ptr);
}
