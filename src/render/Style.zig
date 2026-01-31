const std = @import("std");

const Style = @This();

bold: bool,
/// 微弱/暗淡模式
dim: bool,
italic: bool,
underline: bool,
blinking: bool,
reverse: bool,
hidden: bool,
/// 删除线模式
strikethrough: bool,

pub fn compare(self: Style, other: Style) bool {
    if (self.bold != other.bold) {
        return false;
    }
    if (self.dim != other.dim) {
        return false;
    }
    if (self.italic != other.italic) {
        return false;
    }
    if (self.underline != other.underline) {
        return false;
    }
    if (self.blinking != other.blinking) {
        return false;
    }
    if (self.reverse != other.reverse) {
        return false;
    }
    if (self.hidden != other.hidden) {
        return false;
    }
    if (self.strikethrough != other.strikethrough) {
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

    const style2 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(style1.compare(style2));

    const style3 = Style{
        .bold = false,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style3));

    const style4 = Style{
        .bold = true,
        .dim = false,
        .italic = false,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style4));

    const style5 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = true,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style5));

    const style6 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style6));

    const style7 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = true,
        .hidden = true,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style7));

    const style8 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    try std.testing.expect(!style1.compare(style8));

    const style9 = Style{
        .bold = true,
        .dim = false,
        .italic = true,
        .underline = false,
        .blinking = true,
        .reverse = false,
        .hidden = true,
        .strikethrough = true,
    };

    try std.testing.expect(!style1.compare(style9));

    const style10 = Style{
        .bold = false,
        .dim = true,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    const style11 = Style{
        .bold = false,
        .dim = true,
        .italic = false,
        .underline = false,
        .blinking = false,
        .reverse = false,
        .hidden = false,
        .strikethrough = false,
    };

    try std.testing.expect(style10.compare(style11));

    const style12 = Style{
        .bold = true,
        .dim = true,
        .italic = true,
        .underline = true,
        .blinking = true,
        .reverse = true,
        .hidden = true,
        .strikethrough = true,
    };

    const style13 = Style{
        .bold = true,
        .dim = true,
        .italic = true,
        .underline = true,
        .blinking = true,
        .reverse = true,
        .hidden = true,
        .strikethrough = true,
    };

    try std.testing.expect(style12.compare(style13));
}
