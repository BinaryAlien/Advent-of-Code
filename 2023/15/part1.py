#!/usr/bin/env python3

import sys

def main():
    initialization_sequence = sys.stdin.readline().strip()
    steps = initialization_sequence.split(',')
    solution = sum(map(hash, steps))
    print(solution)

def hash(string: str) -> int:
    value = 0
    for char in string:
        value += ord(char)
        value *= 17
        value %= 256
    return value

if __name__ == '__main__':
    main()
