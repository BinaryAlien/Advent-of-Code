#!/usr/bin/env python3

from dataclasses import dataclass
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
    games_valid = filter(is_valid_game, games)
    games_valid_ids = map(operator.attrgetter('id'), games_valid)
    solution = sum(games_valid_ids)
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

def is_valid_game(game: Game) -> bool:
    return all(map(is_valid_subset, game.subsets))

def is_valid_subset(subset: Subset) -> bool:
    red, green, blue = subset
    return red <= 12 and green <= 13 and blue <= 14

if __name__ == '__main__':
    main()
