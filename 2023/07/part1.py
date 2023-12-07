#!/usr/bin/env python3

from collections import Counter
from collections.abc import Iterable
from dataclasses import dataclass
from enum import IntEnum
from functools import cmp_to_key
import operator
import sys

HAND_SIZE = 5
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

Card = str
Hand = list[Card]

@dataclass
class Move:
    hand: Hand
    bid_amount: int

class HandType(IntEnum):
    HIGH_CARD = 0
    ONE_PAIR = 1
    TWO_PAIR = 2
    THREE_OF_A_KIND = 3
    FULL_HOUSE = 4
    FOUR_OF_A_KIND = 5
    FIVE_OF_A_KIND = 6

def main():
    moves = map(parse_move, sys.stdin)
    solution = total_winnings(moves)
    print(solution)

def parse_move(string: str) -> Move:
    hand, bid_amount = string.split(maxsplit=2)
    return Move(list(hand), int(bid_amount))

def total_winnings(moves: Iterable[Move]) -> int:
    moves_sorted = sorted(moves, key=cmp_to_key(move_compare))
    bid_amounts = map(lambda move: move.bid_amount, moves_sorted)
    hand_ranks = range(1, len(moves_sorted) + 1)
    return sum(map(operator.mul, bid_amounts, hand_ranks))

def move_compare(lhs: Move, rhs: Move) -> int:
    return hand_compare(lhs.hand, rhs.hand)

def hand_compare(lhs: Hand, rhs: Hand) -> int:
    order = hand_strength(lhs) - hand_strength(rhs)
    card_index = 0
    while order == 0 and card_index < HAND_SIZE:
        order = card_compare(lhs[card_index], rhs[card_index])
        card_index += 1
    return order

def hand_strength(hand: Hand) -> int:
    return hand_type(hand)

def hand_type(hand: Hand) -> HandType:
    card_counts = Counter(hand)
    count_occurrences = Counter(card_counts.values())
    if count_occurrences[5] == 1:
        return HandType.FIVE_OF_A_KIND
    elif count_occurrences[4] == 1:
        return HandType.FOUR_OF_A_KIND
    elif count_occurrences[3] == 1:
        return HandType.FULL_HOUSE if count_occurrences[2] == 1 else HandType.THREE_OF_A_KIND
    elif count_occurrences[2] == 2:
        return HandType.TWO_PAIR
    elif count_occurrences[2] == 1:
        return HandType.ONE_PAIR
    else:
        return HandType.HIGH_CARD

def card_compare(lhs: Card, rhs: Card) -> int:
    return card_strength(lhs) - card_strength(rhs)

def card_strength(card: Card) -> int:
    return CARDS.index(card)

if __name__ == '__main__':
    main()
