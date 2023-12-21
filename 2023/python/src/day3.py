def has_adjacent_symbols(
    line: str, above: str, below: str, start: int, end: int
) -> bool:
    """Return whether this span of characters has surrounding valid symbols.

    Valid symbols are any non alphanumeric character that is not <`.`>
    """

    def _is_valid_symbol(char: str) -> bool:
        if not char.isalnum() and char != ".":
            return True
        return False

    # Directly left or right of the span.
    if _is_valid_symbol(line[start - 1]) or _is_valid_symbol(line[end + 1]):
        return True

    # Directly above or below anything in the span.
    # Add -1 to the start and +1 to the end to check for the corners.
    if any(_is_valid_symbol(c) for c in above[start - 1 : end + 1]) or any(
        _is_valid_symbol(c) for c in below[start - 1 : end + 1]
    ):
        return True

    return False


def part_one(lines: list[str]) -> int:
    result: int = 0

    for row_idx, line in enumerate(lines):
        # Skip rows with nothing
        if not any(x.isdigit() for x in line):
            continue

        # start and end will be reset constantly as we generate "slices".
        # Initially set to the first non symbol.
        start = line.find(next(filter(str.isdigit, line)))
        end: int = start

        # We append to this string until we hit a non-numeric.
        current_num_str: str = line[start]

        # We already have the initial
        for char in line[start + 1 :]:
            if char.isdigit():
                current_num_str += char
                end += 1
            else:
                print(current_num_str)
                if row_idx == 0:
                    if has_adjacent_symbols(
                        line, lines[row_idx - 1], lines[row_idx + 1], start, end
                    ):
                        result += int(current_num_str)
                # skip to the next digit
                start = line.find(next(filter(str.isdigit, line[end:])))
                end = start
                current_num_str = ""

    return result


class Test:
    @staticmethod
    def test_input():
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
