# API Health Check Automation

## Overview
Automates basic HTTP health checks and captures responses to disk.

## Problem
Manually checking API availability and responses does not scale.

## Solution
Python performs HTTP requests and validation. Bash orchestrates execution.

## Structure

src/     - Python source  
bash/    - Bash runner scripts  
output/  - Generated output  

## How to Run

```bash
bash bash/run.sh
```