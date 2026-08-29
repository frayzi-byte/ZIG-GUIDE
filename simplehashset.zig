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

const SimpleHashSet = struct {
    buckets: [8]?[]const u8,

    pub fn init() SimpleSet {
        var set: SimpleSet = undefined;
        // Зануляем всю память под бакеты одной командой
        @memset(std.mem.asBytes(&set.buckets), 0);
        return set;
    }
    
    pub fn add(self: *SimpleHashSet, key: []const u8) void {
        const h = hash(key);

        const mask = self.buckets.len - 1;
        const index = h & mask;

        self.buckets[index] = key;
    }

    pub fn contains(self: SimpleHashSet, key: []const u8) bool {
        const h = hash(key);
        const mask = self.buckets.len - 1;
        const index = h & mask;

        if (self.buckets[index]) |stored_key| {
            return std.mem.eql(u8, stored_key, key);
        }

        return false;
    }
};

pub fn main() void {
    var set = SimpleHashSet{};

    set.add("Petya");
    set.add("Vasya");
    set.add("Kolya")

    std.debug.print("Petya in set: {}\n", .{set.contains("Petya")});
    std.debug.print("Vasya in set: {}\n", .{set.contains("Vasya")});
    std.debug.print("Kolya in set: {}\n", .{set.contains("Kolya")});
}