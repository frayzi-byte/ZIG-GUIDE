const std = @import("std");

fn hash(key: []const u8) usize {
    var result: usize = 0;
    for (key) |letter| {
        result = result + letter;
    }
    return result;
}

fn isEqual(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) return false;
    for (a, 0..) |letter, i| {
        if (letter != b[i]) return false;
    }
    return true;
}

pub const SimpleSet = struct {
    buckets: [8]?[]const u8,

    pub fn init() SimpleSet {
        var set: SimpleSet = undefined;
        // Зануляем всю память под бакеты одной командой
        @memset(std.mem.asBytes(&set.buckets), 0);
        return set;
    }

    pub fn add(self: *SimpleSet, key: []const u8) void {
        const index = hash(key) & 7;
        self.buckets[index] = key;
    }

    pub fn contains(self: SimpleSet, key: []const u8) bool {
        const index = hash(key) & 7;

        if (self.buckets[index]) |stored_key| {
            return isEqual(key, stored_key); // <-- Добавили ;
        }
        return false;
    }
}; // <-- Добавили ; после структуры

pub fn main() void {
    var set = SimpleSet{};
    set.add("Petya");

    std.debug.print("Petya: {}\n", .{set.contains("Petya")});
    std.debug.print("Vasya: {}\n", .{set.contains("Vasya")});
}