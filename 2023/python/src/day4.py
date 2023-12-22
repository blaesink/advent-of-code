import typer
import re


def generate_matches_from_line(line: str) -> set[int]:
    input_start = line.find(":") + 2

    middle = line.find("|")

    raw_left_side = line[input_start : middle - 1]
    raw_right_side = line[middle + 2 :]

    winning_numbers = re.findall(r"\d+", raw_left_side)
    your_numbers = re.findall(r"\d+", raw_right_side)

    return set(winning_numbers) & set(your_numbers)


def part_one(lines: list[str]) -> int:
    result = 0

    for line in lines:
        matches = generate_matches_from_line(line)
        if matches:
            points = 2 ** (len(matches) - 1)
        else:
            points = 0

        result += points

    return result


def part_two(lines: list[str]) -> int:
    num_scratchcards: int = 0

    # TODO: this should just be the precomputed set of won cards.
    won_cards: list[str] = []

    for idx, line in enumerate(lines):
        matches = generate_matches_from_line(line)
        if len(matches) > 0:
            num_scratchcards += 1

            if idx + len(matches) > len(lines):
                won_cards += lines[idx:]
            else:
                won_cards += lines[idx : idx + len(matches)]

    for idx, card in enumerate(won_cards):
        matches = generate_matches_from_line(card)
        if len(matches) > 0:
            num_scratchcards += 1

            if idx + len(matches) > len(lines):
                won_cards += lines[idx:]
            else:
                won_cards += lines[idx : idx + len(matches)]

    return num_scratchcards


def main(data_path: str):
    with open(data_path, "r") as f:
        data = [line.strip() for line in f.readlines()]

    print("Part one:", part_one(data))
    # print("Part two:", part_two(data))


if __name__ == "__main__":
    typer.run(main)


class Test:
    @staticmethod
    def test_part_one():
        input = """Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
            Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
            Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
            Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
            Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
            Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

        lines = list(map(str.strip, input.split("\n")))

        assert part_one(lines) == 13

    @staticmethod
    def test_part_two():
        input = """Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
            Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
            Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
            Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
            Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
            Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

        lines = list(map(str.strip, input.split("\n")))

        assert part_two(lines) == 30
