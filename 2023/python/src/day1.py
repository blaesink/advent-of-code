import typer
from loguru import logger

WORD_MAP = {
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
}


def get_digits(line: str) -> list[str]:
    return [x for x in line if x.isnumeric()]


def get_digits_with_index(line: str) -> list[tuple[str, int]]:
    return [(x, i) for i, x in enumerate(line) if x.isnumeric()]


def part_one(lines: list[str]) -> int:
    sum: int = 0

    for line in lines:
        digits = get_digits(line)

        num = int("".join([digits[0], digits[-1]]))
        sum += num

    return sum


def part_two(lines: list[str]) -> int:
    sum: int = 0

    for line in lines:
        # Go through and get the indices of each word and digit
        found_words = []

        for k, v in WORD_MAP.items():
            word_index = line.find(k)

            if word_index >= 0:
                found_words.append((v, word_index + len(k) - 1))

        digits = get_digits_with_index(line)

        # min and max here are on the "index" found.
        # This is just to avoid sorting.
        first = min(found_words + digits, key=lambda x: x[1])[0]
        second = max(found_words + digits, key=lambda x: x[1])[0]

        logger.debug(f"{first + second}")

        calibration_value = int(first + second)

        sum += calibration_value

    return sum


def main(data_path: str):
    with open(data_path, "r") as f:
        data_lines = [x.strip() for x in f.readlines()]

    print("== Part One ==")
    print(part_one(data_lines))

    print("== Part Two ==")
    print(part_two(data_lines))


if __name__ == "__main__":
    typer.run(main)


class Tests:
    @staticmethod
    def test_day_two():
        assert 281 == part_two(
            [
                "two1nine",
                "eightwothree",
                "abcone2threexyz",
                "xtwone3four",
                "4nineeightseven2",
                "zoneight234",
                "7pqrstsixteen",
            ]
        )

        assert part_two(["threeight1", "sevenine8", "zoneight234"]) == 123
