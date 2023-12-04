#!/usr/bin/env python3

from dataclasses import dataclass
import re
import sys

@dataclass
class Card:
    numbers_winning: set[int]
    numbers_have: set[int]

def main():
    cards = map(parse_card, sys.stdin)
    solution = sum(map(card_value, cards))
    print(solution)

def parse_card(string: str) -> Card:
    match = re.match(R'Card\s*\d+:(?P<numbers_winning>(?:\s*\d+)+)\s*\|(?P<numbers_have>(?:\s*\d+)+)', string)
    assert match is not None, string
    numbers_winning = parse_numbers(match.group('numbers_winning'))
    numbers_have = parse_numbers(match.group('numbers_have'))
    return Card(numbers_winning, numbers_have)

def parse_numbers(string: str) -> set[int]:
    numbers = filter(None, string.split())
    return set(map(int, numbers))

def card_value(card: Card) -> int:
    match_count = len(card.numbers_have.intersection(card.numbers_winning))
    if match_count == 0:
        return 0
    return 2 ** (match_count - 1)

if __name__ == '__main__':
    main()
