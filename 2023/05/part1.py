#!/usr/bin/env python3

from dataclasses import dataclass
from functools import reduce
import sys

@dataclass
class Translation:
    source: range
    delta: int

Map = list[Translation]

def main():
    almanac = sys.stdin.read()
    almanac_sections = almanac.split('\n\n')
    seeds = parse_seeds(almanac_sections[0])
    maps = list(map(parse_map, almanac_sections[1:]))
    location_numbers = map(lambda seed: resolve(seed, maps), seeds)
    solution = min(location_numbers)
    print(solution)

def parse_seeds(string: str) -> list[int]:
    seeds = string[len('seeds: '):].split()
    return list(map(int, seeds))

def parse_map(string: str) -> Map:
    lines = string.split('\n')
    translations = lines[1:]
    translations = filter(None, translations)
    return list(map(parse_translation, translations))

def parse_translation(string: str) -> Translation:
    destination, source, length = map(int, string.split(maxsplit=3))
    return Translation(range(source, source + length), destination - source)

def resolve(source: int, maps: list[Map]) -> int:
    return reduce(convert, maps, source)

def convert(source: int, map_: Map) -> int:
    translation = next(filter(lambda translation: source in translation.source, map_), None)
    if translation is None:
        return source
    return source + translation.delta

if __name__ == '__main__':
    main()
