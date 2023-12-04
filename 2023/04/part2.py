#!/usr/bin/env python3

from dataclasses import dataclass
import re
import sys

@dataclass
class Card:
    numbers_winning: set[int]
    numbers_have: set[int]

def main():
    cards = list(map(parse_card, sys.stdin))
    histogram = card_histogram(cards)
    solution = sum(histogram)
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

def card_histogram(cards: list[Card]) -> list[int]:
    histogram = [1] * len(cards)
    for card_index, card_count in enumerate(histogram):
        match_count = card_match_count(cards[card_index])
        for offset in range(1, match_count + 1):
            histogram[card_index + offset] += card_count
    return histogram

def card_match_count(card: Card) -> int:
    return len(card.numbers_have.intersection(card.numbers_winning))

if __name__ == '__main__':
    main()
