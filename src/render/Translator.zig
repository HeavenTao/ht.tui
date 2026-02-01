const Cell = @import("Cell.zig");
const cursor = @import("ansi/cursor.zig");

pub fn translate(cell: Cell) ![]u8 {
    cursor.move(allocator: Allocator, line: u16, col: u16)
}
