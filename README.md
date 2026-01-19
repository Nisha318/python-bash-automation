# Python + Bash Automation Portfolio

![Python](https://img.shields.io/badge/python-3.10%2B-blue)
![Shell](https://img.shields.io/badge/shell-bash-lightgrey)
![Platform](https://img.shields.io/badge/platform-windows-lightgrey)
![CI](https://github.com/nisha318/python-bash-automation/actions/workflows/ci.yml/badge.svg)


A collection of small, focused automation projects built with Python and Bash.
Each project is designed to be reproducible, easy to run, and clearly documented.


## Environment

- Windows 11
- Python (virtual environments)
- Git Bash
- Visual Studio Code

## Setup

From the repository root:

```bash
python -m venv .venv
source .venv/Scripts/activate
pip install -r requirements.txt

```

## Repository Structure

projects/ - Individual automation projects
scripts/  - Shared shell helpers
docs/     - Notes and design decisions
logs/     - Curated command history

## Projects

- 01_api_health_check
API health check and response capture automation

## Notes

- The virtual environment (.venv/) is intentionally not committed
- Dependencies are tracked in requirements.txt
- Development commands are recorded in logs/commands.md