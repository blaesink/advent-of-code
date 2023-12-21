import math
import re

import typer


def generate_char_map(lines: list[str]) -> dict:
    line_length = len(lines[0])

    chars = {
        (row, col): []
        for row in range(line_length)
        for col in range(line_length)
        if lines[row][col] not in "01234566789."
    }

    for row_idx, row in enumerate(lines):
        for digit in re.finditer(r"\d+", row):
            edge = {
                (row, col)
                for row in (row_idx - 1, row_idx, row_idx + 1)
                for col in range(digit.start() - 1, digit.end() + 1)
            }

            for o in edge & chars.keys():
                chars[o].append(int(digit.group()))

    return chars


def part_one(lines: list[str]) -> int:
    char_map = generate_char_map(lines)

    return sum(sum(p) for p in char_map.values())


def part_two(lines: list[str]) -> int:
    char_map = generate_char_map(lines)

    return sum(math.prod(p) for p in char_map.values() if len(p) == 2)  # type: ignore


def main(data_path: str):
    with open(data_path, "r") as f:
        data = [line.strip() for line in f.readlines()]

    print("Part one:", part_one(data))
    print("Part two:", part_two(data))


if __name__ == "__main__":
    typer.run(main)


class Test:
    @staticmethod
    def test_part_one():
        input = """467..114..
            ...*......
            ..35..633.
            ......#...
            617*......
            .....+.58.
            ..592.....
            ......755.
            ...$.*....
            .664.598.. 
        """

        lines = list(map(str.strip, input.split("\n")))

        assert part_one(lines) == 4361
