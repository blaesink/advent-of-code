from functools import reduce
import typer
import utils


def calculate_outcomes(time: int, record: int) -> int:
    count: int = 0

    for i in range(time + 1):
        distance: int = i * (time - i)

        if distance > record:
            count += 1

    return count


def main(data_path: str):
    lines = utils.read_file_to_lines(data_path)

    # times, distances = list(map(utils.get_ints_from_line, lines))
    # rounds = list(zip(times, distances))

    # Same as above but just a gross one-liner.
    rounds = list(zip(*map(utils.get_ints_from_line, lines)))

    part_one = reduce(lambda x, y: x * y, map(lambda x: calculate_outcomes(*x), rounds))
    print("Part one:", part_one)


if __name__ == "__main__":
    typer.run(main)


def test_calculate_outcomes():
    assert calculate_outcomes(7, 9) == 4
    assert calculate_outcomes(15, 40) == 8
    assert calculate_outcomes(30, 200) == 9
