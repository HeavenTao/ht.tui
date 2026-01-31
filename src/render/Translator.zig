const Cell = @import("Cell.zig");
const Translator = @This();

pub fn translate(self: Translator, cell: Cell) ![]u8 {
    _ = self;
    _ = cell;
    //需要ANSII辅助完成
    return null;
}
