#!/usr/bin/env python3

from dataclasses import dataclass
import re
import sys

NODE_LABEL_START = 'AAA'
NODE_LABEL_END = 'ZZZ'

INSTRUCTION_LEFT = 'L'
INSTRUCTION_RIGHT = 'R'
INSTRUCTIONS = {INSTRUCTION_LEFT, INSTRUCTION_RIGHT}

@dataclass
class Node:
    label: str
    left: str
    right: str

Network = dict[str, Node]

def main():
    instructions, nodes = sys.stdin.read().split('\n\n')
    network = parse_nodes(nodes)
    solution = travel_step_count(network, instructions)
    print(solution)

def parse_nodes(string: str) -> Network:
    lines = string.split('\n')
    lines = filter(None, lines)
    nodes = map(parse_node, lines)
    return dict(map(lambda node: (node.label, node), nodes))

def parse_node(string: str) -> Node:
    match = re.match(R'(?P<label>[A-Z]{3}) = \((?P<left>[A-Z]{3}), (?P<right>[A-Z]{3})\)', string)
    assert match is not None, string
    label = match.group('label')
    left = match.group('left')
    right = match.group('right')
    return Node(label, left, right)

def travel_step_count(network: Network, instructions: str) -> int:
    step_count = 0
    node = network[NODE_LABEL_START]
    while node.label != NODE_LABEL_END:
        instruction = instructions[step_count % len(instructions)]
        assert instruction in INSTRUCTIONS, instruction
        if instruction == INSTRUCTION_LEFT:
            node = network[node.left]
        else:
            node = network[node.right]
        step_count += 1
    return step_count

if __name__ == '__main__':
    main()
