#!/usr/bin/env python3

import re
import sys

def main():
    solution = sum(map(calibration_value, sys.stdin))
    print(solution)

def calibration_value(string: str) -> int:
    digits = re.findall(R'[0-9]', string)
    digit_first, digit_last = digits[0], digits[-1]
    return int(digit_first + digit_last)

if __name__ == '__main__':
    main()
