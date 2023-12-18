import typer

RED_LIMIT = 12
GREEN_LIMIT = 13
BLUE_LIMIT = 14


def format_line(line: str) -> list[dict[str, int]]:
    search_slice = line[line.find(":") + 1 :]

    rounds = search_slice.split(";")

    pick_list = []

    for round in rounds:
        picks = {}

        for pick in round.split(","):
            num, color = pick.lstrip().split(" ")
            picks[color] = int(num)

        pick_list.append(picks)

    return pick_list


def is_valid(red: int = 0, green: int = 0, blue: int = 0) -> bool:
    return red <= RED_LIMIT and green <= GREEN_LIMIT and blue <= BLUE_LIMIT


def part_one(lines: list[str]) -> int:
    sum = 0

    for i, line in enumerate(lines, start=1):
        outcome = format_line(line)

        if all(is_valid(**o) for o in outcome):
            sum += i

    return sum


def main(data_path: str) -> None:
    with open(data_path, "r") as f:
        data = [line.strip() for line in f.readlines()]

    print("Part one:", part_one(data))


if __name__ == "__main__":
    typer.run(main)


class Test:
    @staticmethod
    def test_parsing():
        input = [
            "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
            "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        ]

        actual = list(map(format_line, input))

        expected = [(5, 4, 9), (1, 6, 6)]

        assert actual == expected

    @staticmethod
    def test_part_one():
        input = [
            "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
            "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
            "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
            "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
            "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
        ]

        assert part_one(input) == 8
