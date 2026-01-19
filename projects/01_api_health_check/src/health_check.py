import argparse
import json
import time
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Optional

import requests


def check_url(url: str, timeout: float) -> Dict[str, Any]:
    start = time.perf_counter()
    error: Optional[str] = None
    status_code: Optional[int] = None
    ok = False

    try:
        resp = requests.get(url, timeout=timeout)
        status_code = resp.status_code
        ok = 200 <= resp.status_code < 400
    except requests.RequestException as exc:
        error = str(exc)

    elapsed_ms = round((time.perf_counter() - start) * 1000, 2)

    return {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "url": url,
        "timeout_seconds": timeout,
        "ok": ok,
        "status_code": status_code,
        "elapsed_ms": elapsed_ms,
        "error": error,
    }


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Simple API health check that records status and latency."
    )
    parser.add_argument(
        "--url",
        required=True,
        help="URL to check (example: https://httpbin.org/status/200)",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=10.0,
        help="Request timeout in seconds (default: 10)",
    )
    parser.add_argument(
        "--out",
        default="",
        help="Optional output file path. If omitted, prints JSON to stdout.",
    )
    args = parser.parse_args()

    result = check_url(args.url, args.timeout)

    if args.out:
        out_path = Path(args.out)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    else:
        print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
