#! /usr/bin/env python3

import sys
import re

# UUIDs and stuff look roughly like this.
# A bunch of letters, numbers, and certain symbols, not starting or ending with
# a symbol
r = re.compile(r'([a-z0-9][a-z0-9-]{7,50}[a-z0-9])', re.I)

# Tries to parse out an ID from towards the end of a string
def guess_id(string):
    # Reverse the string, we'll search from the end
    reversed = line[::-1]

    # Match the regex
    match = r.search(reversed)

    if match == None:
        return ''

    # Re-reverse the result
    return match.group(1)[::-1]

for line in sys.stdin:
    # Just one line'll do
    print(guess_id(line), end='')
    break
