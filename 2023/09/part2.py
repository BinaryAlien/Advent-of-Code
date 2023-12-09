#!/usr/bin/env python3

import operator
import sys

Sequence = list[int]

def main():
    dataset = map(parse_sequence, sys.stdin)
    extrapolated_values = map(extrapolate, dataset)
    solution = sum(extrapolated_values)
    print(solution)

def parse_sequence(string: str) -> Sequence:
    numbers = string.split()
    return list(map(int, numbers))

def extrapolate(history: Sequence) -> int:
    history = list(reversed(history))
    sequences = diff_sequences(history)
    sequences[0].append(0)
    for current, previous in zip(sequences[1:], sequences[:-1]):
        current.append(previous[-1] + current[-1])
    return sequences[-1][-1]

def diff_sequences(input_sequence: Sequence) -> list[Sequence]:
    sequences = [input_sequence]
    while not all(value == 0 for value in sequences[-1]):
        sequences.append(sequence_diffs(sequences[-1]))
    return list(reversed(sequences))

def sequence_diffs(sequence: Sequence) -> Sequence:
    return list(map(operator.sub, sequence[1:], sequence[:-1]))

if __name__ == '__main__':
    main()
