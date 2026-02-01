const std = @import("std");
const Allocator = std.mem.Allocator;
const Screen = @import("Screen.zig");
const Render = @This();

prevScreen: Screen,

pub fn render(self: Render, allocator: Allocator, screen: Screen) void {
    const diffCells = screen.diff(self.prevScreen, allocator) catch {
        return null;
    };

    if (diffCells == null) {
        return;
    }

    //将diffCells转义为ASCII码
    //
    //
    //使用Writer输出ASCII码
}
