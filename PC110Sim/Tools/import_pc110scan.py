#!/usr/bin/env python3
"""
Placeholder importer for PC110SCAN logs.
Future use: convert DOS-side hardware dumps into simulator JSON profiles.
"""
from pathlib import Path
import sys

def main() -> int:
    if len(sys.argv) < 2:
        print("usage: import_pc110scan.py LOGFILE")
        return 2
    path = Path(sys.argv[1])
    print(f"TODO: import {path}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
