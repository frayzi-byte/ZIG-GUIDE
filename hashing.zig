const std = @import("std");

fn hash(key: []const u8) usize {
    var h: usize = 14695981039346656037;
    const prime: usize = 1099511628211;

    for (key) |byte| {
        h ^= byte;
        h = h *% prime;
    }
    
    return h;
}

pub fn main() void {
    const h1 = hash("Petya");
    const h2 = hash("Vasya");

    std.debug.print("Hash for h1 : {d}\n", .{h1});
    std.debug.print("Hash for h2 : {d}\n", .{h2});
}