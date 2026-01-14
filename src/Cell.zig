const Cell = @This();

byte: u8,
x: u16,
y: u16,

pub fn init(x: u16, y: u16, byte: u8) Cell {
    return .{ .byte = byte, .x = x, .y = y };
}
