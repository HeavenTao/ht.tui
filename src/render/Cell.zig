const std = @import("std");
const Style = @import("Style.zig");
const Cell = @This();

line: u16,
column: u16,
byte: u8,
style: Style,

pub fn compare(self: Cell, other: Cell) bool {
    if (self.line != other.line) {
        return false;
    }
    if (self.column != other.column) {
        return false;
    }
    if (self.byte != other.byte) {
        return false;
    }
    if (!self.style.compare(other.style)) {
        return false;
    }

    return true;
}

test "compare" {
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

    const cell1 = Cell{
        .line = 10,
        .column = 20,
        .byte = 65,
        .style = style1,
    };

    const cell2 = Cell{
        .line = 10,
        .column = 20,
        .byte = 65,
        .style = style1,
    };

    try std.testing.expect(cell1.compare(cell2));

    const cell3 = Cell{
        .line = 15,
        .column = 20,
        .byte = 65,
        .style = style1,
    };

    try std.testing.expect(!cell1.compare(cell3));

    const cell4 = Cell{
        .line = 10,
        .column = 25,
        .byte = 65,
        .style = style1,
    };

    try std.testing.expect(!cell1.compare(cell4));

    const cell5 = Cell{
        .line = 10,
        .column = 20,
        .byte = 66,
        .style = style1,
    };

    try std.testing.expect(!cell1.compare(cell5));

    const style2 = Style{
        .bold = false,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    const cell6 = Cell{
        .line = 10,
        .column = 20,
        .byte = 65,
        .style = style2,
    };

    try std.testing.expect(!cell1.compare(cell6));

    const style3 = Style{
        .bold = true,
        .dim = true,
        .italic = false,
        .underline = true,
        .blinking = false,
        .reverse = true,
        .hidden = false,
        .strikethrough = true,
    };

    const cell7 = Cell{
        .line = 5,
        .column = 8,
        .byte = 97,
        .style = style3,
    };

    const cell8 = Cell{
        .line = 5,
        .column = 8,
        .byte = 97,
        .style = style3,
    };

    try std.testing.expect(cell7.compare(cell8));

    const cell9 = Cell{
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

    const cell10 = Cell{
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

    try std.testing.expect(cell9.compare(cell10));

    const cell11 = Cell{
        .line = 65535,
        .column = 65535,
        .byte = 255,
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

    const cell12 = Cell{
        .line = 65535,
        .column = 65535,
        .byte = 255,
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

    try std.testing.expect(cell11.compare(cell12));

    const cell13 = Cell{
        .line = 100,
        .column = 200,
        .byte = 128,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = true,
            .underline = false,
            .blinking = false,
            .reverse = true,
            .hidden = false,
            .strikethrough = true,
        },
    };

    const cell14 = Cell{
        .line = 100,
        .column = 200,
        .byte = 128,
        .style = Style{
            .bold = true,
            .dim = false,
            .italic = true,
            .underline = false,
            .blinking = true,
            .reverse = true,
            .hidden = false,
            .strikethrough = true,
        },
    };

    try std.testing.expect(!cell13.compare(cell14));

    const cell15 = Cell{
        .line = 50,
        .column = 75,
        .byte = 90,
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

    try std.testing.expect(!cell1.compare(cell15));
}
