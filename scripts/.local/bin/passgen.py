#!/usr/bin/env python3
import sys
import random
import base64
import secrets
from string import punctuation

K = 7

def salt(string, k):
    symbols = list(punctuation)
    indexs = [ string.index(x) for x in random.choices(string, k=k)]
    _string = list(string)
    for i in indexs:
        _string[i] = random.choice(symbols)

    string = ''.join(_string)
    return string


if __name__ == "__main__":
    bits = secrets.randbits(150)
    bits_hex = hex(bits)[2:]
    
    if len(sys.argv) > 2:
        print("Usage: %s <k_symbols>".format(sys.argv[0]))
    elif len(sys.argv) == 1:
        print(salt(string=bits_hex, k=K))
    elif len(sys.argv[1]) is not None:
        print(salt(string=bits_hex, k=int(sys.argv[1])))
