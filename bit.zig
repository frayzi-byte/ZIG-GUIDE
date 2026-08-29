const std = @import("std");

pub fn main() void {
    const name = "Petya";

    std.debug.print("RS: {d}", .{ name[0] });
}