import git
import os
import typer
import subprocess

THIS_FILE_PATH = os.path.dirname(os.path.abspath(__file__))


def get_git_root(path: str) -> str:
    git_repo = git.Repo(path, search_parent_directories=True)  # type: ignore
    git_root = git_repo.git.rev_parse("--show-toplevel")
    return git_root


def main(day: int) -> None:
    repo_root = get_git_root(__file__)
    file_path = os.path.join(THIS_FILE_PATH, f"day{day}.py")

    if not (os.path.exists(file_path)):
        print("Invalid day!")
        exit(1)

    data_path = os.path.join(repo_root, "data", "2023", f"day{day}.txt")

    if not (os.path.exists(data_path)):
        print("Missing data!")
        exit(1)

    print(f"Running day {day}...")
    subprocess.run(["python3", file_path, data_path])


if __name__ == "__main__":
    typer.run(main)
