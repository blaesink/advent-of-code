import std.stdio;
import std.regex;
import std.conv;
import std.algorithm : max;

immutable int RED_LIMIT = 12;
immutable int GREEN_LIMIT = 13;
immutable int BLUE_LIMIT = 14;


void main() {
    auto file = File("../data/day2.txt");
    string[] lines;

    foreach(line; file.byLine()) {
        lines ~= line.idup();
    }


    auto r = regex(`(?P<count>\d+) (?P<color>\w+)`);
    int part1;
    int part2;


    foreach(i, line; lines) {
        int[string] mins = ["red": 0, "blue": 0, "green": 0];

        auto matches = line.matchAll(r);

        foreach(match; matches) {
            int count = to!int(match["count"]);

            mins[match["color"]] = max(mins[match["color"]], count);
        }

        if (mins["red"] <= RED_LIMIT && mins["green"] <= GREEN_LIMIT  && mins["blue"] <= BLUE_LIMIT) {
            part1 += i+1;
        }
        part2 += mins["red"] * mins["blue"] * mins["green"];
    }
    
    writeln("Part one: ", part1);
    writeln("Part two: ", part2);
}
