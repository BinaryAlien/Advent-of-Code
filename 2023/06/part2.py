#!/usr/bin/env python3

import math
import re
import sys

def main():
    time, distance = map(parse_number, sys.stdin)
    solution = beat_count(time, distance)
    print(solution)

def parse_number(string: str) -> int:
    numbers = re.findall(R'[0-9]+', string)
    number = ''.join(numbers)
    return int(number)

def beat_count(time: int, distance: int) -> int:
    # s(t - s) > d => st - s^2 - d > 0
    # a = -1, b = t, c = -d
    delta = time ** 2 - 4 * distance
    assert delta >= 0
    speed_min = math.floor((time - math.sqrt(delta)) / 2 + 1)
    speed_max = math.ceil((time + math.sqrt(delta)) / 2 - 1)
    return speed_max - speed_min + 1

if __name__ == '__main__':
    main()
