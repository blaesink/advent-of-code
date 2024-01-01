import re


def read_file_to_lines(data_path: str) -> list[str]:
    with open(data_path, "r") as f:
        return f.readlines()


def get_ints_from_line(line: str) -> tuple[int, ...]:
    """Get all numbers from a string using regex."""
    return tuple(map(int, re.findall(r"\d+", line)))
