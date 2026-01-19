# API Health Check Automation

## Overview
A small automation that performs an HTTP health check against a URL, measures
response time, and saves results as timestamped JSON files.

## What It Captures
- Timestamp (UTC)
- URL
- Timeout used
- Status code (if available)
- Success/failure boolean
- Latency in milliseconds
- Error message (if the request fails)

## How to Run

From the repository root:

```bash
projects/01_api_health_check/bash/run.sh
```

Check a specific URL:

```bash
projects/01_api_health_check/bash/run.sh https://httpbin.org/status/204
```

Use a custom timeout (seconds):

```bash
projects/01_api_health_check/bash/run.sh https://httpbin.org/delay/3 5
```

## Output

Results are written as timestamped JSON files to:

```bash
projects/01_api_health_check/output/
```

Each execution generates a new file with the following naming pattern:

```bash
healthcheck_<timestamp>.json
```

A representative example output is included in the repository as:

```bash
output/sample_output.json
```
---

## Notes

The script exits with a non-zero status when a health check fails, making it
suitable for use in automation pipelines or CI environments.

Generated output files are ignored by default, except for the included sample.