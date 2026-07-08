from pathlib import Path


REQUIRED_FILES = [
    "dbt_project.yml",
    "packages.yml",
]

REQUIRED_DIRS = [
    "models",
    "seeds",
    "macros",
]

EXPECTED_MODEL_SUBDIRS = [
    "models/staging",
    "models/marts",
]


def check_exists(path: Path, label: str) -> bool:
    """Check whether a required project path exists."""
    if path.exists():
        print(f"[PASS] {label}: {path}")
        return True

    print(f"[FAIL] {label}: {path} is missing")
    return False


def count_files(base_dir: Path, pattern: str) -> int:
    """Count files matching a pattern under a directory."""
    return len(list(base_dir.rglob(pattern))) if base_dir.exists() else 0


def main() -> None:
    project_root = Path.cwd()
    print(f"Validating dbt project at: {project_root}\n")

    checks = []

    for file_name in REQUIRED_FILES:
        checks.append(check_exists(project_root / file_name, "Required file"))

    for dir_name in REQUIRED_DIRS:
        checks.append(check_exists(project_root / dir_name, "Required directory"))

    for dir_name in EXPECTED_MODEL_SUBDIRS:
        checks.append(check_exists(project_root / dir_name, "Expected model layer"))

    sql_model_count = count_files(project_root / "models", "*.sql")
    yml_file_count = count_files(project_root / "models", "*.yml")
    seed_file_count = count_files(project_root / "seeds", "*.csv")

    print("\nProject summary:")
    print(f"- SQL model files: {sql_model_count}")
    print(f"- YAML schema/config files: {yml_file_count}")
    print(f"- Seed CSV files: {seed_file_count}")

    if sql_model_count == 0:
        print("[FAIL] No dbt SQL models found.")
        checks.append(False)

    if yml_file_count == 0:
        print("[WARN] No YAML schema/config files found under models/.")

    if seed_file_count == 0:
        print("[WARN] No seed CSV files found under seeds/.")

    print("\nValidation result:")
    if all(checks):
        print("Project structure looks valid for a dbt analytics engineering showcase.")
    else:
        print("Project structure has missing required components.")


if __name__ == "__main__":
    main()