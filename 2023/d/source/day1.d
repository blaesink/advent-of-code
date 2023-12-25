import std.stdio;
import std.ascii : isDigit;
import std.array;
import std.file;

/// Returns all digits in a line.
int[] getDigitsFromLine(string line) {
    int[] digits = [];

    foreach(char c; line) {
        if (isDigit(c)) {
            digits ~= int(c - 48);
        }
    }

    return digits;
}

int partOne(string[] lines) { 
    int sum = 0;

    foreach(string line; lines) {
        int[] digits = getDigitsFromLine(line);

        if (digits.length > 0) {
            // Join together
            uint x = digits[0];
            uint y = digits[$-1];
            uint pow = 10;
            while (y >= pow) {
                pow *= 10;
            }

            sum += x * pow + y;
        }
        
    }

    return sum;
} 

void main() {
    /+
    string[string] word_map = [
        "zero": "0",
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9",
    ];
    +/

    auto file = File("../data/day1.txt");
    auto lines = appender!(string[]);

    foreach(line; file.byLine())
        lines.put(cast(string)(line));
    

    writeln("Part one: ", partOne(lines.data));
}
