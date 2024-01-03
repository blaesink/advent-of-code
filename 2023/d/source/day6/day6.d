import std.stdio;
import std.regex;
import std.conv;
import std.range : zip;
import unit_threaded;

int calculateWinning(int time, int record) {
    int count;

    foreach (i; 0..time + 1) {
        auto distance = i * (time - i);

        if (distance > record)
            count++;
    }
    return count;
}

unittest {

    (calculateWinning([7, 9])).should() == 4;
    (calculateWinning([15, 40])).should() == 8;
    (calculateWinning([30, 200])).should() == 9;
}


void main() {
    const auto r = regex(`\d+`);

    auto file = File("../data/day6.txt");
    string[] lines;

    foreach (line; file.byLine()) {
        lines ~= line.idup();
    }

    int[] times;
    int[] distances;

    foreach (match; lines[0].matchAll(r)) 
        times ~= to!int(match.front);
    
    foreach (match; lines[1].matchAll(r)) 
        distances ~= to!int(match.front);
    
    // A bunch of tuples.
    // First element is how long the race is,
    // Second element is the distance to beat.
    auto rounds = zip(times, distances);
    int part_one = 1;

    foreach (round; rounds)
        part_one *= calculateWinning(round[0], round[1]);


    writefln("Part one: %d", part_one);
}

