#!/usr/bin/env python3

from dataclasses import dataclass
from functools import reduce
import operator
import re
import sys

COLORS = ['red', 'green', 'blue']

Subset = list[int]

@dataclass
class Game:
    id: int
    subsets: list[Subset]

def main():
    games = map(parse_game, sys.stdin)
    subsets = map(operator.attrgetter('subsets'), games)
    min_subsets = map(subset_min, subsets)
    solution = sum(map(subset_power, min_subsets))
    print(solution)

def parse_game(string: str) -> Game:
    match = re.match(R'Game (?P<id>[0-9]+): (?P<subsets>.*)', string)
    assert match is not None, string
    id = int(match.group('id'))
    subsets = match.group('subsets').split(';')
    subsets = list(map(parse_subset, subsets))
    return Game(id, subsets)

def parse_subset(string: str) -> Subset:
    subset = [0] * len(COLORS)
    for match in re.finditer(f'(?P<count>[0-9]+) (?P<color>{"|".join(COLORS)})', string):
        count = int(match.group('count'))
        color_index = COLORS.index(match.group('color'))
        subset[color_index] += count
    return subset

def subset_min(subsets: list[Subset]) -> Subset:
    subset_min = [0] * len(COLORS)
    for subset_cur in subsets:
        subset_min = list(map(max, subset_min, subset_cur))
    return subset_min

def subset_power(subset: Subset) -> int:
    return reduce(operator.mul, subset)

if __name__ == '__main__':
    main()
