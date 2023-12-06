#!/usr/bin/env python3

from functools import reduce
import math
import operator
import re
import sys

def main():
    times, distances = map(parse_numbers, sys.stdin)
    beat_counts = map(beat_count, times, distances)
    solution = reduce(operator.mul, beat_counts)
    print(solution)

def parse_numbers(string: str) -> list[int]:
    numbers = re.findall(R'[0-9]+', string)
    return list(map(int, numbers))

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
