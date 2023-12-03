#!/usr/bin/env python3

import re
import sys

DIGIT_WORDS = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

def main():
    solution = sum(map(calibration_value, sys.stdin))
    print(solution)

def calibration_value(string: str) -> int:
    digits = re.findall(f'(?=([0-9]|{"|".join(DIGIT_WORDS)}))', string)
    digit_first, digit_last = map(parse_digit, (digits[0], digits[-1]))
    return digit_first * 10 + digit_last

def parse_digit(digit: str) -> int:
    try:
        return 1 + DIGIT_WORDS.index(digit)
    except ValueError:
        return int(digit)

if __name__ == '__main__':
    main()
